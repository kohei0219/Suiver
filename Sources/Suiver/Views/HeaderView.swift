import SwiftUI

struct HeaderView: View {
    var viewModel: SuiverViewModel
    let buttonText = Text(SuiverConfig.CloseButton.text)
        .font(SuiverConfig.CloseButton.font)
        .foregroundColor(SuiverConfig.CloseButton.textColor)
    init(viewModel: SuiverViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        HStack {
            if SuiverConfig.CloseButton.alignment == .trailing {
                Spacer()
            }
            Button(action: {
                closeView()
            }){
                if SuiverConfig.CloseButton.isBold {
                    buttonText.bold()
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                } else {
                    buttonText
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                }
            }
            .frame(
                width: SuiverConfig.CloseButton.size?.width ?? 140,
                height: SuiverConfig.CloseButton.size?.height ?? 44
            )
            if SuiverConfig.CloseButton.alignment == .leading {
                Spacer()
            }
        }
    }
    
    func closeView() {
        withAnimation(.easeInOut(duration: SuiverConfig.toggleHiddenAnimationSpeed).delay(SuiverConfig.toggleHiddenAnimationDelay)) {
            viewModel.hideView()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(viewModel: SuiverViewModel(images: []))
    }
}
