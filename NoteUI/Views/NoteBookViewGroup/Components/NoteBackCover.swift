import SwiftUI

struct NoteBackCover: View {
    @Binding var show2: Bool
    @Binding var close: Bool

    var body: some View {
        
        UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 8, topTrailingRadius: 8, style: .continuous)
            .fill(LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.2, green: 0.3, blue: 0.5),
                    Color(red: 0.3, green: 0.4, blue: 0.6)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .frame(width: 182, height: 264)
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 8, topTrailingRadius: 8, style: .continuous))
            .rotation3DEffect(
                .degrees(show2 ? -180 : 0),
                axis: (x: 0, y: 1, z: 0),
                anchor: .leading,
                anchorZ: 0,
                perspective: 0.3
            )
            .opacity(close ? 0 : 1)
    }
}
