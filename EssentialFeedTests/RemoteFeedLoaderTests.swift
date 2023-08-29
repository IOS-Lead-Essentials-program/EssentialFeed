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
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
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
         
        XCTAssertEqual(client.requestedURLs, [url])
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
    
    func test_load_load_deliversErrorOnClientError() {
        // Arrange: given the sut and HTTP client spy
        let (sut, client) = makeSUT()
        
        /* Act: Tell the sut to load and complete the client's HTTP request
         with and error */
        var capturedError = [RemoteFeedLoader.Error]()
        sut.load { capturedError.append($0) }
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        XCTAssertEqual(capturedError, [.connectivity])
        
    }
    
    // MARK: Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (Error) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(error)
        }
    }
}
