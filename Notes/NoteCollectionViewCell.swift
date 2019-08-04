//
//  NoteCollectionViewCell.swift
//  Notes
//
//  Created by Harut on 07/07/2019.
//  Copyright © 2019 Harutyun Gevorgyan. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var noteImageView: UIImageView?
    
    // TODO: use DateFormatter for dateLabel.text
    
    func setup(with note: Note) {
        titleLabel.text = note.title
        phoneNumberButton.setTitle(note.phone, for: .normal)
        emailButton.setTitle(note.email, for: .normal)
        if let noteImageView = self.noteImageView {
            noteImageView.image = note.image
        }
    }
}
