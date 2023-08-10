//
//  QWHealthItemView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/10/23.
//

import SwiftUI

struct QWHealthItemView: View {
    
    @ObservedObject var qwpersonDataViewModel: QWPersonDataViewModel
    
   @State var title: String
    @State var image: String
   @State var description: String
   @State var whenDone: Int = 5
    @State var date: Date
  @State var progressProvider: () -> Double
    
    var body: some View {
        ZStack {
            Text(title)
                .font(.footnote)
                .foregroundColor(.white)
                .padding(.leading, -150)
                .padding(.top, -100)
            Text("\(whenDone) days left")
                .font(.footnote).opacity(0.6)
                .foregroundColor(.white)
                .padding(.leading, -150)
                .padding(.top, 140)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Image(systemName: image)
                            .font(.system(size: 50, weight: .thin))
                            .foregroundColor(.blue)
                        
                    }
                    .padding(.top, 20)
                    Text(description)
                        .font(.title3)
                        .opacity(0.7)
                        .padding(.leading)
                }
                .padding()
                .padding(.bottom)
                Spacer()
                QWHealthProgressView(quitDate: date, maxValue: Int(qwpersonDataViewModel.healthController.sortedTupleSinceQuitDay[0].0)!)
                ProgressView(
                    progressProvider: { progressProvider()
                    },
                    restartInterval: 1.0
                )
                .padding()
                
            }
            
            .padding(20)
            .frame(width: 370, height: 250)
            .cornerRadius(8)
            .shadow(color: .red.opacity(0.5), radius: 3, y: 1)
            .shadow(color: .blue.opacity(0.3), radius: 10, y: 5)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 2)
                .frame(width: 370, height: 240)
        }
        
        
        
    }
    
}

//struct QWHealthItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        QWHealthItemView(qwpersonDataViewModel: QWPersonDataViewModel(userQuestionary: QWPersonData()))
//            .preferredColorScheme(.dark)
//    }
//}
