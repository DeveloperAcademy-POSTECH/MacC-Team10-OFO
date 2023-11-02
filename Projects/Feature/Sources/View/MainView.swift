//
//  MainView.swift
//  Feature
//
//  Created by 한지석 on 10/23/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI
import Common
import Core
import SwiftData

enum RecordType {
    case distanceCovered
    case calories
}

struct MainView: View {

    @Environment(\.modelContext) var context
    @State private var observable: MainObservable

    @MainActor
    init(modelContext: ModelContext) {
        let observable = MainObservable(modelContext: modelContext)
        _observable = State(initialValue: observable)
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 24 / 255, green: 26 / 255, blue: 31 / 255)
                    .ignoresSafeArea()
                VStack {
                    if let player = observable.player {
                        Text("\(player.height)")
                    }
                    HStack {
                        Button {
                        } label: {
                            Text("update")
                        }
                        Button {
                        } label: {
                            Text("add")
                        }
                        Button {
                        } label: {
                            Text("fetch")
                        }
                    }


                    userExpSummaryCell
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Menu {
                            Button("헬스 정보 수정", action: { })
                            Button("목표 수정", action: { })
                            Button("앱 설정", action: { })
                        } label: {
                            Image(systemName: "person.circle")
                                .foregroundColor(.white)
                        }
                    }
                }
                .navigationTitle("기록")
            }
        }

    }

    var userExpSummaryCell: some View {
        Rectangle()
            .foregroundColor(Color(red: 47 / 255, green: 48 / 255, blue: 54 / 255))
            .cornerRadius(4)
            .frame(height: 240)
            .overlay {
                VStack(spacing: 0) {
                    NavigationLink {
                        MainDetailView()
                    } label: {
                        HStack(spacing: 0) {
                            Text("요약")
                                .fontWeight(.bold)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 18)
                    }
                    expProgressBar(type: .distanceCovered,
                                   value: 77)
                    .padding(.top, 20)
                    expProgressBar(type: .calories,
                                   value: 77)
                    .padding(.top, 25)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 40)
    }

    func expProgressBar(
        type: RecordType,
        value: Double
    ) -> some View {

        var title: String
        var color: Color
        var description: String

        switch type {
        case .distanceCovered:
            title = "활동량"
            color = Color(red: 169 / 255, green: 252 / 255, blue: 231 / 255)
            description = "다음 레벨까지 145KM 남았어요."
        case .calories:
            title = "칼로리"
            color = Color(red: 255 / 255, green: 146 / 255, blue: 165 / 255)
            description = "다음 레벨까지 60,000Kcal 남았어요."
        }
        return VStack(spacing: 0) {
            ProgressView(value: value,
                         total: 100) {
                Text(title)
                    .foregroundColor(.white)
            }
                         .progressViewStyle(BarProgressStyle(color: color))
                         .frame(height: 44)
            HStack {
                Spacer()
                Text(description)
                    .font(Font.system(size: 12))
                    .foregroundStyle(.white)
            }
            .frame(height: 22)
            .padding(.top, 8)
        }
        .padding(.horizontal, 18)
    }
}

//#Preview {
//    MainView()
//}
