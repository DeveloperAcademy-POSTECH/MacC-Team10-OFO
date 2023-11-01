//
//  RecordView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 10/22/23.
//

import Core
import os
import SwiftUI
import HealthKit
import HealthKitUI

public struct RecordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var workoutList = [HKWorkout]()
    @State private var selectedWorkout: HKWorkout?
    @State private var triggerAuthorization = false
    @State private var totalMatches: Int = 0
    @State private var totalCalories: Double = 0.0
    @State private var totalPlayTime: TimeInterval = 0.0
    @State private var totalDistance: Double = 0.0

    private let workoutManager = WorkoutManager.shared

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }

    private var weekdayWithMatchFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "EEEE 경기"
        return formatter
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                // 전체 누적 정보(2x2 그리드)
                OverallTitleText()
                OverallGrid(totalMatches: totalMatches, totalCalories: totalCalories, totalPlayTime: totalPlayTime, totalDistance: totalDistance)

                // 경기별 정보(동적으로 경기별 기록 셀 추가)
                MatchesTitleText()
                listViewOrEmpty()
                    .onAppear {
                        triggerAuthorization.toggle()
                    }
                    .healthDataAccessRequest(store: workoutManager.healthStore,
                                             shareTypes: workoutManager.typesToShare,
                                             readTypes: workoutManager.typesToRead,
                                             trigger: triggerAuthorization) { result in
                        switch result {
                        case .success:
                            Logger.shared.log("Successfully requested authorization.")
                            Task {
                                workoutList = await workoutManager.fetchTodaysWorkouts(workoutType: .soccer)
                                computeTotalMetrics(from: workoutList)
                            }
                        case .failure(let error):
                            Logger.shared.log("Failed to request authorization: \(error)")
                        }
                    }
            }.background(Color(.systemGroupedBackground))
                .toolbar {
                    Button {
                        Task {
                            workoutList = await workoutManager.fetchTodaysWorkouts(workoutType: .soccer)
                        }
                        print("Refresh!")
                    } label: {
                        Label("Profile", systemImage: "ellipsis.circle")
                    }
                }
        }
    }

    // 시,분,초 String 변환 메소드
    private func timeIntervalString(from start: Date, to end: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: start, to: end)

        guard let hour = components.hour,
              let minute = components.minute,
              let second = components.second else {
            return ""
        }

        var timeStrings = [String]()

        if hour > 0 {
            timeStrings.append("\(hour)시간")
        }
        if minute > 0 {
            timeStrings.append("\(minute)분")
        }
        if second > 0 || timeStrings.isEmpty {
            timeStrings.append("\(second)초")
        }

        return timeStrings.joined(separator: " ")
    }

    // 전체 데이터 합산 메소드
    private func computeTotalMetrics(from workouts: [HKWorkout]) {
        totalMatches = workouts.count
        totalCalories = workouts.reduce(0.0) { sum, workout in
            sum + workout.totalEnergy
        }
        totalPlayTime = workouts.reduce(0.0) { sum, workout in
            sum + workout.duration
        }
        totalDistance = workouts.reduce(0.0) { sum, workout in
            sum + workout.totalDistance
        }
    }

    // 개별 경기별 Cell
    @ViewBuilder
    private func listViewOrEmpty() -> some View {
        if workoutList.isEmpty {
            VStack {
                Text("Woop...").font(.title)
                Text("You don't have any soccer yet today.").padding()
            }
        } else {
            ForEach(workoutList, id: \.self) { workout in
                if UIDevice.current.userInterfaceIdiom == .phone {
                    VStack {
                        HStack {
                            Text(dateFormatter.string(from: workout.startDate))
                                .font(.system(size: 14))
                                .foregroundStyle(Color(red: 0.26, green: 0.26, blue: 0.26))
                            Spacer()
                            Text(weekdayWithMatchFormatter.string(from: workout.startDate))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .padding(.trailing, 16)
                        }
                        .padding(.top, 11)
                        .padding(.leading, 16)

                        VStack {
                            HStack {
                                Text("\(workout.totalEnergy, specifier: "%.0f") 칼로리")
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
                                Text("\(workout.totalDistance/1000, specifier: "%.3f KM")")
                                    .padding(.leading, 16)
                                    .padding(.trailing, 4)
                                    .fontWeight(.bold)
                                Text("/ 4KM")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                Spacer()
                                Text(timeIntervalString(from: workout.startDate, to: workout.endDate))
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 16)
                            }
                        }
                        .padding(.top, 11)
                        .padding(.bottom, 12)
                    }
                    .frame(height: 138)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 20)

                } else {
                    Text(dateFormatter.string(from: workout.startDate))
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

// 전체 누적 타이틀 텍스트
private struct OverallTitleText: View {
    public var body: some View {
        HStack {
            Text("전체")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.leading, 20)
            Spacer()
        }
    }
}

// 경기 셀 타이틀 텍스트
private struct MatchesTitleText: View {
    public var body: some View {
        HStack {
            Text("경기")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.leading, 20)
            Spacer()
        }
        .padding(.top, 20)
        .padding(.bottom, 12)
    }
}

// 전체 누적 그리드
private struct OverallGrid: View {
    var totalMatches: Int
    var totalCalories: Double
    var totalPlayTime: TimeInterval
    var totalDistance: Double

    var formattedDistance: String {
        if totalDistance == 0 {
            return "0"
        } else {
            return String(format: "%.3f KM", totalDistance / 1000)
        }
    }

    public var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 11),
                            GridItem(.flexible(), spacing: 12)],
                  spacing: 10) {
            OverallRecordCell(titleText: Text("경기"), overallSumData: Text("\(totalMatches)"))
            OverallRecordCell(titleText: Text("누적 칼로리"), overallSumData: Text("\(totalCalories, specifier: "%.0f")"))
            OverallRecordCell(titleText: Text("누적 플레이 타임"), overallSumData: Text("\(totalPlayTime, specifier: "%.0f")"))
            OverallRecordCell(titleText: Text("누적 이동거리(KM)"), overallSumData: Text("\(formattedDistance)"))
        }
                  .padding(.horizontal, 20)
    }
}
