import { ensure } from './policy.error';
import type { PlaceCollectionVisibilityName } from './policy.types';

export class PlaceCollectionPolicy {
  static assertTitle(title: string): string {
    const trimmed = title.trim();
    ensure(
      trimmed.length >= 1 && trimmed.length <= 80,
      'INVALID_TITLE',
      'Title must be 1 to 80 characters',
    );
    return trimmed;
  }

  static assertOwner(ownerId: string, actorId: string): void {
    ensure(
      ownerId === actorId,
      'COLLECTION_FORBIDDEN',
      'You do not own this collection',
    );
  }

  static assertCanRead(
    ownerId: string,
    actorId: string,
    visibility: PlaceCollectionVisibilityName,
  ): void {
    if (ownerId === actorId) return;
    ensure(
      visibility === 'PUBLIC',
      'COLLECTION_FORBIDDEN',
      'This collection is private',
    );
  }

  static assertCanRate(
    ownerId: string,
    actorId: string,
    visibility: PlaceCollectionVisibilityName,
  ): void {
    ensure(
      ownerId !== actorId,
      'RATING_OWN_COLLECTION',
      'You cannot rate your own collection',
    );
    ensure(
      visibility === 'PUBLIC',
      'COLLECTION_NOT_PUBLIC',
      'Only a public collection can be rated',
    );
  }

  static assertCanCopy(
    ownerId: string,
    actorId: string,
    visibility: PlaceCollectionVisibilityName,
  ): void {
    ensure(
      ownerId !== actorId,
      'COPY_OWN_COLLECTION',
      'You cannot copy your own collection',
    );
    ensure(
      visibility === 'PUBLIC',
      'COLLECTION_NOT_PUBLIC',
      'Only a public collection can be copied',
    );
  }

  static assertRatingValue(rating: number): void {
    ensure(
      Number.isInteger(rating) && rating >= 1 && rating <= 5,
      'INVALID_RATING',
      'Rating must be an integer from 1 to 5',
    );
  }

  static assertMembership(
    collectionIds: readonly string[],
    ownedIds: ReadonlySet<string>,
  ): void {
    ensure(
      collectionIds.length > 0,
      'MEMBERSHIP_EMPTY',
      'Choose at least one collection',
    );
    ensure(
      new Set(collectionIds).size === collectionIds.length,
      'MEMBERSHIP_DUPLICATE',
      'Collection ids must be unique',
    );
    for (const id of collectionIds) {
      ensure(
        ownedIds.has(id),
        'COLLECTION_FORBIDDEN',
        'You do not own this collection',
        { collectionId: id },
      );
    }
  }
}
