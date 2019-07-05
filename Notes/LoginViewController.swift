//
//  LoginViewController.swift
//  Notes
//
//  Created by Harut on 6/23/19.
//  Copyright © 2019 Harutyun Gevorgyan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 6.0
    }
    
    @IBAction private func loginAction() {
        guard let notesViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotesListViewController") as? NotesListViewController else { return }
        let navVC = UINavigationController(rootViewController: notesViewController)
        present(navVC, animated: true, completion: nil)
    }
}
