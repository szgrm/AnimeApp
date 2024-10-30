//
//  UserInfo.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 29.10.2024.
//

import AnilistAPI
import Foundation

struct UserInfo {
    let id: Int
    let avatar: String
    let bannerImage: String?
    let name: String
    let favoriteAnimes: [Anime]?
    let favoriteCharacters: [Characters]?

    init(from userInfoDTO: UserInfoDTO) {
        id = userInfoDTO.id
        avatar = (userInfoDTO.avatar?.large)!
        bannerImage = userInfoDTO.bannerImage
        name = userInfoDTO.name
        favoriteAnimes = userInfoDTO.favourites?.anime?.nodes?.compactMap {
            Anime(from: ($0?.fragments.animeSmall)!)
        }
        favoriteCharacters = userInfoDTO.favourites?.characters?.nodes?.compactMap {
            Characters(from: ($0?.fragments.characterSmall)!)
        }
    }
}
