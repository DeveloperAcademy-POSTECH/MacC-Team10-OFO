//
//  ImageLoader.swift
//  Common
//
//  Created by Ha Jong Myeong on 10/23/23.
//

import SwiftUI

// 다른 모듈에서 이미지 불러오기
public class ImageLoader {
    public static func loadImage(named imageName: String) -> Image? {
        guard let uiImage = UIImage(named: imageName, in: Bundle(for: ImageLoader.self), compatibleWith: nil) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}
