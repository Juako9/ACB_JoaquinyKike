//
//  RellenaTablaTableViewController.swift
//  EquiposACB
//
//  Created by CETYS on 24/02/18.
//  Copyright © 2018 JoaquinKike. All rights reserved.
//

import UIKit
import CoreData

class RellenaTablaTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var managedObjectContext : NSManagedObjectContext? = nil
    
    var fetchedResultsController  = NSFetchedResultsController<NSFetchRequestResult>()
    
    
    /*a este método se le llama:
     - cuando se crea un nuevo modelo
     - cuando un modelo existente se actualiza
     - cuando un modelo existente se borra
     */
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .insert: self.tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete: self.tableView.deleteRows(at: [indexPath!], with: .fade)
        default:return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EquiposACB")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending:true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
            print("datos cargados ok")
        }   catch let error as NSError{
            print("No se ha podido leer \(error), \(error.userInfo)")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaBasica", for: indexPath)
        
        let registro : NSManagedObject = self.fetchedResultsController.object(at: indexPath) as! NSManagedObject
        
        // Configure the cell...
        cell.textLabel?.text = registro.value(forKey: "nombre") as! String?
        cell.detailTextLabel?.text = registro.value(forKey: "estadio") as! String?
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
         let pantallaDestino: VerEquipoViewController = segue.destination as! VerEquipoViewController
        let indice = tableView.indexPathForSelectedRow
        let registro: NSManagedObject = self.fetchedResultsController.object(at: indice!) as! NSManagedObject
        
        pantallaDestino.nombreEquipo = registro.value(forKey: "nombre") as! String
        pantallaDestino.nombreCiudad = registro.value(forKey: "ciudad") as! String
        pantallaDestino.nombreEstadio = registro.value(forKey: "estadio") as! String
        pantallaDestino.coordenadaX = registro.value(forKey: "latitud") as! NSDecimalNumber
        pantallaDestino.coordenadaY = registro.value(forKey: "longitud") as! NSDecimalNumber
        

     }
    
}
