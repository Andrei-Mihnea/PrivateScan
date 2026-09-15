//
//  CameraService.swift
//  PrivateScan
//
//  Created by Mihnea Andrei on 15/09/2026.
//

import AVFoundation
import UIKit
import Foundation

final class CameraService: NSObject, ObservableObject {
    let session = AVCaptureSession()
    
    var onPhotoCaptured: ((UIImage) -> Void)?
    var onError: ((CameraServiceError) -> Void )?
    
    private let photoOutput = AVCapturePhotoOutput()
    private let sessionQueue = DispatchQueue(
        label: "com.mihneaandrei.PrivateScan.camera-session"
    )
    
    private var isConfigured = false
    private var isCapturingPhoto = false
}
