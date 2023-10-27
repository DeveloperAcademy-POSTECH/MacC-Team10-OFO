//
//  MainDetailView.swift
//  Feature
//
//  Created by Eojin Choi on 2023/10/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI

struct MainDetailView: View {

    @ObservedObject var observable = MainDetailViewObservedObject()

    var body: some View {
        ZStack {
            Color(red: 24 / 255, green: 26 / 255, blue: 31 / 255)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                userTotalSummaryCell
                userLevelSummaryCell
                Spacer()
            }
            .navigationBarTitle("기록 요약", displayMode: .inline)
        }
        .foregroundColor(.white)
    }

    var userTotalSummaryCell: some View {
        Rectangle()
            .foregroundColor(Color(red: 47 / 255, green: 48 / 255, blue: 54 / 255))
            .cornerRadius(4)
            .frame(height: 206)
            .overlay {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("전체")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(18)
                    Spacer()
                    VStack(spacing: 14) {
                        HStack {
                            Text("총 활동량")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(String(format: "%.0f", observable.playerStatistics.totalDistanceCovered)) KM")
                                .font(.system(size: 14))
                        }
                        HStack {
                            Text("총 칼로리 소모량")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(String(format: "%.0f", observable.playerStatistics.totalCalories)) kcal")
                                .font(.system(size: 14))
                        }
                        HStack {
                            Text("누적 경기 수")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(observable.playerStatistics.totalPlay) 경기")
                                .font(.system(size: 14))
                        }
                        HStack {
                            Text("누적 플레이 타임")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            Spacer()
                            Text("21H 32M")
                                .font(.system(size: 14))
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 24)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 30)
    }

    var userLevelSummaryCell: some View {
        Rectangle()
            .foregroundColor(Color(red: 47 / 255, green: 48 / 255, blue: 54 / 255))
            .cornerRadius(4)
            .frame(height: 400)
            .overlay {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("레벨")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(18)
                    VStack {
                        Spacer()
                        HStack(spacing: 0) {
                            Text("좀 더 논의해 봅시다.")
                                .font(.system(size: 14))
                        }
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 16)
    }
}
