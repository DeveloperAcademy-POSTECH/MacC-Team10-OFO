//
//  BarProgressStyle.swift
//  Common
//
//  Created by 한지석 on 10/23/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI

public struct BarProgressStyle: ProgressViewStyle {

    public var color: Color
    var height: Double = 10.0
    var labelFontStyle: Font = .body

    public init(color: Color) {
        self.color = color
    }

    public func makeBody(configuration: Configuration) -> some View {

        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { geometry in
            VStack(alignment: .leading) {
                configuration.label
                    .font(labelFontStyle)
                RoundedRectangle(cornerRadius: 8.0)
                    .fill(Color(uiColor: .darkGray))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8.0)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {
                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                    }
            }
        }
    }
}
