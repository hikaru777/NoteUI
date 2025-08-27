import SwiftUI

struct NoteFrontCover: View {
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
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
            
            VStack {
                Text("My Notebook")
                    .font(.custom("Noteworthy", size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("2025")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .rotation3DEffect(
            .degrees(show ? -180 : 0),
            axis: (x: 0, y: 1, z: 0),
            anchor: .leading,
            anchorZ: 0,
            perspective: 0.3
        )
    }
}
