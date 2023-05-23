//
//  WDFont.swift
//  FasterToilet
//
//  Created by 심상현 on 2023/05/22.
//

import UIKit

func setupDefaultFont() {
    guard let fontURL = Bundle.main.url(forResource: "NotoSansKR-Regular", withExtension: "ttf"),
          let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
        return
    }
    let font = CGFont(fontDataProvider)!
    var error: Unmanaged<CFError>?
    if !CTFontManagerRegisterGraphicsFont(font, &error) {
        if let error = error?.takeUnretainedValue() {
            let errorDescription = CFErrorCopyDescription(error) as String
            print("Failed to load font: \(errorDescription)")
        }
        return
    }
    
    let fontName = "NotoSansKR-Regular"
    guard let font = UIFont(name: fontName, size: 17) else {
        return
    }
    
    let textStyles: [UIFont.TextStyle] = [.body, .callout, .caption1, .caption2, .footnote, .headline, .subheadline, .title2, .title3]
    for textStyle in textStyles {
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        let scaledFont = fontMetrics.scaledFont(for: font)
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: scaledFont
        ]
        UILabel.appearance().font = scaledFont
        UITextView.appearance().font = scaledFont
        UITextField.appearance().defaultTextAttributes = textAttributes
    }
}
