//
//  QWMainView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/9/23.
//

import SwiftUI

struct QWItemView: View {
    
    @ObservedObject var qwpersonDataViewModel: QWPersonDataViewModel
   @State var title: String
   @State var number: Int
   @State var numberDescriptor: String
   @State var futureDescription: String
//   @State var description: String
   @State var progressProvider: () -> Double
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.footnote)
                    .padding(.top, 5)
                    .foregroundColor(.white)
                    VStack(alignment: .center) {
                        Text("\(number)")
                            .font(Font.system(size: 80))
                        Text(numberDescriptor)
                            .font(.title3).bold()
                            .opacity(0.7)

                    }
                    .padding(.leading, 30)
                Text(futureDescription)
                    .font(.footnote)
                    .opacity(0.7)
                    .padding(.top)
                    .padding(.leading, 8)
                    

                ProgressView(
                    progressProvider: progressProvider,
                    restartInterval: 1.0
                )
                
            }
            
            .padding(20)
            .padding(.vertical, 20)
            .frame(width: 170, height: 250)
            .cornerRadius(20)
            .shadow(color: .white.opacity(0.1), radius: 3, y: 1)
            .shadow(color: .white.opacity(0.15), radius: 10, y: 5)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 2)
        }
        
       
        
    }
    
}


















//struct QWItemView_Previews: PreviewProvider {
//    static var previews: some View {
////        QWItemView(qwpersonDataViewModel: QWPersonDataViewModel(userQuestionary: QWPersonData()))
////            .preferredColorScheme(.dark)
//    }
//}

extension Color {
    static let background = LinearGradient(gradient: Gradient(colors: [Color("Background 1"), Color("Background 2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let bottomSheetBackground = LinearGradient(gradient: Gradient(colors: [Color("Background 1").opacity(0.26), Color("Background 2").opacity(0.26)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let navBarBackground = LinearGradient(gradient: Gradient(colors: [Color("Background 1").opacity(0.1), Color("Background 2").opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let tabBarBackground = LinearGradient(gradient: Gradient(colors: [Color("Tab Bar Background 1").opacity(0.26), Color("Tab Bar Background 2").opacity(0.26)]), startPoint: .top, endPoint: .bottom)
    static let weatherWidgetBackground = LinearGradient(gradient: Gradient(colors: [Color("Weather Widget Background 1"), Color("Weather Widget Background 2")]), startPoint: .leading, endPoint: .trailing)
    static let bottomSheetBorderMiddle = LinearGradient(gradient: Gradient(stops: [.init(color: .white, location: 0), .init(color: .clear, location: 0.2)]), startPoint: .top, endPoint: .bottom)
    static let bottomSheetBorderTop = LinearGradient(gradient: Gradient(colors: [.white.opacity(0), .white.opacity(0.5), .white.opacity(0)]), startPoint: .leading, endPoint: .trailing)
    static let underline = LinearGradient(gradient: Gradient(colors: [.white.opacity(0), .white, .white.opacity(0)]), startPoint: .leading, endPoint: .trailing)
    static let tabBarBorder = Color("Tab Bar Border").opacity(0.5)
    static let forecastCardBackground = Color("Forecast Card Background")
    static let probabilityText = Color("Probability Text")
}

extension View {
    func backgroundBlur(radius: CGFloat = 3, opaque: Bool = false) -> some View {
        self
            .background(
                QWBlur(radius: radius, opaque: opaque)
            )
    }
}

extension View {
    func innerShadow<S: Shape, SS: ShapeStyle>(shape: S, color: SS, lineWidth: CGFloat = 1, offsetX: CGFloat = 0, offsetY: CGFloat = 0, blur: CGFloat = 4, blendMode: BlendMode = .normal, opacity: Double = 1) -> some View {
        return self
            .overlay {
                shape
                    .stroke(color, lineWidth: lineWidth)
                    .blendMode(blendMode)
                    .offset(x: offsetX, y: offsetY)
                    .blur(radius: blur)
                    .mask(shape)
                    .opacity(opacity)
            }
    }
}
