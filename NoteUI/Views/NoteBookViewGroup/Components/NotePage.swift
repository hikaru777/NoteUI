import SwiftUI

struct NotePage: View, Identifiable {
    let id = UUID()
    let pageNumber: Int
    let title: String
    let content: String
    let isFlipped: Bool
    
    init(pageNumber: Int, title: String, content: String, isFlipped: Bool = false) {
        self.pageNumber = pageNumber
        self.title = title
        self.content = content
        self.isFlipped = isFlipped
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 180, height: 263)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 8, topTrailingRadius: 8, style: .continuous))
                .overlay(
                    //ここにページ一枚一枚の要素を追加する
                    Group {
                        if !isFlipped {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Page \(pageNumber)")
                                    .font(.caption)
                                    .foregroundColor(.black.opacity(0.5))
                                
                                Text(title)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                Text(content)
                                    .font(.system(size: 10))
                                    .lineSpacing(5)
                                    .foregroundColor(.black)
                            }
                            .frame(width: 150, height: 220)
                        }
                    }
                )
        }
    }
}
