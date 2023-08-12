//
//  QWQAView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/1/23.
//

import SwiftUI
import Combine


struct QWQAView: View {
    
     @StateObject var qwPersonDataViewModel: QWPersonDataViewModel
     @State private var isFullScreenPresented = false
    
    init(model: QWPersonDataViewModel) {
        _qwPersonDataViewModel = StateObject(wrappedValue: model)
    }
    
    var body: some View {

        TabView {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.blue.opacity(0.2))
                .padding()
                .overlay {
                    VStack {
                        Text("When is the day to quit? \(qwPersonDataViewModel.userQuestionary.selectedDate)")
                            .font(.largeTitle)
                            .padding()
                        QWDatePicker(model: qwPersonDataViewModel)
//
//                        DatePicker("Select a date", selection: $model.userQuestionary.selectedDate)
//                            .datePickerStyle(GraphicalDatePickerStyle())
//                            .font(.title)
//                            .padding()
//                        Text("DATA: \(model.userQuestionary.selectedDate)")
//                            .font(.largeTitle)
//                            .padding()
                    }
                }
            
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.red.opacity(0.2))
                .padding()
                .overlay {
                    HStack {
                        Text("Age")
                        Picker("Select your age", selection: $qwPersonDataViewModel.userQuestionary.selectedAge) {
                            ForEach(16...100, id: \.self) { number in
                                Text("\(number)")
                                
                            }
                        }
                    }
                }
            
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.purple.opacity(0.2))
                .padding()
                .overlay {
                    VStack
                    {
                        VStack{
                            Stepper(value: $qwPersonDataViewModel.userQuestionary.selectedAmountOfConcumption, in: 1...100) {
                                Text("Amount of consumption: \(qwPersonDataViewModel.userQuestionary.selectedAmountOfConcumption)")
                            }
                           
                            
                            Stepper(value: $qwPersonDataViewModel.userQuestionary.selectedPrice, in: 1...100) {
                                Text("Price per unit: \(qwPersonDataViewModel.userQuestionary.selectedPrice)")
                            }
                            
                        Picker("Wake and Bake Time", selection: $qwPersonDataViewModel.userQuestionary.selectedWakeAndBakeTimeInterval) {
                            ForEach(WakeAndBakeTimeInterval.allCases) { substance in
                                Text(substance.rawValue.capitalized)
                                    .tag(substance)

                                
                                
                            }
                        }
                            
                            Button {
                                isFullScreenPresented.toggle()
                            } label: {
                                Text("Okay")
                            }
                            .fullScreenCover(isPresented: $isFullScreenPresented) {
//                                QWHomeView(qwpersonDataViewModel: model)
                                QWMainView(qwpersonDataViewModel: qwPersonDataViewModel)
                            }
                    }
                        .padding()
                        
                    }
                    .padding()
                    //                    VStack(spacing: 15) {
                    //                        HStack
                    //                        {
                    //                            Stepper(value: $model.userQuestionary.selectedAmountOfConcumption, in: 1...100) {
                    //                                Text("Price per unit: \(model.userQuestionary.selectedAmountOfConcumption)")
                    //                            }
                    //                                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 5, style: .continuous))
                    //
                    //
                    //                        }
                   

                }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }

        
        
}

struct QuestionaryView_Previews: PreviewProvider {
    static var previews: some View {
        QWQAView(model: QWPersonDataViewModel(userQuestionary: QWPersonData()))
    }
}
