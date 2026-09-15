//
//  ReviewView.swift
//  PrivateScan
//
//  Created by Mihnea Andrei on 14/09/2026.
//
import SwiftUI
import UIKit

struct ReviewView: View {
    let pages: [UIImage]
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPage = 0
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedPage) {
                ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                    Image(uiImage: page)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .navigationTitle("Review Scan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Text("\(pages.count) page\(pages.count == 1 ? "" : "s")")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
