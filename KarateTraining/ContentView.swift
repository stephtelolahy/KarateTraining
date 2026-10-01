import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Training", systemImage: "timer") {
                TrainingListView()
            }

            Tab("Kihon", systemImage: "figure.martial.arts") {
                KihonListView()
            }

            Tab(role: .search) {
                SearchView()
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    ContentView().environment(ContentStore())
}
