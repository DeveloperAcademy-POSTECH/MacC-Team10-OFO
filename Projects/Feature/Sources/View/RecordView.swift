//
//  RecordView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 10/22/23.
//

import SwiftUI
import Common

public struct RecordView: View {

    @ObservedObject var observable: RecordObservableObject

    let recordCounts: [String: Int] = [
        "2023년 9월": 6,
        "2023년 8월": 7
    ]

    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 100))
    ]

    //    mock ::: 이미지 데이터가 없는 경우
    //    let recordCounts: [String: Int] = [:]

    //    public init() {
    //
    //    }

    public var body: some View {
        NavigationView {
            // 이미지 데이터가 없는 경우
            ZStack {
                Color(red: 24 / 255, green: 26 / 255, blue: 31 / 255)
                    .ignoresSafeArea()
                if observedObject.records.isEmpty {
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
                                    RecordGrid(observedObject: observedObject, recordCount: recordCounts[month, default: 0],
                                               recordMonth: month.replacingOccurrences(of: "년 ", with: "_")
                                        .replacingOccurrences(of: "월", with: ""))
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
}

// 레코드 그리드
private struct RecordGrid: View {

    var observedObject: RecordObservableObject

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

    // mockImage ::: 추후 삭제 예정
    private let mockImages = [
        CommonAsset._2381,
        CommonAsset._2382,
        CommonAsset._2383,
        CommonAsset._2384,
        CommonAsset._2385,
        CommonAsset._2386,
        CommonAsset._2387,
        CommonAsset._2391,
        CommonAsset._2392,
        CommonAsset._2393,
        CommonAsset._2394,
        CommonAsset._2394,
        CommonAsset._2395,
        CommonAsset._2396

    ]

    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<rows, id: \.self) { rowIndex in
                HStack {
                    let startIndex = rowIndex * 4
                    let endIndex = min(startIndex + 4, recordCount)

                    // 실 이미지 표시
                    ForEach(startIndex..<endIndex, id: \.self) { index in
                        NavigationLink {
                            RecordDetailView(
                                observable:
                                    RecordDetailObservableObject(
                                        record: observedObject.records[index],
                                        delegate: observedObject, recordIndex: index
                                    )
                            )
                        } label: {
                            if let image = observedObject.records[index].image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: imageDimensions.width, height: imageDimensions.height)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
                            } else {
                                Image(asset: mockImages[6])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: imageDimensions.width, height: imageDimensions.height)
                                    .background(Color.yellow)
                                    .cornerRadius(4)
                            }
                        }
                    }

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
