//
//  MediaItem.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import Foundation

protocol MediaItem {
    var id: Int { get }
    var title: String { get }
    var voteAverage: String { get }
    var posterPath: URL? { get }
}

protocol MediaItemDetails {
    var id: Int { get }
    var primaryInfo: String { get }
    var secondaryInfo: String { get }
}

struct MediaItemWithDetails<Item: MediaItem, Details: MediaItemDetails> {
    let item: Item
    let details: Details?
}

// MARK: - Movie Extensions
extension Movie: MediaItem {}

extension MovieDetails: MediaItemDetails {
    var primaryInfo: String { "Budget: " + budget }
    var secondaryInfo: String { "Revenue: " + revenue }
}

// MARK: - TvShow Extensions
extension TvShow: MediaItem {
    var title: String { name }
}

extension TvShowDetails: MediaItemDetails {
    var primaryInfo: String { lastEpisodeName  }
    var secondaryInfo: String { lastAirDate }
}
