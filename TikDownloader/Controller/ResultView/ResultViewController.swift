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
    @IBOutlet var selectedVideoLabel: UILabel!

    @IBOutlet var videoView: UIView!

    @IBOutlet var descriptionLabel: UILabel!

    @IBOutlet var downloadButton: UIButton!

    @IBAction func downloadButtonPressed(_ sender: UIButton) {}

    var videoUrl: String?
    var videoDescription: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        changeButtonBorder()
        createVideoView()
        self.descriptionLabel.text = self.videoDescription
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
            avController.view.frame = self.videoView.frame
            self.view.addSubview(avController.view)
            self.addChild(avController)
        }
    }
}
