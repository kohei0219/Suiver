import Combine

final public class SuiverViewModel: ObservableObject {
    private var images: [SuiverImage]
    @Published var isHidden: Bool = true
    @Published var isFooterHidden: Bool = false
    @Published var isHeaderHidden: Bool = false
    @Published var currentPage: Int = 1
    @Published var totalPage: Int
    @Published var pageText: String = ""
    @Published var explainText: String = ""
    
    init(images: [SuiverImage]) {
        self.images = images
        totalPage = images.count
        updatePageText()
        updateExpalinText()
    }
    
    // MARK: - Parent view
    func hideView() {
        isHidden = true
    }
    
    func showView() {
        isHidden = false
    }
    
    func updatePageIndex(_ index: Int) {
        currentPage = index
        updatePageText()
        updateExpalinText()
    }
    
    // MARK: - Header, Footer
    func hideFooter() {
        isFooterHidden = true
    }
    
    func showFooter() {
        isFooterHidden = false
    }
    
    func hideHeader() {
        isHeaderHidden = true
    }
    
    func showHeader() {
        isHeaderHidden = false
    }
    
    // MARK: - Image
    func getImage(at index: Int) -> SuiverImage? {
        images.get(index)
    }
    
    func numberOfImages() -> Int {
        images.count
    }
    
    // MARK: - Private
    private func updatePageText() {
        pageText = currentPage.description + "/" + totalPage.description
    }
    
    private func updateExpalinText() {
        guard let updatedExplainText = images.get(currentPage-1)?.text else {
            explainText = ""
            return
        }
        explainText = updatedExplainText
    }
}
