//
//  uiTableViewController.swift
//  WhereToEat
//
//  Created by Mélanie Godard on 15/12/2016.
//  Copyright © 2016 Wellcut. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    @IBOutlet var restoList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //directory.add(restaurant: Resto(name: "Fab", address: "test address", style: Resto.Style.none))
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(reloadRestos), name: Notification.Name("restoAdded"), object: nil)
        
        let url = URL(string: "https://google.fr")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) -> Void in
            guard error == nil else {
                print("ERROR")
                print(error.debugDescription)
                return
            }
        }
        task.resume()

    }
    /*override func viewDidAppear(_ animated: Bool) {
        restoList.reloadData()
    }*/
    

    private var directory : Directory = Directory.shared

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadRestos() {
        restoList.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return directory.getAll().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "test2", for: indexPath)
        let resto = directory.get(index: indexPath.row)
        // FIXME: guard resto
        cell.textLabel?.text = resto!.name
        cell.detailTextLabel?.text = resto!.address
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            directory.remove(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
        if (segue.identifier == "viewResto") {
            
            guard let destination = segue.destination as? ViewRestoController else {
                return
            }
            guard let tableCell = sender as? UITableViewCell else {
                return
            }
            guard let indexPath = restoList.indexPath(for: tableCell) else {
                return
            }
            destination.resto = directory.get(index: indexPath.row)
        }
        /*else if (segue.identifier == "addResto") {
            guard let destination = segue.destination as? ViewController else {
                return
            }
            destination.directory = directory
        }*/
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
