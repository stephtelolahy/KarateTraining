import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TrainingListView()
                .tabItem { Label("Training", systemImage: "figure.martial.arts") }

            KihonListView()
                .tabItem { Label("Kihon", systemImage: "magnifyingglass") }
        }
    }
}

#Preview {
    ContentView().environment(ContentStore())
}
