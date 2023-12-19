//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Neddy Ksenia Gonzalez Siles on 19/12/23.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ items: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion)
}

/* Data Transfer Objects (DTO's). It looks like duplicate, but we allow them (LocalFeedItem vs. FeedItem) to change at their own pace.
 This removes strong coupling between modules.
 */
public struct LocalFeedItem: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
    
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}
