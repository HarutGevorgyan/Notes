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
    var notes: [Note] { get set }
}

class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // TODO: Save notes in memory
    
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
        titleField.delegate = self
        
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
        if let title = titleField.text,  let description = descriptionTextView.text, let phone = phoneTextField.text, let email = emailTextField.text {
            
            if !title.isEmpty && !description.isEmpty && !phone.isEmpty && !email.isEmpty  {
                let newNoteID = delegate!.notes.isEmpty ? 1 : (delegate?.notes.last?.id)! + 1
                let note = Note(title: title, description: description, phone: phone, email: email, date: datePicker.date, id: newNoteID,  image: imageView.image)
                
                // TODO: checks for email and phoneNumber
                
                delegate?.noteCreated(note: note)
                navigationController?.dismiss(animated: true, completion: nil)
            } else {
                let alertcontroller = UIAlertController(title: "Insuficcient information", message: "You should fill Title, Description, Phone and Email fields", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertcontroller.addAction(okAction)
                present(alertcontroller, animated: true)
            }
        }
    }
    
    @IBAction private func imageSelectAction() {
        openImagePicker()
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

extension AddNoteViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength < 20
    }
}
