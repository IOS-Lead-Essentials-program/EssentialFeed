//
//  RemoteFeedLoaderTests.swift
//  RemoteFeedLoaderTests
//
//  Created by Neddy Ksenia Gonzalez Siles on 25/8/23.
//

import XCTest
@testable import EssentialFeed

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}

class HTTPClient {
    static let shared = HTTPClient()
    
    private init() {}
    
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient.shared
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClient.shared
        /* To set the url you could you do it throug Dependency injection or Singleton
         Dependency injection: constructor, property or method injection.
         But there's no need for a singleton, cause there could be more than one API client.
         */
        let sut = RemoteFeedLoader()
        sut.load()
         
        XCTAssertNotNil(client.requestedURL)
    }
}
