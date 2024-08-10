///*
//See the LICENSE.txt file for this sample’s licensing information.
//
//Abstract:
//A view that hosts the profile viewer and editor.
//*/
import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = ModelData().profile

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
        }
        .padding()
    }
}

#Preview {
    ProfileHost()
        .environmentObject(ModelData())
}
