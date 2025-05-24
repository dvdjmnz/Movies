//
//  TvShowsRepository.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol TvShowsRepository {
    func getTvShows(genre: Int) -> Observable<Page<TvShow>>
    func getTvShowDetails(tvShowId: Int) -> Observable<TvShowDetails>
}

