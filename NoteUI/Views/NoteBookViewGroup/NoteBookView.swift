import SwiftUI

struct NoteBookView: View {
    @State var show = false
    @State var move = false
    @State var close = false
    @State var isAnimating = false
    @State var isBookOpen = false
    @State var currentPageIndex = 0
    @State var animatingPageIndex = -1
    
    let totalPages = 30

    var body: some View {
        ZStack {
            ZStack {
                // All pages stacked
                ForEach((0..<totalPages).reversed(), id: \.self) { index in
                    NotePage(
                        pageNumber: index + 1,
                        title: "Page \(index + 1)",
                        content: "This is page \(index + 1) content.\nSample text for demonstration."
                    )
                        .rotation3DEffect(
                            .degrees(getPageRotation(for: index)),
                            axis: (x: 0, y: 1, z: 0),
                            anchor: .leading,
                            anchorZ: 0,
                            perspective: 0.3
                        )
                        .opacity(getPageOpacity(for: index))
                        .zIndex(getPageZIndex(for: index))
                        .allowsHitTesting(index == currentPageIndex && isBookOpen)
                }
                
                NoteBackCover(show2: .constant(false), close: $close)
                Rectangle().foregroundStyle(.black)
                    .opacity(0.7)
                    .frame(width: 1)
                    .frame(height: 263)
                    .blur(radius: 5)
                    .offset(x: -90)
            }
            NoteFrontCover(show: $show)
                .zIndex(isBookOpen ? -10 : 100)
            
        }
        .scaleEffect(move ? 1.8 : 1.0)
        .offset(x: move ? -20 : 0, y: move ? 0 : 0)
        .animation(.easeInOut(duration: 1.4), value: move)
        .padding()
        .onTapGesture {
            if !isAnimating {
                if move {
                    // Book is open, flip to next page
                    nextPage()
                } else {
                    // Open book
                    openBookToggle()
                }
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if isBookOpen && !isAnimating {
                        if value.translation.width < -50 {
                            nextPage()
                        } else if value.translation.width > 50 {
                            previousPage()
                        }
                    }
                }
        )
    }
    
    func nextPage() {
        guard currentPageIndex < totalPages - 1, !isAnimating else { return }
        
        isAnimating = true
        animatingPageIndex = currentPageIndex
        
        withAnimation(.easeInOut(duration: 0.8)) {
            currentPageIndex += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            isAnimating = false
            animatingPageIndex = -1
        }
    }
    
    func previousPage() {
        guard currentPageIndex > 0, !isAnimating else { return }
        
        isAnimating = true
        
        withAnimation(.easeInOut(duration: 0.8)) {
            currentPageIndex -= 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            isAnimating = false
        }
    }
    
    func getPageRotation(for index: Int) -> Double {
        if isAnimating && index == animatingPageIndex {
            // Show the page flipping animation
            return currentPageIndex > animatingPageIndex ? -180 : 0
        } else if index < currentPageIndex {
            return -180 // Already flipped pages
        }
        return 0
    }
    
    func getPageOpacity(for index: Int) -> Double {
        return 1.0
    }
    
    func getPageZIndex(for index: Int) -> Double {
        if isAnimating && index == animatingPageIndex {
            return 150 // Animating page on top
        } else if index == currentPageIndex {
            return 100 // Current page on top
        } else if index < currentPageIndex {
            return Double(index - 10) // Flipped pages behind
        } else {
            return Double(index) // Future pages in order
        }
    }

    func openBookToggle() {
        isAnimating = true

        if show {
            withAnimation(.linear(duration: 1).delay(0.49)) {
                show.toggle()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.49) {
                close = true
            }

            withAnimation(.linear(duration: 0.4).delay(0.4)) {
                move.toggle()
            }

        } else {
            close = false

            withAnimation(.linear(duration: 1)) {
                show.toggle()
            }
            withAnimation(.linear(duration: 0.4).delay(0.4)) {
                move.toggle()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            isAnimating = false
            isBookOpen = true
        }
    }
}


#Preview {
    NoteBookView()
}
