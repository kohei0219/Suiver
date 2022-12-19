import SwiftUI

// Parent view
// Call this view
public struct SuiverView: View {
    @ObservedObject var viewModel: SuiverViewModel
    public init(images: [SuiverImage]) {
        self.viewModel = .init(images: images)
    }
    public var body: some View {
        if viewModel.isHidden {
            Button(action: {
                toggleHidden()
            }){
                Text("Show Suiver view")
                   .font(.largeTitle)
            }
        } else {
            SuiverMainView(viewModel: viewModel)
        }
    }
    
    func toggleHidden() {
        withAnimation(.easeInOut(duration: SuiverConfig.toggleHiddenAnimationSpeed).delay(SuiverConfig.toggleHiddenAnimationDelay)) {
            viewModel.showView()
        }
    }
}

// Child view
struct SuiverMainView: View {
    @ObservedObject var viewModel: SuiverViewModel
    @State var pageIndex = 0
    private let totalPageNum: Int
    init(viewModel: SuiverViewModel) {
        self.viewModel = viewModel
        self.totalPageNum = viewModel.numberOfImages()
    }
    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(0..<totalPageNum, id: \.self) { i in
                ImageView(viewModel: viewModel, imageIndex: i).tag(i+1)
            }
        }
        .onChange(of: pageIndex) { value in
            viewModel.updatePageIndex(value)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(VisualEffect.init(style: .dark))
        .ignoresSafeArea()
        .overlay(
            viewModel.isHeaderHidden ? nil : HeaderView(viewModel: viewModel)
            .frame(height: 100),
            alignment: .top
        )
        .overlay(
            viewModel.isFooterHidden ? nil : FooterView(viewModel: viewModel)
            .frame(height: 100),
            alignment: .bottom
        )
    }
}

struct SuiverView_Previews: PreviewProvider {
    static var previews: some View {
        SuiverMainView(viewModel: SuiverViewModel(images: []))
    }
}
