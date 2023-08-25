//
//  RemoteFeedLoaderTests.swift
//  RemoteFeedLoaderTests
//
//  Created by Neddy Ksenia Gonzalez Siles on 25/8/23.
//

import XCTest
import EssentialFeed

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestsDataFromURL() {
        /* To set the url you could you do it through Dependency injection or Singleton
         Dependency injection: constructor, property or method injection.
         But there's no need for a singleton, cause it creates tight coupling,
         and there could be more than one API client.
         */
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
         
        XCTAssertEqual(client.requestedURL, url)
    }
    
    func test_load_requestsDataFromURLTwice() {
        /* To set the url you could you do it through Dependency injection or Singleton
         Dependency injection: constructor, property or method injection.
         But there's no need for a singleton, cause it creates tight coupling,
         and there could be more than one API client.
         */
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        sut.load()
         
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    // MARK: Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        var requestedURLs = [URL]()
        
        func get(from url: URL) {
            requestedURL = url
            requestedURLs.append(url)
        }
    }
}
