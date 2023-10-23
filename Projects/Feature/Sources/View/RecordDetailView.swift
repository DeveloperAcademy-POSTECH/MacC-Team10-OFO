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
    @StateObject var observedObject: RecordDetailObservedObject

    var body: some View {
        ScrollView {
            certifyingImageHeader
            CertifyingImageButton(observedObject: observedObject)
        }
    }
}

extension RecordDetailView {
    private var certifyingImageHeader: some View {
        HStack {
            Text("인증 샷")
                .padding(.horizontal)
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
            case .success:
                observedObject.certifyingImage
                    .resizable()
                    .frame(height: 500)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
            case .loading:
                ProgressView()
            case .empty:
                ZStack {
                    observedObject.certifyingImage
                        .resizable()
                        .frame(height: 500)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
//                    Text("오늘의 인증샷을 추가해주세요")
//                        .foregroundStyle(.white)
                }
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }

        })
        .padding()
        .confirmationDialog("title", isPresented: $observedObject.isActionSheetShowing) {
            if observedObject.certifyingImage == Image(asset: CommonAsset._2387) {
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
                    observedObject.certifyingImage = Image(asset: CommonAsset._2387)
                    observedObject.updateRecord(image: nil)
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
