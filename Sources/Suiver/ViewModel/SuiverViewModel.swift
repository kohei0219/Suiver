import Combine

final public class SuiverViewModel: ObservableObject {
    @Published var images: [SuiverImage]
    @Published var isHidden: Bool = true
    @Published var isFooterHidden: Bool = false
    @Published var isHeaderHidden: Bool = false
    @Published var currentPage: Int = 1
    @Published var totalPage: Int
    @Published var pageText: String = ""
    
    init(images: [SuiverImage]) {
        self.images = images
        totalPage = images.count
        updatePageText()
    }
    
    func hideView() {
        isHidden = true
    }
    
    func showView() {
        isHidden = false
    }
    
    func updatePageIndex(_ index: Int) {
        currentPage = index
        updatePageText()
    }
    
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
    
    private func updatePageText() {
        pageText = currentPage.description + "/" + totalPage.description
    }
}
