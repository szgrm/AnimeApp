//
//  LoadingState.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 16.08.2024.
//

import Foundation

enum LoadingState {
    case loading
    case loaded
    case error(Error)
    case noResult
}
