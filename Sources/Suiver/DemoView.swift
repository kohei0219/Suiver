import SwiftUI
import PDFKit

public struct DemoView: View {
    public init() {}
    private let images: [SuiverImage] = [.init(image: AssetManager.image("img1")), .init(image: AssetManager.image("img2")), .init(image: AssetManager.image("img3"))]
    public var body: some View {
        SuiverView(images: images)
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
