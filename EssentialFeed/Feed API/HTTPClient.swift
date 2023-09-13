//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Neddy Ksenia Gonzalez Siles on 4/9/23.
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
