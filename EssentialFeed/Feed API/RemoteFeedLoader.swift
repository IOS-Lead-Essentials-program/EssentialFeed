//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Neddy Ksenia Gonzalez Siles on 25/8/23.
//

import Foundation

/* The enum helps have one of the options.
 (Error?,HTTPURLResponse?) Not like the code before where both could be nil
 or have value */
public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

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
                if response.statusCode == 200, let root = try?
                    JSONDecoder().decode(Root.self, from: data) {
                    completion(.success(root.items.map(
                        {$0.item}
                    )))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

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
