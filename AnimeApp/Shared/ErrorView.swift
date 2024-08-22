//
//  ErrorView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 22.08.2024.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    @State private var showingAlert = true
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color("Background")
            Spacer()
                .alert("An error occurred", isPresented: $showingAlert) {
                    Button("Back", role: .cancel) {
                        dismiss()
                    }
                } message: {
                    Text("\(error.localizedDescription)")
                }
        }
    }
}
