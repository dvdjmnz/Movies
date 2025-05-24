//
//  DefaultTvShowsRepository.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

struct DefaultTvShowsRepository: TvShowsRepository {
    let tmdbDataSource: TmdbDataSource
    
    func getTvShows(genre: Int) -> Observable<Page<TvShow>> {
        tmdbDataSource.getTvShows(genre: genre).map { $0.toDomain() }
    }
    
    func getTvShowDetails(tvShowId: Int) -> Observable<TvShowDetails> {
        tmdbDataSource.getTvShowDetails(tvShowId: tvShowId).map { $0.toDomain() }
    }
}
