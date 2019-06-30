//
//  LoginViewController.swift
//  Notes
//
//  Created by Arthur Hakobyan on 6/23/19.
//  Copyright © 2019 Arhur Hakobyan. All rights reserved.
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
