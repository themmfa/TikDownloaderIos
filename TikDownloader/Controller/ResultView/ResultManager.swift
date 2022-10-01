//
//  ResultManager.swift
//  TikDownloader
//
//  Created by fe on 1.10.2022.
//

import Foundation
import Photos

protocol ResultManagerDelegate {
    func didFailedWithError(error: String)
    func didVideoDownloaded()
}

struct ResultManager {
    var delegate: ResultManagerDelegate?

    func downloadVideoLinkAndCreateAsset(_ videoLink: String) {
        guard let videoURL = URL(string: videoLink) else { return }

        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        // check if the file already exist at the destination folder if you don't want to download it twice
        if !FileManager.default.fileExists(atPath: documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent).path) {
            // set up your download task
            URLSession.shared.downloadTask(with: videoURL) { data, response, _ in
                let urlData = NSData(contentsOf: data!)
                let galleryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let filePath = "\(galleryPath)/\(response?.suggestedFilename ?? "default").mp4"
                if PHPhotoLibrary.authorizationStatus() == .authorized {
                    DispatchQueue.main.async {
                        urlData!.write(toFile: filePath, atomically: true)
                        PHPhotoLibrary.shared().performChanges({
                            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL:
                                URL(fileURLWithPath: filePath))
                        }) {
                            success, _ in
                            if success {
                                self.delegate?.didVideoDownloaded()
                            } else {
                                self.delegate?.didFailedWithError(error: "Video could not saved.")
                            }
                        }
                    }
                } else {
                    self.delegate?.didFailedWithError(error: "You have to give permission to save video. Please go to settings and give Photos permission")
                }
            }.resume()

        } else {
            self.delegate?.didFailedWithError(error: "Video already saved.")
        }
    }
}
