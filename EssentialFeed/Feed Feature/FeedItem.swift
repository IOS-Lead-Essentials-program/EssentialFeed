//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Neddy Ksenia Gonzalez Siles on 25/8/23.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
