//
//  ChangeSchedule.swift
//  NextWorkout
//
//  Created by Ivan Pedroza on 8/8/24.
//

import SwiftUI

struct ChangeScheduleView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                ForEach(modelData.schedules) { schedule in
                    Button(action: {
                        modelData.currentSchedule = schedule
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(schedule.name)
                            .padding()
                    }
                }
            }
            .navigationTitle("Select Schedule")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct ChangeScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeScheduleView()
            .environmentObject(ModelData())
    }
}
