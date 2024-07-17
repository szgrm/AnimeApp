//
//  AnimeListRowView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import SwiftUI
import AnilistAPI
import NukeUI

struct AnimeListRowView: View {
    let anime: GetAnimesQuery.Data.Page.Medium
    
    var body: some View {
        HStack {
            LazyImage(url: URL(string: (anime.coverImage?.large)!)) { phase in
                if let coverImage = phase.image {
                    coverImage
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .frame(width: 100, height: 125)
                } else if phase.error != nil {
                    let _ = print(phase.error!)
                    Image(systemName: "questionmark.diamond")
                        .imageScale(.large)
                        .frame(width: 100, height: 125)
                } else {
                    ProgressView()
                }
            }
            
            VStack(alignment: .leading) {
                Text((anime.title?.english) ?? "No title")
                    .font(.system(size: 20))
                
                HStack {
                    ForEach(anime.genres?.prefix(3) ?? [], id: \.self) { genre in
                        Text(genre!)
                            .font(.system(size: 10))
                            .padding(3)
                            .background(.fill)
                            .clipShape(.capsule)
                    }
                }
                
                TextUtility.cleanDescription(anime.description ?? "")
                //Text(anime.description?.htmlToString() ?? "")
                    .lineLimit(4)
                    .font(.system(size: 10))
                    .padding(.vertical, 5)
            }
        }
        .padding(.bottom, 5)
        
    }
}

//extension String {
//    func htmlToString() -> String {
//        return  try! NSAttributedString(data: self.data(using: .utf8)!,
//                                        options: [.documentType: NSAttributedString.DocumentType.html],
//                                        documentAttributes: nil).string
//    }
//}
