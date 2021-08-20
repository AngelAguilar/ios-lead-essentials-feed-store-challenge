//
//  ManagedCache.swift
//  FeedStoreChallenge
//
//  Created by Angel Aguilar on 8/15/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

@objc(ManagedCache)
final class ManagedCache: NSManagedObject {
	@NSManaged var timestamp: Date
	@NSManaged var feed: NSOrderedSet
}

extension ManagedCache {
	var localFeed: [LocalFeedImage] {
		return feed.compactMap { ($0 as? ManagedFeedImage)?.local }
	}
}

extension ManagedCache {
	static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedCache {
		try find(in: context).map(context.delete)
		return ManagedCache(context: context)
	}

	static func find(in context: NSManagedObjectContext) throws -> ManagedCache? {
		let request = NSFetchRequest<ManagedCache>(entityName: ManagedCache.entity().name!)
		request.returnsObjectsAsFaults = false
		return try context.fetch(request).first
	}

	static func images(
		from feed: [LocalFeedImage],
		in context: NSManagedObjectContext
	) -> NSOrderedSet {
		NSOrderedSet(
			array: feed.map {
				let managedFeedImage = ManagedFeedImage(context: context)
				managedFeedImage.id = $0.id
				managedFeedImage.imageDescription = $0.description
				managedFeedImage.location = $0.location
				managedFeedImage.url = $0.url
				return managedFeedImage
			}
		)
	}
}
