//
//  NotesListViewController.swift
//  Notes
//
//  Created by Harut on 6/23/19.
//  Copyright © 2019 Harutyun Gevorgyan. All rights reserved.
//

import UIKit


class NotesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource,  AddNoteViewControllerDelegate, DetailedViewControllerDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let note = notes[indexPath.row]
        var reuseIdentifier = "NoteCollectionViewCell"
        
        if note.image != nil {
            reuseIdentifier += "+Image"
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? NoteCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(with: note)
        
        return cell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var editBarItem: UIBarButtonItem!
    
    
    internal var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200.0
        title = "Notes"
    }
    
    @IBAction private func addAction() {
        guard let addViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController else { return }
        addViewController.delegate = self
        let navVC = UINavigationController(rootViewController: addViewController)
        
        present(navVC, animated: true, completion: nil)
        if isEditing {
            isEditing = !isEditing
            editBarItem.title = "Edit"
        }
    }
    
    
    // textshouldchangecharactersinrange -> bool
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        if tableView.isEditing {
            sender.title = "Save"
        } else {
            sender.title = "Edit"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        var reuseIdentifier = "NoteTableViewCell"
        if note.image != nil {
            reuseIdentifier += "+Image"
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
        cell.setup(with: note)
        return cell
    }
    
    
    // TODO: Save notes in memory
    
    // MARK: - AddNoteViewControllerDelegate
    func noteCreated(note: Note) {
        notes.append(note)
        tableView.reloadData()
    }
    
    // implementation of DetailedViewControllerDelegate
    func updateNotes(with: Note) {
        guard let index = notes.firstIndex(where: {$0.id == with.id}) else { return }
        notes[index] = with
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("Tapped accessory button")
        guard let detailedNoteViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController else { return }
        
        detailedNoteViewController.selectedNote = notes[indexPath.row]
        detailedNoteViewController.delegate = self
        
        navigationController?.pushViewController(detailedNoteViewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedNote = notes.remove(at: sourceIndexPath.row)
        notes.insert(movedNote, at: destinationIndexPath.row)
        tableView.reloadData()
    }
}
