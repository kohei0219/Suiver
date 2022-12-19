import SwiftUI
import PDFKit

struct DemoView: View {
    var body: some View {
        SuiverExampleView()
    }
}

public struct SuiverExampleView: View {
    public init() {}
    @ObservedObject var viewModel = SuiverViewModel()
    public var body: some View {
        if viewModel.isHidden {
            Button(action: {
                toggleHidden()
            }){
                Text("Show Suiver view")
                   .font(.largeTitle)
            }
        } else {
            SuiverView(viewModel: viewModel)
        }
    }
    
    func toggleHidden() {
        withAnimation(.easeInOut(duration: SuiverConfig.toggleHiddenAnimationSpeed).delay(SuiverConfig.toggleHiddenAnimationDelay)) {
            viewModel.showView()
        }
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}

struct PhotoDetailView: UIViewRepresentable {
    let image: UIImage

    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.document = PDFDocument()
        guard let page = PDFPage(image: image) else { return view }
        view.document?.insert(page, at: 0)
        view.autoScales = true
        return view
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}
