import SwiftUI

public struct SuiverView: View {
    @ObservedObject var viewModel: SuiverViewModel
    @State var pageIndex = 0
    public init(viewModel: SuiverViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        TabView(selection: $pageIndex) {
            ImageView(viewModel: viewModel).tag(1)
            ImageView(viewModel: viewModel).tag(2)
            ImageView(viewModel: viewModel).tag(3)
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
        SuiverView(viewModel: SuiverViewModel())
    }
}
