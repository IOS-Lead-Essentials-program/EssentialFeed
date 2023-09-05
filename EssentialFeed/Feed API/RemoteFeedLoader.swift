//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Neddy Ksenia Gonzalez Siles on 25/8/23.
//

import Foundation

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public init(url: URL , client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    /* Void = { _ in } = it has a default closure,
    to not break the other tests */
    public func load(completion: @escaping
                     (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                // self --> could cause retained cycles.
                completion(FeedItemsMapper.map(data, from: response))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

