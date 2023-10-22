//
//  RecordView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 10/22/23.
//

import SwiftUI
import Common

public struct RecordView: View {
    let recordCounts: [String: Int] = [
        "2023년 9월": 6,
        "2023년 8월": 7
    ]

//    이미지 데이터가 없는 경우 mock
//    let recordCounts: [String: Int] = [:]

    public init() {}

    public var body: some View {
        NavigationView {
            // 이미지 데이터가 없는 경우
            if recordCounts.isEmpty {
                VStack {
                    Spacer()
                    Text("아직 운동 기록이 존재하지 않아요.")
                        .font(.subheadline)
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(recordCounts.keys.sorted(by: >), id: \.self) { month in
                            Section(header: Text(month).font(.subheadline)) {
                                RecordGrid(recordCount: recordCounts[month, default: 0], recordMonth: month.replacingOccurrences(of: "년 ", with: "_").replacingOccurrences(of: "월", with: ""))
                                    .padding(.bottom, 15)
                            }
                        }
                    }
                    .padding(.top, 40)
                    .navigationTitle("갤러리")
                }
            }
        }
    }
}

// 레코드 그리드
private struct RecordGrid: View {
    let recordCount: Int
    let recordMonth: String

    private var rows: Int {
        (recordCount + 3) / 4
    }

    // 기기별 사이즈 대응
    private var imageDimensions: (width: CGFloat, height: CGFloat) {
        let sidePadding: CGFloat = 5
        let totalSpacing: CGFloat = sidePadding * 2 + 3 * 10
        let imageWidth = (UIScreen.main.bounds.width - totalSpacing) / 4
        let imageHeight = imageWidth * 1.77
        return (imageWidth, imageHeight)
    }

    private func imageNameForIndex(_ index: Int) -> String {
        "\(recordMonth)_\(index + 1)"
    }

    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<rows, id: \.self) { rowIndex in
                HStack {
                    let startIndex = rowIndex * 4
                    let endIndex = min(startIndex + 4, recordCount)

                    // 실 이미지 표시
                    ForEach(startIndex..<endIndex, id: \.self) { index in
                        if let img = ImageLoader.loadImage(named: imageNameForIndex(index)) {
                            img
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imageDimensions.width, height: imageDimensions.height)
                                .background(Color.yellow)
                                .cornerRadius(4)
                        } else {
                            Image(systemName: "photo") 
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imageDimensions.width, height: imageDimensions.height)
                        }
                    }
//                    // 실 이미지 표시
//                    ForEach(startIndex..<endIndex, id: \.self) { _ in
//
//
//                            Image("23_8_1")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: imageDimensions.width, height: imageDimensions.height)
//                                .background(Color.yellow)
//                                .cornerRadius(4)
//                        }

                    // 투명 이미지(left align 목적)
                    ForEach(endIndex..<startIndex + 4, id: \.self) { _ in
                        Color.clear
                            .frame(width: imageDimensions.width, height: imageDimensions.height)
                    }
                }
            }
        }
    }
}

#Preview {
    RecordView()
}
