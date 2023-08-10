//
//  QWTimerView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/9/23.
//

import SwiftUI

struct QWTimerView: View {
    @State var ifAdjustingDate: Bool = false
    @ObservedObject var qwpersonDataViewModel: QWPersonDataViewModel
    
    var body: some View {
        ZStack {
            ForEach(Array(qwpersonDataViewModel.quitTimerRepresentable.fullDateToString.enumerated()), id: \.offset) { index, letter in
                VStack {
                    Text(String(letter))
                    
                    Spacer()
                }
                .rotationEffect(.degrees(4.9 * Double(index) + Double(qwpersonDataViewModel.quitTimerRepresentable.seconds)))
                .animation(Animation.easeOut)
            }
            
            Text("\(qwpersonDataViewModel.quitTimerRepresentable.seconds)")
                .font(Font.system(size: 80))
                .bold()
                .foregroundColor(Color.primary)
                .padding(20)
                .cornerRadius(10)
            
        }
        .frame(width: 200, height: 200)
        .font(.system(size: 12, design: .monospaced)).bold()
        .onLongPressGesture {
            ifAdjustingDate = true
        }
        .sheet(isPresented: $ifAdjustingDate) {
            QWQAView(model: qwpersonDataViewModel)
        }
    }
}


struct QWTimerView_Previews: PreviewProvider {
    static var previews: some View {
        QWTimerView(qwpersonDataViewModel: QWPersonDataViewModel(userQuestionary: QWPersonData()))
    }
}
