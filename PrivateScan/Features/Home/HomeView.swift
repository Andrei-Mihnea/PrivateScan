//
//  HomeView.swift
//  PrivateScan
//
//  Created by Mihnea Andrei on 14/09/2026.
//

import SwiftUI

/// The first screen keeps the main job—starting a scan—within immediate reach.
/// Saved documents will replace the empty state as local persistence is added.
struct HomeView: View {
    @State private var showsScannerPlaceholder = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    header
                    scanCard
                    recentDocuments
                    privacyNote
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Private Scan")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showsScannerPlaceholder = true
                    } label: {
                        Image(systemName: "camera")
                    }
                    .accessibilityLabel("Start a new scan")
                }
            }
            .alert("Scanner coming next", isPresented: $showsScannerPlaceholder) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("The next step is connecting this button to the secure, on-device document camera.")
            }
        }
        .tint(.indigo)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Good to see you.")
                .font(.title2.weight(.semibold))

            Text("Capture paperwork, receipts, and notes without sending them anywhere.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }

    private var scanCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image(systemName: "doc.viewfinder")
                .font(.system(size: 32, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 58, height: 58)
                .background(.indigo.gradient, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 6) {
                Text("Scan a document")
                    .font(.title3.weight(.semibold))

                Text("Point your camera at a page and PrivateScan will take care of the rest.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Button {
                showsScannerPlaceholder = true
            } label: {
                Label("Start scanning", systemImage: "camera.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .accessibilityHint("Opens the document camera")
        }
        .padding(22)
        .background(.background, in: RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 18, y: 8)
    }

    private var recentDocuments: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Recent documents")
                .font(.headline)

            ContentUnavailableView {
                Label("No documents yet", systemImage: "doc.text.image")
            } description: {
                Text("Your saved scans will appear here. They stay on this device unless you choose to export them.")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
            .background(.background, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        }
    }

    private var privacyNote: some View {
        Label {
            Text("Private by default — scans, text recognition, and search will run on your device.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        } icon: {
            Image(systemName: "lock.fill")
                .foregroundStyle(.red)
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ContentView()
}
