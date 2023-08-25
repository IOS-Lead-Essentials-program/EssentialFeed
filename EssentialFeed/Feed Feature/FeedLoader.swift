//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Neddy Ksenia Gonzalez Siles on 25/8/23.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
