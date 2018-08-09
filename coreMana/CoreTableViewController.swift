//
//  CoreTableViewController.swift
//  coreMana
//
//  Created by popCorn on 2018/08/08.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import CoreData
//using coredata for this

class CoreTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var frc: NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        //fetch data from entityName has name: "Entity"
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        //sorted data
        let sorted = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sorted]
        
        return fetchRequest
    }
    func getFRC() -> NSFetchedResultsController<NSFetchRequestResult> {
        frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: pc, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        //dynamic content for cell
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        //test animation view
        Views.frame = CGRect(x: 0, y: 0, width: 130, height: 100)
        Views.backgroundColor = UIColor.red
        //**********
        
        //call getFRC function in view didload
        frc = getFRC()
        frc.delegate = self
        //do try
        do {
            try frc.performFetch()
        } catch {
            print(error)
            return
        }
        //reload tableview after new data was add
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //return the number of object in our coredata
        let numberOfRows = frc.sections?[section].numberOfObjects
        
        return numberOfRows!
    }

    let zoomInImage = UIView()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CoreTableViewCell
        let item = frc.object(at: indexPath) as! Entity 
        //take a look at above line// very important//
        cell.cellTitle.text = item.title
        cell.cellDescription.text = item.descriptionText
        cell.cellImage.image = UIImage(data: (item.image)! as Data)
        
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
//        cell.addGestureRecognizer(longPressGesture)
//
        return cell
    }
    //test 8*****
    let Views: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    @objc func longTap() {
        print("pressed")
        tableView.addSubview(Views)
        UIView.animate(withDuration: 0.3) {
            self.Views.frame = CGRect(x: 50, y: 20, width: 200, height: 130)
            
        }
    }
    //test 8*****
    //display all the data when new record was add
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            //
            let itemController: AddViewController = segue.destination as! AddViewController
            let item: Entity = frc.object(at: indexPath!) as! Entity
            itemController.item = item
        }
    }
    //delete function swipe from right to left to delete object 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //delete object at indexPath
        let deleteObject: NSManagedObject = frc.object(at: indexPath) as! NSManagedObject
        pc.delete(deleteObject)
        do {
            //after delete object at indexPath. try to save all data
            try pc.save()
        } catch {
            //if error.
            print(error)
            return
        }
    }
}
