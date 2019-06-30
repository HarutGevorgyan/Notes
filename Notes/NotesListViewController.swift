//
//  NotesListViewController.swift
//  Notes
//
//  Created by Arthur Hakobyan on 6/23/19.
//  Copyright © 2019 Arhur Hakobyan. All rights reserved.
//

import UIKit

protocol NotesListViewControllerDelegate: class {
    func selectedNote(note: Note)
}

class NotesListViewController: UITableViewController, AddNoteViewControllerDelegate {
    
    weak var delegate: NotesListViewControllerDelegate?
    
    private var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200.0
        title = "Notes"
    }
    
    @IBAction private func addAction() {
        guard let addViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController else { return }
        addViewController.delegate = self
        let navVC = UINavigationController(rootViewController: addViewController)
        present(navVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        var reuseIdentifier = "NoteTableViewCell"
        if note.image != nil {
            reuseIdentifier += "+Image"
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
        cell.setup(with: note)
        return cell
    }
    
    // MARK: - AddNoteViewControllerDelegate
    func noteCreated(note: Note) {
        notes.append(note)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailedNoteViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailedNoteViewController") as? DetailedNoteViewController else { return }
        delegate = detailedNoteViewController
        delegate?.selectedNote(note: notes[indexPath.row])
        navigationController?.pushViewController(detailedNoteViewController, animated: true)
    }
}
