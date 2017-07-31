//
//  MovieTableViewController.swift
//  MovieSelector
//
//  Created by Alex Beattie on 7/30/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    var nowPlaying = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        Movie.nowPlaying { (success:Bool, movieList:[Movie]?) in

            if success {
                self.nowPlaying = movieList!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            
            }
            
            //            print(movieList)
//            for movie in movieList! {
//                print(movie.title)
//                print(movie.imagePath)
//                print(movie.description + "\n")
//            }
        }
    }
   
// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nowPlaying.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let movie = nowPlaying[indexPath.row]
        
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.description
        
        
        return cell
    }


}
