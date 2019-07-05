//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Harut on 6/23/19.
//  Copyright © 2019 Harutyun Gevorgyan. All rights reserved.
//

import UIKit
import AVKit

protocol AddNoteViewControllerDelegate: class {
    func noteCreated(note: Note)
}

class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var delegate: AddNoteViewControllerDelegate?
    
    @IBOutlet private weak var titleField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageSelectButton: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()

        imageSelectButton.layer.cornerRadius = 6.0
        imageSelectButton.layer.borderWidth = 0.5
        imageSelectButton.layer.borderColor = UIColor.blue.cgColor
        imageSelectButton.setTitleColor(.blue, for: .normal)

        descriptionTextView.layer.cornerRadius = 6.0
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
    }
    
    @IBAction private func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func saveAction() {
        if let title = titleField.text, let phone = phoneTextField.text, let email = emailTextField.text, let description = descriptionTextView.text {
            
            let note = Note(title: title, description: description, phone: phone, email: email, date: datePicker.date, image: imageView.image)
            
            delegate?.noteCreated(note: note)
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction private func imageSelectAction() {
        openImagePicker()
//        let videoStatus = AVCaptureDevice.authorizationStatus(for: .video)
//        if videoStatus == .notDetermined {
//            AVCaptureDevice.requestAccess(for: .video) { response in
//                if response {
//                    self.openImagePicker()
//                } else {
//                    // TODO: (Arthur) Show alert
//                }
//            }
//        } else if videoStatus == .authorized {
//            openImagePicker()
//        } else {
//            // TODO: (Arthur) Show alert
//        }
    }
    
    func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
