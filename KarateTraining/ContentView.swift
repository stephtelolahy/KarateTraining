import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Training", systemImage: "timer") {
                TrainingListView()
            }

            Tab("Kihon", systemImage: "magnifyingglass", role: .search) {
                KihonListView()
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    ContentView().environment(ContentStore())
}
