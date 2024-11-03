//
//  ChartView.swift
//  innerpeace
//
//  Created by 신효성 on 8/21/24.
//

import Charts
import SwiftUI

struct ChartView: View {
    @Environment(\.openWindow) var openWindow

    @Binding var chartData: HKChartEntity?
    @State private var selectedItem: String = "today"

    @State private var charts: [HKChartEntity] = []
    private let hkName: HKTypeName

    private let repo = HKRepository()

    init(hkName: HKTypeName, chartData: Binding<HKChartEntity?>) {
        self.hkName = hkName
        self._chartData = chartData
    }

    var body: some View {
        VStack {
            headerView
            chartContent
        }
        .padding(20)
        .glassBackgroundEffect()
        .onAppear(perform: loadData)
    }

    private var headerView: some View {
        HStack {
            Text(hkName.description)
                .font(.headline)
                .padding(.leading)
            Spacer()
            IPPicker(selectedItem: $selectedItem)
        }
        .padding(.bottom)
    }

    private var chartContent: some View {
        Chart {
            if let data = chartData?.datas {
                drawBarMarks(for: data, color: hkName.color)
            }
            
            if selectedItem != "today" {
                let selectedCharts = selectedItem == "weekly" ? charts[2].datas : charts[1].datas
                let color: Color = selectedItem == "weekly" ? .yellow : .blue
                drawBarMarks(for: selectedCharts, color: color)
            }
        }
        .padding(.horizontal)
        .chartYAxis(.hidden)
        .gesture(
            TapGesture().onEnded {  _ in
                self.openWindow.openWindow(.compare, value: self.charts)
            }
        )
    }

    private func drawBarMarks(for data: [HKChartData], color: Color) -> some ChartContent {
        ForEach(data) { item in
            BarMark(
                x: .value("Time", item.index),
                y: .value("Stability", item.data)
            )
            .foregroundStyle(color)
            .cornerRadius(10)
        }
    }

    private func loadData() {
        if chartData?.type == .heartRate {
            charts = [
                HKChartEntity(type: .heartRate, datas: repo.fetchHeartRateSampleDummy(true)),
                HKChartEntity(type: .heartRate, datas: repo.fetchHeartRateSampleDummy(true)),
                HKChartEntity(type: .heartRate, datas: repo.fetchHeartRateSampleDummy(true))
            ]
        } else {
            charts = [
                HKChartEntity(type: .respiratoryRate, datas: repo.fetchRespiratoryRateSampleDummy(true)),
                HKChartEntity(type: .respiratoryRate, datas: repo.fetchRespiratoryRateSampleDummy(true)),
                HKChartEntity(type: .respiratoryRate, datas: repo.fetchRespiratoryRateSampleDummy(true))
            ]
        }
    }
}
