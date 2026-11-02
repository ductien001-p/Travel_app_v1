import { ForbiddenException } from '@nestjs/common';
import { TripGateway } from './gateway';

describe('TripGateway', () => {
  function setup() {
    const roomEmit = jest.fn();
    const socketsLeave = jest.fn();
    const roomSockets = [
      { data: { userId: 'user-1' }, leave: jest.fn() },
      { data: { userId: 'user-2' }, leave: jest.fn() },
      { data: { userId: 'user-1' }, leave: jest.fn() },
    ];
    const server = {
      to: jest.fn().mockReturnValue({ emit: roomEmit }),
      in: jest.fn().mockReturnValue({
        fetchSockets: jest.fn().mockResolvedValue(roomSockets),
        socketsLeave,
      }),
    };
    const messages = {
      createMessage: jest.fn().mockResolvedValue({ id: 'message-1' }),
    };
    const gateway = new TripGateway(
      {} as never,
      messages as never,
      {} as never,
    );
    gateway.server = server as never;
    const socket = { data: { userId: 'user-1' }, emit: jest.fn() };
    return {
      gateway,
      server,
      messages,
      socket,
      roomEmit,
      roomSockets,
      socketsLeave,
    };
  }

  describe('trip:message:send', () => {
    it('stores a trimmed TEXT message and broadcasts it to the trip room', async () => {
      const { gateway, messages, socket, server, roomEmit } = setup();

      await gateway.handleSendMessage(socket as never, {
        tripId: 'trip-1',
        content: '  hello  ',
      });

      expect(messages.createMessage).toHaveBeenCalledWith(
        'trip-1',
        'user-1',
        'hello',
        undefined,
      );
      expect(server.to).toHaveBeenCalledWith('trip:trip-1');
      expect(roomEmit).toHaveBeenCalledWith('trip:message', {
        id: 'message-1',
      });
    });

    it('accepts a JSON string payload with an IMAGE message', async () => {
      const { gateway, messages, socket } = setup();

      await gateway.handleSendMessage(
        socket as never,
        JSON.stringify({
          tripId: 'trip-1',
          content: 'media-1',
          messageType: 'IMAGE',
        }),
      );

      expect(messages.createMessage).toHaveBeenCalledWith(
        'trip-1',
        'user-1',
        'media-1',
        'IMAGE',
      );
    });

    it.each([
      [
        'a SYSTEM message',
        { tripId: 't', content: 'x', messageType: 'SYSTEM' },
      ],
      ['blank content', { tripId: 't', content: '   ' }],
      ['content over 2000 chars', { tripId: 't', content: 'a'.repeat(2001) }],
      ['a missing tripId', { content: 'hi' }],
      ['unknown fields', { tripId: 't', content: 'hi', senderId: 'spoof' }],
      ['an array', [{ tripId: 't', content: 'hi' }]],
      ['malformed JSON', '{not json'],
    ])('rejects %s without touching the database', async (_label, payload) => {
      const { gateway, messages, socket } = setup();

      await gateway.handleSendMessage(socket as never, payload);

      expect(messages.createMessage).not.toHaveBeenCalled();
      expect(socket.emit).toHaveBeenCalledWith('trip:error', {
        message: 'Invalid message payload',
      });
    });

    it('rejects unauthenticated sockets', async () => {
      const { gateway, messages, socket } = setup();
      socket.data.userId = undefined as never;

      await gateway.handleSendMessage(socket as never, {
        tripId: 'trip-1',
        content: 'hi',
      });

      expect(messages.createMessage).not.toHaveBeenCalled();
      expect(socket.emit).toHaveBeenCalledWith('trip:error', {
        message: 'Unauthorized',
      });
    });

    it('forwards the message of an expected HTTP error', async () => {
      const { gateway, messages, socket } = setup();
      messages.createMessage.mockRejectedValue(
        new ForbiddenException('Active trip membership required'),
      );

      await gateway.handleSendMessage(socket as never, {
        tripId: 'trip-1',
        content: 'hi',
      });

      expect(socket.emit).toHaveBeenCalledWith('trip:error', {
        message: 'Active trip membership required',
      });
    });

    it('hides the details of unexpected errors', async () => {
      const { gateway, messages, socket } = setup();
      messages.createMessage.mockRejectedValue(
        new Error('connection to db-host:5432 refused'),
      );
      jest
        .spyOn(
          (gateway as unknown as { logger: { error: () => void } }).logger,
          'error',
        )
        .mockImplementation(() => undefined);

      await gateway.handleSendMessage(socket as never, {
        tripId: 'trip-1',
        content: 'hi',
      });

      expect(socket.emit).toHaveBeenCalledWith('trip:error', {
        message: 'Internal server error',
      });
    });
  });

  it('removes only the sockets of the given user from the trip room', async () => {
    const { gateway, server, roomSockets } = setup();

    await gateway.removeUserFromTripRoom('trip-1', 'user-1');

    expect(server.in).toHaveBeenCalledWith('trip:trip-1');
    expect(roomSockets[0].leave).toHaveBeenCalledWith('trip:trip-1');
    expect(roomSockets[1].leave).not.toHaveBeenCalled();
    expect(roomSockets[2].leave).toHaveBeenCalledWith('trip:trip-1');
  });

  it('empties the trip room when the trip is closed', () => {
    const { gateway, socketsLeave } = setup();

    gateway.closeTripRoom('trip-1');

    expect(socketsLeave).toHaveBeenCalledWith('trip:trip-1');
  });
});
