//
//  PhotoPermission.swift
//  TikDownloader
//
//  Created by fe on 1.10.2022.
//

import Foundation
import Photos

protocol PhotoPermissionDelegate {
    func requestForPermission()
}

struct PhotoPermission {
    var delegate: PhotoPermissionDelegate?

    func requestAuthorization(completion: @escaping () -> Void) {
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { _ in
                DispatchQueue.main.async {
                    completion()
                }
            }
        } else if PHPhotoLibrary.authorizationStatus() == .authorized {
            completion()
        } else if PHPhotoLibrary.authorizationStatus() == .denied {
            PHPhotoLibrary.requestAuthorization { _ in
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
