//
//  ManagedCacheImage.swift
//  FeedStoreChallenge
//
//  Created by Angel Aguilar on 8/15/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

@objc(ManagedFeedImage)
class ManagedFeedImage: NSManagedObject {
	@NSManaged var id: UUID
	@NSManaged var imageDescription: String?
	@NSManaged var location: String?
	@NSManaged var url: URL
	@NSManaged var cache: ManagedCache
}

extension ManagedFeedImage {
	var local: LocalFeedImage {
		return LocalFeedImage(
			id: id,
			description: imageDescription,
			location: location,
			url: url
		)
	}
}
