//
//  MainTableViewController.swift
//  TableViewAndCamera
//
//  Created by Ember on 2017/5/14.
//  Copyright © 2017年 Ember. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate,NSFetchedResultsControllerDelegate {

    var photos:[PhotoMO] = []
    var image:UIImage!
    var fetchResultController:NSFetchedResultsController<PhotoMO>!  //?????
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //core data related
        let fetchRequest: NSFetchRequest<PhotoMO> = PhotoMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
            if let fetchedObjects = fetchResultController.fetchedObjects {
                photos = fetchedObjects
            }
        } catch {
            print(error.localizedDescription)
        }
        //*****************************************
    }

    //????
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    //????
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                self.tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            self.tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            photos = fetchedObjects as! [PhotoMO]
        }
    }
    
    //????
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
 
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return photos.count
    }

    //tableview display pic + description
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let photo = photos[indexPath.row]
        cell.imageView?.image = UIImage(data: photo.photo! as Data)
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = photo.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let photoToDelete = self.fetchResultController.object(at: indexPath)
            context.delete(photoToDelete)
            appDelegate.saveContext()
        }
    }
    
    //add picture, call camera
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let cameraView = UIImagePickerController()
        cameraView.delegate = self
        cameraView.sourceType = .camera
        self.present(cameraView, animated: true, completion: nil)
    }
    
    //perform segue
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.image = image
            self.performSegue(withIdentifier: "gotoAdd", sender: self)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //pass pic and desc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoAdd"{
            let dvc = segue.destination as! AddViewController
            dvc.image = image
        }else{
            let dvc = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            dvc.photo = photos[indexPath.row]
        }
    }
}
