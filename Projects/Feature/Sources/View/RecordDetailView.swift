//
//  RecordDetailView.swift
//  Feature
//
//  Created by 박승찬 on 2023/10/22.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI

struct RecordDetailView: View {
    @State var isActionSheetShowing = false
    @State var certifyingPhoto: String = ""

    var body: some View {
        ScrollView {
            HStack {
                Text("인증 샷")
                Spacer()
            }
            Button(action: {
                isActionSheetShowing = true
            }, label: {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 500)
            })
            .padding()
            .confirmationDialog("title", isPresented: $isActionSheetShowing) {
                if certifyingPhoto.isEmpty {
                    Button {
                        certifyingPhoto = "사진"
                    } label: {
                        Text("사진 추가")
                    }
                } else {
                    Button {
                        certifyingPhoto = "사진"
                    } label: {
                        Text("사진 수정")
                    }
                    Button("사진 삭제", role: .destructive) {
                        certifyingPhoto = ""
                        print("사진 삭제")
                    }
                }
                Button("취소", role: .cancel) {
                    print("tap cancel")
                }
            }
        }
    }
}

#Preview {
    RecordDetailView()
}
