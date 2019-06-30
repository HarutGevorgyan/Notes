//
//  DetailedNoteViewController.swift
//  Notes
//
//  Created by Harut on 30/06/2019.
//  Copyright © 2019 Arhur Hakobyan. All rights reserved.
//

import UIKit


class DetailedNoteViewController: UIViewController, NotesListViewControllerDelegate {
    
    var selectedNote: Note?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneNumber: UIButton!
    @IBOutlet weak var email: UIButton!
    
    
    @IBAction func phoneNumberTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        
    }
    
    
    @IBAction func notesItemTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
