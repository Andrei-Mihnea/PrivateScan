//
//  DocumentScanner.swift
//  PrivateScan
//
//  Created by Mihnea Andrei on 14/09/2026.
//
import SwiftUI
import UIKit
import VisionKit

struct DocumentScanner: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let onScan: ( [UIImage] ) -> Void
    
    // The bridge that creates the UIKit screen
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let scanner = VNDocumentCameraViewController()
        scanner.delegate = context.coordinator // subscribing context.coordinator method to scanner
        return scanner
    }
    
    func updateUIViewController(
        _ uiViewController : VNDocumentCameraViewController,
        context: Context
    ) {
        // Nothing to update yet
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented, onScan: onScan)
    }
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        @Binding private var isPresented: Bool
        private let onScan: ( [UIImage] ) -> Void
        
        init(
            isPresented: Binding<Bool>,
            onScan: @escaping ( [UIImage] ) -> Void
        ) {
            _isPresented = isPresented
            self.onScan = onScan
        }
        
        func documentCameraViewControllerDidCancel(
            _ controller: VNDocumentCameraViewController
        ) {
            isPresented = false
        }
        
        func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFinishWith scan: VNDocumentCameraScan
        ) {
            let pages = (0..<scan.pageCount).map{ scan.imageOfPage(at: $0) }
            
            onScan(pages)
            isPresented = false
        }
        
        func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFailWithError error: any Error)
        {
            isPresented = false
            
        }
    }
}
