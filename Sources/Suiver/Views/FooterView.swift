import SwiftUI

struct FooterView: View {
    @ObservedObject var viewModel: SuiverViewModel
    init(viewModel: SuiverViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            // In order to fix page text to bottom
            // When explain text is empty
            Spacer()
            Text(viewModel.explainText)
                .foregroundColor(SuiverConfig.FooterView.textColor)
            Divider()
            Text(viewModel.pageText)
                .foregroundColor(SuiverConfig.FooterView.textColor)
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(viewModel: SuiverViewModel(images: []))
    }
}
