//
//  RecordDetailView.swift
//  Feature
//
//  Created by 박승찬 on 2023/10/22.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI
import PhotosUI

struct RecordDetailView: View {
    @StateObject var observedObject = RecordDetailObservedObject()

    var body: some View {
        ScrollView {
            HStack {
                Text("인증 샷")
                Spacer()
            }

            CertifyingImageBtn(observedObject: observedObject)
        }
    }
}

struct CertifyingImageBtn: View {
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
                    .frame(maxWidth: .infinity)
                    .scaledToFit()

            case .loading:
                ProgressView()
            case .empty:
                Rectangle()
                    .frame(height: 500)
                    .frame(maxWidth: .infinity)
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }

        })
        .padding()
        .confirmationDialog("title", isPresented: $observedObject.isActionSheetShowing) {
            if observedObject.imageSelection == nil {
                Button {
                    observedObject.showPicker.toggle()
                } label: {
                    Text("사진 추가")
                }
            } else {
                Button {
                    observedObject.showPicker.toggle()
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
        .photosPicker(isPresented: $observedObject.showPicker, selection: $observedObject.imageSelection)
    }
}

#Preview {
    RecordDetailView()
}
