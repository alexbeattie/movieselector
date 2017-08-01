//
//  MovieCollectionViewController.swift
//  MovieSelector
//
//  Created by Alex Beattie on 7/31/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MovieCollectionViewController: UICollectionViewController {

    var nowPlaying = [Movie]()
    let movieTransitionDelegate = MovieTransitionDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        let width = collectionView!.frame.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)

        loadData()
    }
    func loadData() {
        Movie.nowPlaying { (success:Bool, movieList:[Movie]?) in
            
            if success {
                self.nowPlaying = movieList!
                DispatchQueue.main.async {
                    self.collectionView!.reloadData()
                }
                
            }
        }
    }
  

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlaying.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
    
        let movie = nowPlaying[indexPath.row]
        
        cell.movieTitleLable.text = movie.title
        Movie.getImage(forCell: cell, withMovieObject: movie)
        
        // Configure the cell
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showOverlayFor(indexPath: indexPath)
    }
    
    
    
    func showOverlayFor (indexPath:IndexPath) {
        
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let overlayVC = sb.instantiateViewController(withIdentifier: "Overlay") as! OverlayViewController
        
        transitioningDelegate = movieTransitionDelegate
        overlayVC.transitioningDelegate = movieTransitionDelegate
        overlayVC.modalPresentationStyle = .custom
        
        let movie = nowPlaying[indexPath.row]
        
        self.present(overlayVC, animated: true, completion: nil)
        
        overlayVC.movieItem = movie
    
    
    }
  

    
    
    
    
    
    
}
