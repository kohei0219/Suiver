import SwiftUI

struct FooterView: View {
    @ObservedObject var viewModel: SuiverViewModel
    init(viewModel: SuiverViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            Text("Explain texts about a photo")
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
