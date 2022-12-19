import Foundation
import SwiftUI

// TODO: Add more settings
public class SuiverConfig {
    public static var hideStatusBar = true
    public static var imageBackgroundColor: UIColor = .black
    
    public static var toggleHiddenAnimationSpeed: CGFloat = 0.2
    public static var toggleHiddenAnimationDelay: CGFloat = 0.1
    
    public struct PageIndicator {
        public static var enabled = true
        public static var separatorColor: UIColor = .white
        
        public static var textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.white,
            .paragraphStyle: {
                var style = NSMutableParagraphStyle()
                style.alignment = .center
                return style
            }()
        ]
    }
    
    public struct CloseButton {
        public static var enabled = true
        public static var size: CGSize?
        public static var text = NSLocalizedString("Close", comment: "")
        public static var image: UIImage?
        public static var font: Font = .system(size: 24)
        public static var textColor: Color = .white
        public static var isBold: Bool = true
        public static var alignment: Alignment = .trailing
    }
    
    public struct FooterView {
        public static var textColor: Color = .white
    }
}
