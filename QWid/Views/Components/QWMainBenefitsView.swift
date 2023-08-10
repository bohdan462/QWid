//
//  QWMainBenefitsView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/8/23.
//

import SwiftUI

import SwiftUI

struct QWMainBenefitsView: View {
    let quitDate: Date
    let mainBenefits: [(String, String)] = [
        ("1200", "Heart rate drops"),
        ("43200", "Carbon monoxide levels decrease"),
        ("86400", "Blood pressure begins to drop"),
        ("259200", "THC is depleted from the body"),
        ("604800", "Teeth start to look cleaner"),
        ("2592000", "Lung function begins to improve")
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {  // Adjust spacing as needed
                ForEach(mainBenefits, id: \.0) { benefit in
                    VStack {
                        QWCircleProgressView(quitDate: quitDate, maxValue: Int(benefit.0) ?? 0)
                            .frame(width: 50, height: 50)
                        Text(benefit.1)
                            .font(.caption)
                            .lineLimit(5)
                            .multilineTextAlignment(.center)
                            .frame(width: 100) // Adjust the width for the text to fit
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MainBenefitsView_Previews: PreviewProvider {
    static var previews: some View {
        QWMainBenefitsView(quitDate: Date().addingTimeInterval(-43200))
    }
}
