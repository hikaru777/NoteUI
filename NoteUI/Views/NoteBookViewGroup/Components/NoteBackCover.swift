import SwiftUI

struct NoteBackCover: View {
    @Binding var show2: Bool
    @Binding var close: Bool

    var body: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: 180, height: 264)
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
