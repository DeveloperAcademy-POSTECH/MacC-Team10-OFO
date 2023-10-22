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
                Button {

                } label: {
                    Text("사진 추가")
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
