import SwiftUI

// double tap の座標を掴む
// zoomの時、座標を中心に
// zoomしていてドラッグできる時、左右に壁があること
// 壁に到達したら酢わいぷできること
// drag中はzoomできないように

struct ImageView: View {
    // Params for zoom
    @GestureState private var scaleState: CGFloat = 1
    @State var currentScale: CGFloat = 1
    @State var lastScale: CGFloat = 1
    private let maxScale: CGFloat = 2
    private let minScale: CGFloat = 1
    // Pramas of drag
    @GestureState private var offsetState: CGSize = .zero
    @State private var offset: CGSize = .zero
    // Disable gesture
    @State private var isGestureEnabled: Bool = true
    // Size of screen
    private let screenSize = UIScreen.main.bounds
    private let screenHalfWidth: CGFloat
    private let screenHalfHeight: CGFloat
    // Speed of view
    @State private var moveSpeed: CGFloat = 0.1
    private let defalutSpeed: CGFloat = 0.1
    private let slowSpeed: CGFloat = 0.4
    //
    var viewModel: SuiverViewModel
    private let image: Image?
    public init(viewModel: SuiverViewModel, imageIndex: Int) {
        self.viewModel = viewModel
        self.image = viewModel.getImage(at: imageIndex)?.image
        screenHalfWidth = screenSize.width / 2
        screenHalfHeight = screenSize.height / 2
    }
    var zoomGesture: some Gesture {
        MagnificationGesture()
            .updating($scaleState) { currentState, gestureState, transaction in
                guard isGestureEnabled else { return }
                gestureState = currentState
            }
            .onEnded { value in
                guard isGestureEnabled else { return }
                currentScale *= value
                if currentScale <= minScale {
                    currentScale = minScale
                    feedbackVibe()
                    resetOffsetWidth()
                    showFooterHeader()
                } else if currentScale >= maxScale {
                    feedbackVibe()
                    currentScale = maxScale
                    hideFooterHeader()
                } else {
                    currentScale = currentScale
                    hideFooterHeader()
                }
            }
    }
    var dragGesture: some Gesture {
        // Set minimumDistance for allowing swipe on TabView in SuiverView
        DragGesture(minimumDistance: 30)
            .updating($offsetState) { currentState, gestureState, _ in
                guard isGestureEnabled else { return }
                gestureState.height = currentState.translation.height
            }.onEnded { value in
                guard isGestureEnabled else { return }
                offset.height += value.translation.height
                if isWithinVertical() {
                    resetOffset()
                } else {
                    withAnimation(.easeInOut(duration: SuiverConfig.toggleHiddenAnimationSpeed).delay(SuiverConfig.toggleHiddenAnimationDelay)) {
                        viewModel.hideView()
                    }
                }
            }
    }
    var zoomingDragGesture: some Gesture {
        DragGesture()
            .updating($offsetState) { currentState, gestureState, _ in
                guard isGestureEnabled else { return }
                let xOff = currentState.translation.width
                let yOff = currentState.translation.height
                let dist = sqrt(xOff * xOff + yOff * yOff)
                let factor = 1 / (dist / screenHalfWidth + 1)
                // deceleration
                gestureState.height = currentState.translation.height * factor
                gestureState.width = currentState.translation.width * factor
            }.onEnded { value in
                guard isGestureEnabled else { return }
                offset.height += value.translation.height
                offset.width += value.translation.width
                let scaledWidth = screenHalfWidth * currentScale
                let moveWidth = scaledWidth - screenHalfWidth
                if offset.width > screenHalfWidth {
                    // right
                    resetWidthOffset(moveWidth)
                } else if offset.width < -screenHalfWidth {
                    // left
                    resetWidthOffset(-moveWidth)
                }
            }
    }
    var doubleTapGesture: some Gesture {
        SimultaneousGesture(
            TapGesture(count: 2),
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
        ).onEnded { value in
            guard value.first != nil else { return }
            guard let location = value.second?.startLocation else { return }
            guard let endLocation = value.second?.location else { return }
            guard ((location.x-1)...(location.x+1)).contains(endLocation.x),
                  ((location.y-1)...(location.y+1)).contains(endLocation.y) else {
                return
            }
            toggleZoomImage(location: location)
        }
    }
    var body: some View {
        image?
            .resizable()
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .scaleEffect(currentScale * scaleState)
            .offset(CGSize(
                width: isZooming ? offset.width + offsetState.width : 0,
                height: offset.height + offsetState.height
            ))
            .gesture(isZooming ? nil : dragGesture)
            .gesture(isZooming ? zoomingDragGesture : nil)
            .gesture(zoomGesture)
            .gesture(doubleTapGesture)
            .animation(.easeInOut(duration: moveSpeed))
    }
    
    var isZooming: Bool {
        currentScale != 1
    }
    
    var isDragging: Bool {
        offset != .zero
    }
    
    func resetOffsetWidth() {
        offset.width = .zero
    }
    
    func feedbackVibe() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func resetOffset() {
        isGestureEnabled = false
        moveSpeed = slowSpeed
        offset = .zero
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            moveSpeed = defalutSpeed
            isGestureEnabled = true
        }
    }
    
    func resetWidthOffset(_ width: CGFloat) {
        isGestureEnabled = false
        moveSpeed = slowSpeed
        offset.width = .zero
        offset.width = width
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            moveSpeed = defalutSpeed
            isGestureEnabled = true
        }
    }
    
    func hideFooterHeader() {
        withAnimation(.easeInOut(duration: SuiverConfig.toggleHiddenAnimationSpeed).delay(SuiverConfig.toggleHiddenAnimationDelay)) {
            viewModel.hideFooter()
            viewModel.hideHeader()
        }
    }
    
    func showFooterHeader() {
        withAnimation(.easeInOut(duration: SuiverConfig.toggleHiddenAnimationSpeed).delay(SuiverConfig.toggleHiddenAnimationDelay)) {
            viewModel.showFooter()
            viewModel.showHeader()
        }
    }
    
    func toggleZoomImage(location: CGPoint) {
        isGestureEnabled = false
        moveSpeed = slowSpeed
        if currentScale > 1 {
            currentScale = minScale
            offset = .zero
            showFooterHeader()
        } else {
            currentScale = maxScale
            
            offset.width = screenHalfWidth - location.x
            offset.height = screenHalfHeight - location.y
            hideFooterHeader()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            moveSpeed = defalutSpeed
            isGestureEnabled = true
        }
    }
    
    func isWithinVertical() -> Bool {
        abs(offset.height) < (screenSize.height / 4)
    }
}

struct ImageViewer_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(viewModel: SuiverViewModel(images: []), imageIndex: 0)
    }
}
