//
//  TextUtil.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 15.07.2024.
//

import SwiftUI

extension String {
    func cleanDescription() -> Text {
        var resultingText = Text("")

        var italics = false
        var bold = false

        let separators = CharacterSet(charactersIn: "<>")
        let stringArray = components(separatedBy: separators)

        for index in 0 ..< stringArray.count {
            var tempText = Text(stringArray[index])

            if stringArray[index] == "br" {
                tempText = Text("")
            } else if stringArray[index] == "i" {
                italics = true
                continue
            } else if stringArray[index] == "/i" {
                italics = false
                continue
            } else if stringArray[index] == "b" {
                bold = true
                continue
            } else if stringArray[index] == "/b" {
                bold = false
                continue
            }

            if italics, stringArray[index] != "br", stringArray[index] != "/i", stringArray[index] != "b" {
                tempText = tempText.italic()
            }

            if bold, stringArray[index] != "br", stringArray[index] != "/i", stringArray[index] != "b" {
                tempText = tempText.bold()
            }

            resultingText = resultingText + tempText
        }

        return resultingText
    }
}
