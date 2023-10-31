//
//  RecordView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 10/22/23.
//

import SwiftUI
import Common

public struct RecordView: View {

    public var body: some View {
        NavigationView {
            ScrollView {
                // 전체 누적 정보(2x2 그리드)
                HStack {
                    Text("전체")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                    Spacer()
                }
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 11),
                                    GridItem(.flexible(), spacing: 12)],
                          spacing: 10) {
                    OverallRecordCell(titleText: Text("경기"), overallSumData: Text("121"))
                    OverallRecordCell(titleText: Text("누적 칼로리"), overallSumData: Text("156,654"))
                    OverallRecordCell(titleText: Text("누적 플레이 타임"), overallSumData: Text("217시간 31분"))
                    OverallRecordCell(titleText: Text("누적 이동거리(KM)"), overallSumData: Text("366.6"))
                }
                          .padding(.leading, 20)
                          .padding(.trailing, 20)

                // 경기별 정보(동적으로 경기별 기록 셀 추가)
                HStack {
                    Text("경기")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.bottom, 12)

                DailyRecordCell(dailyRecordDate: Text("2023년 10월 30일"),
                                dailyRecordDay: Text("화요일 경기"),
                                dailyRecordTime: Text("1시간 57분 31초"),
                                dailyRecordCalorie: Text("1,200 칼로리"),
                                dailyRecordDistance: Text("3.45KM"))
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }.background(Color(.systemGroupedBackground))
                .toolbar {
                    Button {
                        print("tap!")
                    } label: {
                        Label("Profile", systemImage: "ellipsis.circle")
                    }
                }
        }
    }
}

// 전체 누적 정보별 Cell
public struct OverallRecordCell: View {

    private var titleText: Text = Text("")
    private var overallSumData: Text = Text("")

    public init(titleText: Text,
                overallSumData: Text) {
        self.titleText = titleText
        self.overallSumData = overallSumData
    }

    public var body: some View {
        VStack {
            HStack {
                titleText
                    .font(.system(size: 12))
                    .foregroundStyle(Color(red: 0.4, green: 0.4, blue: 0.4))
                Spacer()
            }
            .padding(.top, 12)
            .padding(.leading, 12)
            Spacer()
            HStack {
                Spacer()
                overallSumData
                    .padding(.bottom, 12)
                    .padding(.trailing, 12)
                    .font(.body)
                    .fontWeight(.bold)
            }
        }
        .frame(height: 90)
        .background(Color.white)
        .cornerRadius(12)
    }

}

// 개별 경기별 Cell
public struct DailyRecordCell: View {

    private var dailyRecordDate: Text = Text("2023년 10월 30일")
    private var dailyRecordDay: Text = Text("화요일 경기")
    private var dailyRecordTime: Text = Text("1시간 57분 31초")
    private var dailyRecordCalorie: Text = Text("1,200 칼로리")
    private var dailyRecordDistance: Text = Text("3.45KM")

    public init(dailyRecordDate: Text,
                dailyRecordDay: Text,
                dailyRecordTime: Text,
                dailyRecordCalorie: Text,
                dailyRecordDistance: Text) {
        self.dailyRecordDate = dailyRecordDate
        self.dailyRecordDay = dailyRecordDay
        self.dailyRecordTime = dailyRecordTime
        self.dailyRecordCalorie = dailyRecordCalorie
        self.dailyRecordDistance = dailyRecordDistance
    }

    public var body: some View {
        VStack {
            HStack {
                dailyRecordDate
                    .font(.system(size: 14))
                    .foregroundStyle(Color(red: 0.26, green: 0.26, blue: 0.26))
                Spacer()
                dailyRecordDay
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .padding(.trailing, 16)
            }
            .padding(.top, 11)
            .padding(.leading, 16)

            Spacer()

            VStack {
                HStack {
                    dailyRecordCalorie
                        .padding(.leading, 16)
                        .padding(.trailing, 4)
                        .fontWeight(.bold)
                    Text("/ 1,350 칼로리")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    dailyRecordDistance
                        .padding(.leading, 16)
                        .padding(.trailing, 4)
                        .fontWeight(.bold)
                    Text("/ 4KM")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    Spacer()
                    dailyRecordTime
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .padding(.trailing, 16)
                }
                .padding(.bottom, 8)
            }
            .padding(.top, 11)

        }
        .frame(height: 138)
        .background(Color.white)
        .cornerRadius(12)
    }

}
