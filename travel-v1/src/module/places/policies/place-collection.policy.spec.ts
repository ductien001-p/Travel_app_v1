import { PlaceCollectionPolicy } from './place-collection.policy';
import { PlacePolicyError } from './policy.error';

describe('PlaceCollectionPolicy', () => {
  it('rejects an empty membership and a collection the user does not own', () => {
    expect(() =>
      PlaceCollectionPolicy.assertMembership([], new Set(['a'])),
    ).toThrow(PlacePolicyError);
    try {
      PlaceCollectionPolicy.assertMembership(['missing'], new Set(['a']));
      fail('expected forbidden collection');
    } catch (error) {
      expect((error as PlacePolicyError).code).toBe('COLLECTION_FORBIDDEN');
    }
  });

  it('blocks the owner from rating or copying their own collection', () => {
    expect(() =>
      PlaceCollectionPolicy.assertCanRate('owner', 'owner', 'PUBLIC'),
    ).toThrow(PlacePolicyError);
    try {
      PlaceCollectionPolicy.assertCanCopy('owner', 'owner', 'PUBLIC');
      fail('expected copy own');
    } catch (error) {
      expect((error as PlacePolicyError).code).toBe('COPY_OWN_COLLECTION');
    }
  });

  it('blocks rating and copying a private collection', () => {
    expect(() =>
      PlaceCollectionPolicy.assertCanRate('owner', 'other', 'PRIVATE'),
    ).toThrow(PlacePolicyError);
    expect(() =>
      PlaceCollectionPolicy.assertCanRead('owner', 'other', 'PRIVATE'),
    ).toThrow(PlacePolicyError);
    expect(() =>
      PlaceCollectionPolicy.assertCanRead('owner', 'owner', 'PRIVATE'),
    ).not.toThrow();
  });

  it('allows a public collection to be rated by someone else', () => {
    expect(() =>
      PlaceCollectionPolicy.assertCanRate('owner', 'other', 'PUBLIC'),
    ).not.toThrow();
    expect(() => PlaceCollectionPolicy.assertRatingValue(0)).toThrow(
      PlacePolicyError,
    );
    expect(() => PlaceCollectionPolicy.assertRatingValue(5)).not.toThrow();
  });
});
