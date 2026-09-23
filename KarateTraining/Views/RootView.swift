import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            TrainingListView()
                .tabItem { Label("Training", systemImage: "timer") }

            KihonListView()
                .tabItem { Label("Kihon", systemImage: "figure.martial.arts") }
        }
    }
}

#Preview {
    RootView().environment(ContentStore())
}
