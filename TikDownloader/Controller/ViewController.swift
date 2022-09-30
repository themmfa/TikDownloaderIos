//
//  ViewController.swift
//  TikDownloader
//
//  Created by fe on 29.09.2022.
//

import UIKit

struct Colors {
    let disabledButton = UIColor(red: 199/255, green: 68/255, blue: 102/255, alpha: 0.5)

    let enabledButton = UIColor(red: 199/255, green: 68/255, blue: 102/255, alpha: 1)
}

class ViewController: UIViewController {
    var colors = Colors()
    @IBOutlet var videoLinkTextField: UITextField!

    @IBOutlet var getVideoButton: UIButton!

    @IBAction func getVideoButtonPressed(_ sender: UIButton) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        getVideoButton.backgroundColor = colors.disabledButton
        videoLinkTextField.delegate = self
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
