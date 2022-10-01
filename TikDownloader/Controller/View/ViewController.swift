//
//  ViewController.swift
//  TikDownloader
//
//  Created by fe on 29.09.2022.
//

import Photos
import UIKit

struct Colors {
    let disabledButton = UIColor(red: 199/255, green: 68/255, blue: 102/255, alpha: 0.5)

    let enabledButton = UIColor(red: 199/255, green: 68/255, blue: 102/255, alpha: 1)
}

class ViewController: UIViewController {
    var colors = Colors()
    var videoManager = VideoManager()
    var photoPermission = PhotoPermission()
    var videoUrl: String?
    var videoDesc: String?

    @IBOutlet var videoLinkTextField: UITextField!

    @IBOutlet var getVideoButton: UIButton!

    @IBAction func getVideoButtonPressed(_ sender: UIButton) {
        if videoLinkTextField.text != nil, videoLinkTextField.text!.contains("tiktok") {
            videoManager.performRequest(with: videoLinkTextField.text!) {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "GoToVideo", sender: self)
                }
            }

        } else {
            videoLinkTextField.text = ""
            let alert = UIAlertController(title: "Error", message: "Please enter a valid link", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        photoPermission.delegate = self
        requestForPermission()
        getVideoButton.backgroundColor = colors.disabledButton
        videoLinkTextField.delegate = self
        videoManager.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToVideo" {
            videoLinkTextField.text = ""
            let destionationVC = segue.destination as! ResultViewController
            destionationVC.videoUrl = videoUrl
            destionationVC.videoDescription = videoDesc
        }
    }
}

extension ViewController: PhotoPermissionDelegate {
    func requestForPermission() {
        photoPermission.requestAuthorization {
            if PHPhotoLibrary.authorizationStatus() == .denied {
                let alert = UIAlertController(title: "Error", message: "You can't use the app without permission.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}