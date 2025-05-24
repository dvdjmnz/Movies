//
//  GenresRepository.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol GenresRepository {
    func getMovieGenres() -> Observable<[Genre]>
    func getTvShowsGenres() -> Observable<[Genre]>
}
