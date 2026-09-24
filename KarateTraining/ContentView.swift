import SwiftUI

struct ContentView: View {
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
    ContentView().environment(ContentStore())
}
