//
//  ViewControllerExtensions.swift
//  TikDownloader
//
//  Created by fe on 30.09.2022.
//

import UIKit

extension ViewController: VideoManagerDelegate {
    func didUpdateVideo(_ videoManager: VideoManager, video: VideoModel) {
        videoUrl = video.urlString
        videoDesc = video.description
    }

    func didFailedWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.videoLinkTextField.text = ""
            let alert = UIAlertController(title: "Error", message: "Please enter a valid link", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        videoLinkTextField.endEditing(true)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter a video link"
            return false
        }
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            getVideoButton.isEnabled = true
            getVideoButton.backgroundColor = colors.enabledButton
        } else {
            getVideoButton.isEnabled = false
            getVideoButton.backgroundColor = colors.disabledButton
        }
    }
}
