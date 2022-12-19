import SwiftUI

class AssetManager {
    static func image(_ named: String) -> Image? {
        Image("\(named)", bundle: Bundle.module)
    }
    
    static func image(_ named: String) -> UIImage? {
        UIImage(named: "\(named)", in: Bundle.module, compatibleWith: nil)
    }
}
