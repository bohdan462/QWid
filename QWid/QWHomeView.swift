//
//  QWHomeView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/1/23.
//

import SwiftUI
import AudioToolbox

struct QWHomeView: View {

    @StateObject var qwpersonDataViewModel: QWPersonDataViewModel
    @State var currentIndexOfDescription: Int = 0
    @State var ifAdjustingDate: Bool = false
    @State var isHealthStatsTapped = false

    var body: some View {
        Grid(alignment: .center, horizontalSpacing: 10, verticalSpacing: 10) {

            HStack(alignment: .center, spacing: 10){

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


                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.secondary.opacity(0.1))
                    .overlay {
                        VStack {
                            ProgressView(
                                progressProvider: { qwpersonDataViewModel.totalSaved },
                                restartInterval: 1.0
                            )
                            Text("Saved")
                            Text("\(qwpersonDataViewModel.totalSaved, specifier: "%.2f")")

                        }
                        .font(.system(size: 25, design: .monospaced)).bold()


                    }
            }
            .padding()

            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.secondary.opacity(0.0))
                    .onTapGesture {
                        currentIndexOfDescription = (currentIndexOfDescription + 1) % qwpersonDataViewModel.healthController.showHealthDescriptions.count
                    }
                    .overlay(
                        VStack {
                            Text("\(qwpersonDataViewModel.healthController.showHealthDescriptions[currentIndexOfDescription].0)")
                            QWMarqueeView(text: qwpersonDataViewModel.healthController.showHealthDescriptions[currentIndexOfDescription].1)

                            QWMainBenefitsView(quitDate: qwpersonDataViewModel.userQuestionary.selectedDate)
                                .onLongPressGesture {
                                    isHealthStatsTapped = true
                                }
                                .sheet(isPresented: $isHealthStatsTapped) {
                                    QWHealtStatsView(viewModel: qwpersonDataViewModel)
                                }

                        }


                            )


            }
            .font(.system(size: 20, design: .monospaced)).bold()
            .padding()

            HStack {
                TabView {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.secondary.opacity(0.2))
                        .overlay {
                            if qwpersonDataViewModel.jointsNotSmoked == 0 {
                                Text("First skipped joint is coming")
                                    .padding()

                            } else {
                                Text("Joints skipped: \(qwpersonDataViewModel.jointsNotSmoked)")
                                    .padding()
                            }

                        }


                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.secondary.opacity(0.2))
                        .overlay {

                            Text("Grapgh 2")

                        }

                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.secondary.opacity(0.2))
                        .overlay {

                            Text("Grapgh 3")

                        }

                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))

                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.secondary.opacity(0.1))
                    .overlay {
                        ZStack {
                            VStack {
                                Text("\(qwpersonDataViewModel.ouncesNotSmokedFormattedString) ounces not smoked")


                            }
                            .padding()

                            ProgressView(
                                progressProvider: { qwpersonDataViewModel.ouncesNotSmoked },
                                restartInterval: 1.0

                            )

                        }
                    }
            }
            .font(.system(size: 25, design: .monospaced)).bold()
            .padding()

        }
    }

    func vibrate() {
        //        let generator = UIImpactFeedbackGenerator(style: .heavy)
        //           generator.impactOccurred()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}

struct QWHomeView_Previews: PreviewProvider {
    static var previews: some View {
        QWHomeView(qwpersonDataViewModel: QWPersonDataViewModel(userQuestionary: QWPersonData()))
    }
}
