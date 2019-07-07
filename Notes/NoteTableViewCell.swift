//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Harut on 6/23/19.
//  Copyright © 2019 Harutyun Gevorgyan. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var noteImageView: UIImageView?
    @IBOutlet weak var dateLabel: UILabel!
    
    // TODO: use DateFormatter for dateLabel.text

    func setup(with note: Note) {
        titleLabel.text = note.title
        dateLabel.text = note.date.description
        if let noteImageView = self.noteImageView {
            noteImageView.image = note.image
        }
    }
}
