//
//  ContentView.swift
//  NoteUI
//
//  Created by 本田輝 on 2025/08/24.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NoteBookView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
    }
}

#Preview {
    ContentView()
}