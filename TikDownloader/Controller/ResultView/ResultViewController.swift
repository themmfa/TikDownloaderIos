//
//  ResultViewController.swift
//  TikDownloader
//
//  Created by fe on 30.09.2022.
//

import AVFoundation
import AVKit
import Photos
import UIKit

class ResultViewController: UIViewController {
    var resultManager = ResultManager()

    @IBOutlet var selectedVideoLabel: UILabel!

    @IBOutlet var videoView: UIView!

    @IBOutlet var descriptionLabel: UILabel!

    @IBOutlet var downloadButton: UIButton!

    @IBAction func downloadButtonPressed(_ sender: UIButton) {
        if let url = videoUrl {
            self.resultManager.downloadVideoLinkAndCreateAsset(url)
        }
    }

    var videoUrl: String?
    var videoDescription: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultManager.delegate = self
        changeButtonBorder()
        createVideoView()
        self.descriptionLabel.text = self.videoDescription
    }
}

extension ResultViewController: ResultManagerDelegate {
    func didFailedWithError(error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func didVideoDownloaded() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "Video downloaded successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: UI elements

extension ResultViewController {
    func changeButtonBorder() {
        self.downloadButton.layer.cornerRadius = 5
        self.downloadButton.layer.borderWidth = 1
        self.downloadButton.layer.borderColor = #colorLiteral(red: 0.7799922228, green: 0.2651723921, blue: 0.4012082517, alpha: 1)
    }

    @IBAction func saveAnotherPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }

    func createVideoView() {
        if let url = URL(string: self.videoUrl!) {
            let player = AVPlayer(url: url)
            let avController = AVPlayerViewController()
            avController.player = player
            avController.view.frame = self.videoView.bounds
            avController.videoGravity = .resizeAspectFill
            self.videoView.addSubview(avController.view)
            self.addChild(avController)
        }
    }
}
