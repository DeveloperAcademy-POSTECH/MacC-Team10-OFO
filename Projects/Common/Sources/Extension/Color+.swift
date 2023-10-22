//
//  Color+.swift
//  Common
//
//  Created by Ha Jong Myeong on 10/23/23.
//

import SwiftUI

// 컬러코드 색 변환을 위한 extension
extension Color {
    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var hexInt: UInt64 = 0

        Scanner(string: hexString).scanHexInt64(&hexInt)
        let alpha, red, green, blue: UInt64
        switch hexString.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (hexInt >> 8) * 17, (hexInt >> 4 & 0xF) * 17, (hexInt & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, hexInt >> 16, hexInt >> 8 & 0xFF, hexInt & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (hexInt >> 24, hexInt >> 16 & 0xFF, hexInt >> 8 & 0xFF, hexInt & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: Double(alpha) / 255
        )
    }
}
