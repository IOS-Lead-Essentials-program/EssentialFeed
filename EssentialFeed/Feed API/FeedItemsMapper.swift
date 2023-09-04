//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Neddy Ksenia Gonzalez Siles on 4/9/23.
//

import Foundation

// internal = only accesible to its own module. No other module has access to it.
internal final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [Item]
    }

    // This is the FeedItem that adapts to the RemoteFeedloader.
    private struct Item: Decodable {
        public let id: UUID
        public let description: String?
        public let location: String?
        public let image: URL
        
        var item: FeedItem {
            return FeedItem(id: id, description: description, location: location, imageURL: image)
        }
    }
    
    private static var OK_200: Int { return 200 }
    
    internal static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedItem] {
        guard response.statusCode == OK_200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.items.map{ $0.item }
    }
}


