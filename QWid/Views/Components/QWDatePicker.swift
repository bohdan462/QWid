//
//  QWDatePicker.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/4/23.
//

import SwiftUI

class QWTime: ObservableObject {
    @Published var time: Date
    
    init(time: Date) {
        self.time = time
    }
}

class QWDate: ObservableObject {
    @Published var date: Date
    
    init(date: Date) {
        self.date = date
    }
}


struct QWDatePicker: View {
    //    @Binding var selectedDate: QWDate
    //    @Binding var selectedTime: QWTime
    
    @State private var isAdjustingDate = false
    @State private var isAdjustingTime = false
    @State var selectedDate: Date = Date()
    @ObservedObject var model: QWPersonDataViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Selected Date: \((formattedDate(model.userQuestionary.selectedDate)))")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .onTapGesture {
                isAdjustingDate = true
                isAdjustingTime = false
            }
            .sheet(isPresented: $isAdjustingDate) {
                QWDatePickerDateView(selectedDate: $model.userQuestionary.selectedDate)
            }
            
            HStack {
                Text("Selected Time: \(formattedTime(model.userQuestionary.selectedDate))")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .onTapGesture {
                isAdjustingDate = false
                isAdjustingTime = true
            }
            .sheet(isPresented: $isAdjustingTime) {
                QWDatePickerTimeView(selectedDate: $model.userQuestionary.selectedDate)
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    private func formattedTime(_ date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        return timeFormatter.string(from: date)
    }
}

struct QWDatePickerTimeView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedDate: Date
    var onDismiss: ((_ model: Date) -> Void)?
    @State var isDateInFuture = false
    
    var body: some View {
        VStack {
            Text("Select a Time")
                .font(.title)
                .padding()
            DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding()
            Text("DATA: \(selectedDate)")
                .font(.largeTitle)
                .padding()
            Spacer()
            if isDateInFuture {
                Text("Quit time cannot be in the future.")
                    .foregroundColor(.red)
                    .padding()
            }
            Button(action: {
                if selectedDate > Date() {
                    // Set the flag to display the error message
                    isDateInFuture = true
                } else {
                    let currentDate = Date()
                    let tenMinutesFromNow = currentDate.addingTimeInterval(600)
                    
                    if selectedDate > tenMinutesFromNow {
                        isDateInFuture = true
                    } else {
                        // Update the selected date and time when the "Done" button is tapped
                        // Reset the flag
                        isDateInFuture = false
                        // Pass data from here to QWDatePicker
                        onDismiss?(selectedDate)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                //                onDismiss?(selectedDate)
                //                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done")
            })
            .padding()
        }
    }
}

struct QWDatePickerDateView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedDate: Date
    @State var isDateInFuture = false
    
    
    var onDismiss: ((_ model: Date) -> Void)?
    var body: some View {
        VStack {
            Text("Select a Date")
                .font(.title)
                .padding()
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding()
            Text("DATA: \(selectedDate)")
                .font(.largeTitle)
                .padding()
            Spacer()
            if isDateInFuture {
                Text("Quit date cannot be in the future.")
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: {
                let currentDate = Date()
                let tenMinutesFromNow = currentDate.addingTimeInterval(600)
                // Pass data from here to QWDatePicker
                if selectedDate > tenMinutesFromNow {
                    // Set the flag to display the error message
                    isDateInFuture = true
                } else {
                    // Update the selected date and time when the "Done" button is tapped
                    // Reset the flag
                    isDateInFuture = false
                    // Pass data from here to QWDatePicker
                    onDismiss?(selectedDate)
                    presentationMode.wrappedValue.dismiss()
                }
                
                //                onDismiss?(selectedDate)
                //                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done")
            })
            .padding()
        }
    }
}

struct QWDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        QWDatePicker(model: QWPersonDataViewModel(userQuestionary: QWPersonData()))
    }
}
