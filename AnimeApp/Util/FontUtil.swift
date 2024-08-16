//
//  FontUtil.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 16.08.2024.
//

import Foundation
import SwiftUI

enum FontWeight {
    case light
    case regular
    case medium
    case semiBold
    case bold
    case black
    case extraLight
    case extraBold
}

extension Font {
    static let customFont: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .light:
            Font.custom("Onest-Regular_Light", size: size)
        case .regular:
            Font.custom("Onest-Regular", size: size)
        case .medium:
            Font.custom("Onest-Regular_Medium", size: size)
        case .semiBold:
            Font.custom("Onest-Regular_SemiBold", size: size)
        case .bold:
            Font.custom("Onest-Regular_Bold", size: size)
        case .black:
            Font.custom("Onest-Regular_Black", size: size)
        case .extraLight:
            Font.custom("Onest-Regular_ExtraLight", size: size)
        case .extraBold:
            Font.custom("Onest-Regular_ExtraBold", size: size)
        }
    }
}

extension Text {
    func customFont(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        return font(.customFont(fontWeight ?? .regular, size ?? 16))
    }
}
