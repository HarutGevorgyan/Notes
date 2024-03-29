//
//  Note.swift
//  Notes
//
//  Created by Harut on 30/06/2019.
//  Copyright © 2019 Harutyun Gevorgyan. All rights reserved.
//

import UIKit

struct Note {
    var title: String
    var description: String
    var phone: String
    var email: String
    var image: UIImage?
    var date: Date
    var id: Int
    
    init(title: String, description: String, phone: String, email: String, date: Date, id: Int, image: UIImage? = nil) {
        self.title = title
        self.description = description
        self.phone = phone
        self.email = email
        self.date = date
        self.id = id
        self.image = image
    }
}
