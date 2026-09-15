//
//  ScanSession.swift
//  PrivateScan
//
//  Created by Mihnea Andrei on 14/09/2026.
//

import UIKit

struct ScanSession {
    private(set) var pages: [UIImage] = []
    
    mutating func replacePages( with pages: [UIImage] ) {
        self.pages = pages
    }
    
    mutating func reset() {
        pages.removeAll()
    }
}
