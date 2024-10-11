//
//  ViewState.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 16.08.2024.
//

import Foundation

enum ViewState<T> {
    case initial
    case loading
    case loaded(T)
    case error(Error)
    case noResult
}
