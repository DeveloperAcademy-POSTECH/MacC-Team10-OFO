//
//  RecordDetailView.swift
//  Feature
//
//  Created by 박승찬 on 2023/10/22.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI
import PhotosUI
import Common

struct RecordDetailView: View {

    @StateObject var observedObject = RecordDetailObservedObject()

    var body: some View {
        ZStack {
            Color(red: 24 / 255, green: 26 / 255, blue: 31 / 255)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    HStack {
                        DonutChartView(distanceCovered: observedObject.distanceCoveredPercentage,
                                       calories: observedObject.caloriesPercentage,
                                       innerCircleSize: 60,
                                       outerCircleSize: 65,
                                       centerText: Text("10"))
                        recordSummaryView
                            .padding(.trailing, 28)
                    }
                    .frame(height: 160)
                    certifyingImageHeader
                    CertifyingImageButton(observedObject: observedObject)
                }
            }
        }
    }

    var recordSummaryView: some View {
        VStack(alignment: .leading, spacing: 0) {
            percentageRecord(type: .distanceCovered)
            percentageRecord(type: .calories)
                .padding(.top, 6)
            totalRecord(type: .distanceCovered)
                .padding(.top, 16)
            totalRecord(type: .calories)
                .padding(.top, 4)
        }
    }

    func percentageRecord(type: RecordType) -> some View {

        var title: String
        var subTitle: String
        var color: Color

        switch type {
        case .distanceCovered:
            title = "활동량 \(observedObject.distanceCoveredPercentage * 100)%"
            subTitle = "\(observedObject.record.distanceCovered) / 6.3 KM"
            color = Color(red: 169 / 255, green: 252 / 255, blue: 231 / 255)
        case .calories:
            title = "칼로리 \(observedObject.caloriesPercentage * 100)%"
            subTitle = "\(observedObject.record.calories) / 2,000 칼로리"
            color = Color(red: 255 / 255, green: 146 / 255, blue: 165 / 255)
        }

        return HStack(alignment: .top, spacing: 0) {
            Circle()
                .fill(color)
                .frame(width: 7, height: 7)
                .padding(.top, 6)
                .padding(.trailing, 20)
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(Font.system(size: 16, weight: .semibold))
                Text(subTitle)
                    .font(Font.system(size: 11, weight: .light))
                    .padding(.top, 2)
            }
        }
    }

    func totalRecord(type: RecordType) -> some View {

        var title: String
        var subTitle: String

        switch type {
        case .distanceCovered:
            title = "활동량"
            subTitle = "\(observedObject.record.distanceCovered) KM"
        case .calories:
            title = "소모 칼로리"
            subTitle = "\(observedObject.record.calories) 칼로리"
        }

        return HStack {
            Text(title)
                .font(Font.system(size: 12))
            Spacer()
            Text(subTitle)
                .font(Font.system(size: 14, weight: .semibold))
        }
    }

}

extension RecordDetailView {
    private var certifyingImageHeader: some View {
        HStack {
            Text("인증샷")
                .padding(.top, 20)
                .padding(.leading, 16)
            Spacer()
        }
    }
}

struct CertifyingImageButton: View {
    @ObservedObject var observedObject: RecordDetailObservedObject

    var body: some View {
        Button(action: {
            observedObject.isActionSheetShowing = true
        }, label: {
            switch observedObject.imageState {
            case .success(let image):
                image
                    .resizable()
                    .frame(height: 500)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
            case .loading:
                ProgressView()
            case .empty:
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                        .fill(.gray)
                        .frame(height: 500)
                        .frame(maxWidth: .infinity)
                    Text("오늘의 인증샷을 추가해주세요")
                        .foregroundStyle(.white)
                }
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }

        })
        .padding(.top, 4)
        .padding(.horizontal, 16)
        .confirmationDialog("title", isPresented: $observedObject.isActionSheetShowing) {
            if observedObject.imageSelection == nil {
                Button {
                    observedObject.showPhotoPicker.toggle()
                } label: {
                    Text("사진 추가")
                }
            } else {
                Button {
                    observedObject.showPhotoPicker.toggle()
                } label: {
                    Text("사진 수정")
                }
                Button("사진 삭제", role: .destructive) {
                    observedObject.imageSelection = nil
                    print("사진 삭제")
                }
            }
            Button("취소", role: .cancel) {
                print("tap cancel")
            }
        }
        .photosPicker(isPresented: $observedObject.showPhotoPicker, selection: $observedObject.imageSelection)
    }
}

#Preview {
    RecordDetailView()
}
