//
//  Note.swift
//  Notes
//
//  Created by Harut on 30/06/2019.
//  Copyright © 2019 Arhur Hakobyan. All rights reserved.
//

import UIKit

struct Note {
    var title: String
    var description: String
    var phone: String
    var email: String
    var image: UIImage?
    var date: Date
    
    init(title: String, description: String, phone: String, email: String, date: Date, image: UIImage? = nil) {
        self.title = title
        self.description = description
        self.phone = phone
        self.email = email
        self.date = date
        self.image = image
    }
}
