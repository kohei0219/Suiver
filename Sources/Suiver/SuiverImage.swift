import Foundation
import SwiftUI

open class SuiverImage {
    open fileprivate(set) var image: Image?
    open fileprivate(set) var imageURL: URL?
    open fileprivate(set) var videoURL: URL?
    open fileprivate(set) var imageClosure: (() -> Image)?
    open var text: String
    
    internal init(text: String = "") {
        self.text = text
    }
    
    public init(image: Image?, text: String = "", videoURL: URL? = nil) {
        self.image = image
        self.text = text
        self.videoURL = videoURL
    }

    public init(imageURL: URL, text: String = "", videoURL: URL? = nil) {
        self.imageURL = imageURL
        self.text = text
        self.videoURL = videoURL
    }

    public init(imageClosure: @escaping () -> Image, text: String = "", videoURL: URL? = nil) {
        self.imageClosure = imageClosure
        self.text = text
        self.videoURL = videoURL
    }
}
