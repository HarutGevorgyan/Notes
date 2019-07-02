//
//  DetailedNoteViewController.swift
//  Notes
//
//  Created by Harut on 30/06/2019.
//  Copyright © 2019 Arhur Hakobyan. All rights reserved.
//

import UIKit
import MessageUI


class DetailedNoteViewController: UIViewController, MFMailComposeViewControllerDelegate { //, NotesListViewControllerDelegate {
    
    var selectedNote: Note?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneNumber: UIButton!
    @IBOutlet weak var email: UIButton!
    
    @IBAction func editTapped(_ sender: UIBarButtonItem) {
        
    }
    
    
    @IBAction func phoneNumberTapped(_ sender: UIButton) {
        guard let phoneNum = sender.titleLabel?.text else { return }
        guard let number = URL(string: "tel://" + phoneNum) else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Can not send email")
            return
        }
        
        guard let mail = sender.titleLabel?.text else { return }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        mailComposer.setSubject("initial mail")
        mailComposer.setToRecipients([mail])
        mailComposer.setMessageBody("Hello, this message was sent from the iPhone", isHTML: false)
        
        present(mailComposer, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Add NotesListViewControllerDelegate
    func selectedNote(note: Note) {
        selectedNote = note
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let note = selectedNote else { return }
        
        titleLabel.text = note.title
        descriptionLabel.text = note.description
        dateLabel.text = note.date.description
        phoneNumber.setTitle(note.phone, for: .normal)
        email.setTitle(note.email, for: .normal)
        
        if let image = note.image {
            imageView.image = image
        } else {
            imageView.isHidden = true
        }
    }
    
    
}
