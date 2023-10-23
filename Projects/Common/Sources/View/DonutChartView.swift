//
//  DonutChartView.swift
//  Common
//
//  Created by Ha Jong Myeong on 10/22/23.
//

import SwiftUI

// 사용 예:
// DonutChartView(innerCircleSize: 130, outerCircleSize: 140, centerText: Text("79"))
public struct DonutChartView: View {
    // mock
    private var distanceCovered: Double = 0.8
    private var calories: Double = 0.2

    private let innerCircleSize: CGFloat // 내부 원 지름
    private let outerCircleSize: CGFloat // 바깥 원 지름
    private let centerText: Text // 중앙 텍스트

    public init(innerCircleSize: CGFloat = 130,
                outerCircleSize: CGFloat = 140,
                centerText: Text = Text("75")) {
        self.innerCircleSize = innerCircleSize
        self.outerCircleSize = outerCircleSize
        self.centerText = centerText
    }

    private var data: [(value: Double, color: Color)] {
        return [
            (distanceCovered, Color(hex: "#A9FCE7")),
            (calories, Color(hex: "#FF92A5"))
        ]
    }

    public var body: some View {
        GeometryReader { _ in
            HStack {
                Spacer()
                ZStack {
                    Canvas { context, size in
                        drawPieSlice(context: context, size: size)
                    }
                    .aspectRatio(1, contentMode: .fit)
                    Circle()
                        .fill(Color.black)
                        .frame(width: innerCircleSize * 2, height: innerCircleSize * 2, alignment: .center)
                    centerText
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                Spacer()
            }
        }
        .background(Color.black)
    }

    // 파이 차트
    private func drawPieSlice(context: GraphicsContext, size: CGSize) {
        let total = 1.0
        let radius = outerCircleSize
        let center = CGPoint(x: size.width * 0.5, y: size.height * 0.5)

        let initialStartAngle = Angle(degrees: 180) // 위쪽 시작 지점

        for (index, (value, color)) in data.enumerated() {
            let angle = Angle(degrees: 180 * (value / total)) // 180도 기준으로 데이터 표시
            let endAngle: Angle
            if index == 0 { // 첫 번째 데이터(활동 수치) - 시계 방향
                endAngle = initialStartAngle + angle
            } else { // 두 번째 데이터(칼로리 수치) - 시계 반대 방향
                endAngle = initialStartAngle - angle
            }

            // 수치 표시 Path
            let path = Path { path in
                path.move(to: center)
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: initialStartAngle,
                    endAngle: endAngle,
                    clockwise: index != 0
                )
                path.closeSubpath()
            }
            context.fill(path, with: .color(color))

            // 빈 영역은 옅은 색으로 표시
            let remainingAngle = Angle(degrees: 180) - angle
            let lightColor = color.opacity(0.3)
            let emptyEndAngle: Angle
            if index == 0 {
                emptyEndAngle = endAngle + remainingAngle
            } else {
                emptyEndAngle = endAngle - remainingAngle
            }

            let emptyPath = Path { path in
                path.move(to: center)
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: endAngle,
                    endAngle: emptyEndAngle,
                    clockwise: index != 0
                )
                path.closeSubpath()
            }
            context.fill(emptyPath, with: .color(lightColor))
        }
    }
}

#Preview {
    DonutChartView()
}
