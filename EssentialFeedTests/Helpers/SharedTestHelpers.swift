//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Neddy Ksenia Gonzalez Siles on 28/12/23.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}