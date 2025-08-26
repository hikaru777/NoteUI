//
//  ContentView.swift
//  NoteUI
//
//  Created by 本田輝 on 2025/08/24.
//
import SwiftUI

struct ContentView: View {
    @State private var isBookOpen = false
    
    var body: some View {
        ZStack {
            NoteBookView(isBookOpenBinding: $isBookOpen)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
                .onChange(of: isBookOpen) { newValue in
                    // Handle book open state change if needed
                }
            
            if isBookOpen {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isBookOpen = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}