//
//  RootTableViewController.swift
//  SinkOrSwim
//
//  Created by Joseph DiLiello on 9/6/21.
//

import UIKit

class RootTableViewController: UITableViewController {

    lazy var movieModel:MovieModel = {
        return MovieModel.sharedInstance()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    // set up the number of different types of cells (i.e. sections)
    override func numberOfSections(in tableView: UITableView) -> Int {
        // there are only three sections here
        // 0: Detailed Image Selection
        // 1: Collection Image View
        // 2: Play Guessing Game
        return movieModel.genreDict.count
    }

    // set up the number of rows per section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // all sections here only have 1 row per section
        // written to be a little more flexible if need to adjust
        if let genre = movieModel.genreArray[section] as? NSString{
            if let titleList = movieModel.genreDict[genre] as? NSMutableArray{
                return titleList.count
            }
            return 0
        } else {
            return 0
        }
        
    }

    // fill each row with text/label
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let genre = movieModel.genreArray[indexPath.section] as! String
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Action", for: indexPath)
            let titles = movieModel.genreDict[genre] as! Array<Any>
            cell.textLabel!.text = titles[indexPath.row] as? String
            cell.detailTextLabel?.text = genre
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Adventure", for: indexPath)
            let titles = movieModel.genreDict[genre] as! Array<Any>
            cell.textLabel!.text = titles[indexPath.row] as? String
            cell.detailTextLabel?.text = genre
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Comedy", for: indexPath)
            let titles = movieModel.genreDict[genre] as! Array<Any>
            cell.textLabel!.text = titles[indexPath.row] as? String
            cell.detailTextLabel?.text = genre
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Drama", for: indexPath)
            let titles = movieModel.genreDict[genre] as! Array<Any>
            cell.textLabel!.text = titles[indexPath.row] as? String
            cell.detailTextLabel?.text = genre
            return cell
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? ScrollViewController,
           let cell = sender as? UITableViewCell,
           let name = cell.textLabel?.text {
                vc.displayImageName = name
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
