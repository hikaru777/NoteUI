import SwiftUI

struct NoteBookView: View {
    @State var show = false
    @State var show2 = false
    @State var move = false
    @State var close = false
    @State var isAnimating = false
    @State var isBookOpen = false

    var body: some View {
        ZStack {
            ZStack {
                // Page 2 - always behind
                NotePage(
                    pageNumber: 2,
                    title: "明日の予定",
                    content: "・朝のミーティング\n・新機能の実装\n・コードレビュー\n・ドキュメント作成"
                )
                
                NoteBackCover(show2: $show2, close: $close)
                Rectangle().foregroundStyle(.black)
                    .opacity(0.7)
                    .frame(width: 1)
                    .frame(height: 263)
                    .blur(radius: 5)
                    .offset(x: -90)
                
                // Page 1 - the one that flips
                NotePage(
                    pageNumber: 1,
                    title: "今日の記録",
                    content: "SwiftUIで美しいアニメーションを作成しました。\n3D回転エフェクトを使って、本のページをめくる動きを再現できました。"
                )
                .rotation3DEffect(
                    .degrees(show2 ? -180 : 0),
                    axis: (x: 0, y: 1, z: 0),
                    anchor: .leading,
                    anchorZ: 0,
                    perspective: 0.3
                )
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
                    // Book is open, flip page
                    flipPage()
                } else {
                    // Open book
                    openBookToggle()
                }
            }
        }
    }
    
    func flipPage() {
        isAnimating = true
        
        withAnimation(.linear(duration: 1)) {
            show2.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isAnimating = false
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
