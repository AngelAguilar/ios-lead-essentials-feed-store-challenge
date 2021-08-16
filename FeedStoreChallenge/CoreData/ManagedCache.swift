//
//  ManagedCache.swift
//  FeedStoreChallenge
//
//  Created by Angel Aguilar on 8/15/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

@objc(ManagedCache)
class ManagedCache: NSManagedObject {
	@NSManaged var timestamp: Date
	@NSManaged var feed: NSOrderedSet
}

extension ManagedCache {
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
