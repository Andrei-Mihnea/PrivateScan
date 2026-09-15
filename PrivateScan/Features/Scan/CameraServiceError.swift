//
//  ScanError.swift
//  PrivateScan
//
//  Created by Mihnea Andrei on 15/09/2026.
//
import Foundation

enum CameraServiceError: LocalizedError{
    case permissionDenied
    case cameraUnavailable
    case unableToAddCameraInput
    case unableToAddPhotoOutput
    case cameraNotReady
    case failedToCapturePhoto
    case configurationFailed
    
    var errorDescription: String? {
        switch self {
        case .permissionDenied:
            "Camera access is needed to scan documents."
        case .cameraUnavailable:
            "The back camera is unavailable."
        case .unableToAddCameraInput, .unableToAddPhotoOutput:
            "PrivateScan could not configure the camera."
        case .cameraNotReady:
            "The camera is still getting ready."
        case .failedToCapturePhoto:
            "PrivateScan could not capture that page. Please try again."
        case .configurationFailed:
            "PrivateScan could not start the camera."
        }
    }
}
