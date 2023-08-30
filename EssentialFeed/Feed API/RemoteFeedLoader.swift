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
    case success(HTTPURLResponse)
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
    
    public init(url: URL , client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    /* Void = { _ in } = it has a default closure,
    to not break the other tests */
    public func load(completion: @escaping
                     (Error) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .success:
                completion(.invalidData)
            case .failure:
                completion(.connectivity)
            }
        }
    }
}
