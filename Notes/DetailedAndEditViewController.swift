//
//  DetailedAndEditViewController.swift
//  Notes
//
//  Created by Harut on 02/07/2019.
//  Copyright © 2019 Harutyun Gevorgyan. All rights reserved.
//

import UIKit

class DetailedAndEditViewController: UIViewController {

    var selectedNote: Note?
    
    @IBOutlet weak var dateTextView: UITextView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var phoneTextView: UITextView!
    @IBOutlet weak var emailTextView: UITextView!
    
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        let editable = dateTextView.isEditable
        
        if editable {
            sender.title = "Edit"
        } else {
            sender.title = "Done"
        }
        dateTextView.isEditable = !editable
        titleTextView.isEditable = !editable
        descriptionTextView.isEditable = !editable
        phoneTextView.isEditable = !editable
        emailTextView.isEditable = !editable
    }
    
    func backAction(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
