//
//  DetailedViewController.swift
//  Notes
//
//  Created by Harut on 02/07/2019.
//  Copyright © 2019 Harutyun Gevorgyan. All rights reserved.
//

import UIKit
import MessageUI

protocol DetailedViewControllerDelegate: class {
    func updateNotes(with: Note)
    var notes: [Note] { get set }
}


class DetailedViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var phoneNumberButtonOutlet: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailButtonOutlet: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imagelabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chooseImageButtonOutlet: UIButton!
    var selectedNote: Note?
    var delegate: DetailedViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAndSetViewToReadOnlyMode()
        chooseImageButtonOutlet.layer.borderColor = UIColor.gray.cgColor
        chooseImageButtonOutlet.layer.cornerRadius = 6
        chooseImageButtonOutlet.layer.borderWidth = 0.5
    }
    
    
    @IBAction func editBarItemTapped(_ sender: UIBarButtonItem) {
        let viewIsInEditModeWhenButtonTapped = titleTextField.isUserInteractionEnabled
        
        if viewIsInEditModeWhenButtonTapped {
            updateSelectedNote()
            delegate?.updateNotes(with: selectedNote!)
            updateAndSetViewToReadOnlyMode()
            sender.title = "Edit"
        } else {
            turnOnEditigMode()
            sender.title = "Save"
        }
    }
    
    
    func updateAndSetViewToReadOnlyMode() {
        titleTextField.text = selectedNote?.title
        titleTextField.isUserInteractionEnabled = false
        titleTextField.borderStyle = .none
        
        descriptionTextField.text = selectedNote?.description
        descriptionTextField.isUserInteractionEnabled = false
        descriptionTextField.borderStyle = .none
        
        phoneNumberButtonOutlet.setTitle(selectedNote?.phone, for: .normal)
        phoneNumberTextField.text = selectedNote?.phone
        phoneNumberButtonOutlet.isHidden = false
        phoneNumberTextField.isHidden = true
        
        emailButtonOutlet.setTitle(selectedNote?.email, for: .normal)
        emailTextField.text = selectedNote?.email
        emailButtonOutlet.isHidden = false
        emailTextField.isHidden = true
        
        datePicker.setDate((selectedNote?.date)!, animated: true)
        dateLabel.text = selectedNote?.date.description
        dateLabel.isHidden = false
        datePicker.isHidden = true
        
        chooseImageButtonOutlet.isHidden = true
        
        if let image = selectedNote?.image {
            imageView.isHidden = false
            imagelabel.isHidden = false
            imageView.image = image
        } else {
            chooseImageButtonOutlet.isHidden = true
            imageView.isHidden = true
            imagelabel.isHidden = true
        }
    }
    
    
    func updateSelectedNote() {
        selectedNote?.title = titleTextField.text!
        selectedNote?.description = descriptionTextField.text!
        selectedNote?.email = emailTextField.text!
        selectedNote?.phone = phoneNumberTextField.text!
        selectedNote?.date = datePicker.date
        selectedNote?.image = imageView.image
    }
    
    
    func turnOnEditigMode() {
        titleTextField.isUserInteractionEnabled = true
        titleTextField.borderStyle = .roundedRect
        
        descriptionTextField.isUserInteractionEnabled = true
        descriptionTextField.borderStyle = .roundedRect
        
        phoneNumberButtonOutlet.isHidden = true
        phoneNumberTextField.isHidden = false
        
        emailButtonOutlet.isHidden = true
        emailTextField.isHidden = false
        
        datePicker.isHidden = false
        dateLabel.isHidden = true
        
        imagelabel.isHidden = false
        imageView.isHidden = false
        chooseImageButtonOutlet.isHidden = false
    }
    
    
    // MARK: Call/Send message
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        let alertContoller = UIAlertController(title: "Choose action", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertContoller.addAction(cancelAction)
        
        let callAction = UIAlertAction(title: "Call", style: .default, handler: ({ (action) in
            guard let number = self.phoneNumberButtonOutlet.titleLabel?.text else { return }
            if let url = URL(string: "tel://\(number)") {
                UIApplication.shared.canOpenURL(url)
            } else {
                print("wrong number")
            }
        }))
        alertContoller.addAction(callAction)
        
        
        let sendSMSAction = UIAlertAction(title: "Send message", style: .default) {
            (action) in
            guard MFMessageComposeViewController.canSendText() else {
                print("Can not send message")
                return
            }
            
            let messageComposer = MFMessageComposeViewController()
            messageComposer.messageComposeDelegate = self
            guard let number = self.phoneNumberButtonOutlet.titleLabel?.text else { return }
            
            messageComposer.recipients = [number]
            messageComposer.body = "Message was sent from MyNote application"
        }
        alertContoller.addAction(sendSMSAction)
        present(alertContoller, animated: true, completion: nil)
    }
    
    
    // Delegate func for Message
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Send Email
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        
        guard MFMailComposeViewController.canSendMail() else {
            print("Can not send email")
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        guard let email = emailButtonOutlet.titleLabel?.text else {
            print("wrong email")
            return
        }
        
        mailComposer.setSubject("initial mail")
        mailComposer.setToRecipients([email])
        mailComposer.setMessageBody("Hello, this message was sent from the iPhone", isHTML: false)
        
        present(mailComposer, animated: true, completion: nil)
    }
    
    
    // MARK: Choose Image
    @IBAction func chooseImageButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose image source", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameratAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameratAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "PhotoLibrary", style: .default, handler: { (action) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        present(alertController, animated: true)
    }
    
    
    // Image picker Delegate function
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
