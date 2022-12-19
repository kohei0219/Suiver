import Combine

final public class SuiverViewModel: ObservableObject {
    @Published var isHidden: Bool = true
    @Published var isFooterHidden: Bool = false
    @Published var isHeaderHidden: Bool = false
    @Published var currentPage: Int = 1
    @Published var totalPage: Int = 3
    // TODO: Init page
    @Published var pageText: String = "1/3"
    
    func hideView() {
        isHidden = true
    }
    
    func showView() {
        isHidden = false
    }
    
    func updatePageIndex(_ index: Int) {
        currentPage = index
        print("page index: ", index)
        pageText = currentPage.description + "/" + totalPage.description
    }
    
    func hideFooter() {
        isFooterHidden = true
        print("hide footer")
    }
    
    func showFooter() {
        isFooterHidden = false
        print("show footer")
    }
    
    func hideHeader() {
        isHeaderHidden = true
        print("hide header")
    }
    
    func showHeader() {
        isHeaderHidden = false
        print("show header")
    }
}
