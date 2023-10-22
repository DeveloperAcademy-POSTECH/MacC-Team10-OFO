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
    @State var showPicker = false

    var body: some View {
        ScrollView {
            HStack {
                Text("인증 샷")
                Spacer()
            }
//            Button(action: {
//                observedObject.isActionSheetShowing = true
//            }, label: {
//                Rectangle()
//                    .fill(Color.gray)
//                    .frame(height: 500)
//            })
//            .padding()
//            .confirmationDialog("title", isPresented: $observedObject.isActionSheetShowing) {
//                if observedObject.certifyingPhoto.isEmpty {
//                    Button {
//                        observedObject.certifyingPhoto = "사진"
//                        showPicker.toggle()
//                    } label: {
//                        Text("사진 추가")
//                    }
//                    PhotosPicker(selection: $observedObject.imageSelection,
//                                 matching: .images,
//                                 photoLibrary: .shared()) {
//                        Text("사진 진짜 추가")
//                    }
//                } else {
//                    Button {
//                        observedObject.certifyingPhoto = "사진"
//                    } label: {
//                        Text("사진 수정")
//                    }
//                    Button("사진 삭제", role: .destructive) {
//                        observedObject.certifyingPhoto = ""
//                        print("사진 삭제")
//                    }
//                }
//                Button("취소", role: .cancel) {
//                    print("tap cancel")
//                }
//            }
//            .photosPicker(isPresented: $showPicker, selection: $observedObject.imageSelection)

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
            if observedObject.certifyingImage == Image("") {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 500)
            } else {
                observedObject.certifyingImage
                    .resizable()
                    .frame(height: 500)
            }
        })
        .padding()
        .confirmationDialog("title", isPresented: $observedObject.isActionSheetShowing) {
            if observedObject.certifyingImage == Image("") {
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
                    observedObject.certifyingImage = Image("")
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
