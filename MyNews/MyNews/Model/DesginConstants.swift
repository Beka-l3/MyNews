//
//  DesginConstants.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import UIKit


protocol Fonts {
    var appTitleFont: UIFont {get}
    var developerTitleFont: UIFont {get}
}

extension Fonts {
    var appTitleFont: UIFont { UIFont(name: "TimesNewRomanPS-BoldItalicMT", size: 72) ?? .boldSystemFont(ofSize: 36) }
    var developerTitleFont: UIFont { .systemFont(ofSize: 14) }
}


protocol Colors {
    var dominantColor: UIColor {get}
    var secondaryColor: UIColor {get}
    var focusColor: UIColor {get}
    
    var separatorColor: UIColor {get}
    var focusSeparatorColor: UIColor {get}
}

extension Colors {
    var dominantColor: UIColor { .white }
    var secondaryColor: UIColor { .black }
    var focusColor: UIColor { .systemOrange }
    
    var separatorColor: UIColor {UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)}
    var focusSeparatorColor: UIColor {.systemRed}
}


protocol HIG {
    var smallPadding: CGFloat {get}
    var padding: CGFloat {get}
    var largePadding: CGFloat {get}
    
    var smallSeparatorHeight: CGFloat {get}
    var separatorHeight: CGFloat {get}
    var largeSeparatorHeight: CGFloat {get}
    
    var newsCellHeight: CGFloat {get}
}

extension HIG {
    var smallPadding: CGFloat {8}
    var padding: CGFloat {16}
    var largePadding: CGFloat {32}
    
    var smallSeparatorHeight: CGFloat {4}
    var separatorHeight: CGFloat {8}
    var largeSeparatorHeight: CGFloat {12}
    
    var newsCellHeight: CGFloat {280}
}
