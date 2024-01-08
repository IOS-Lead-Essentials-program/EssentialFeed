//
//  LocalFeedItem.swift
//  EssentialFeed
//
//  Created by Neddy Ksenia Gonzalez Siles on 20/12/23.
//

import Foundation

/* Data Transfer Objects (DTO's). It looks like duplicate, but we allow them (LocalFeedItem vs. FeedItem) to change at their own pace.
 This removes strong coupling between modules.
 */
public struct LocalFeedImage: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL
    
    public init(id: UUID, description: String?, location: String?, url: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = url
    }
}
