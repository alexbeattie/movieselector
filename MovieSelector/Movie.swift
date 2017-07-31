//
//  Movie.swift
//  MovieSelector
//
//  Created by Alex Beattie on 7/30/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import Foundation

public struct Movie {
    
    static let APIKEY = "25de56fc797d73f8e497ae9f4155e1f8"
    
    public var title: String!
    public var imagePath: String!
    public var description: String!
    
    public init(title:String, imagePath:String, description: String) {
       
        self.title = title
        self.imagePath = imagePath
        self.description = description
        
    }
    
    private static func getMovieData (with completion: @escaping(_ success:Bool, _ object:AnyObject?)-> ()) {
        
        let session = URLSession(configuration: .default)
        
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(APIKEY)")!)
        
        session.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                }
            }
        }.resume()
    }
    
    public static func nowPlaying(with completion:@escaping (_ success:Bool, _ movies:[Movie]?)->()){
        Movie.getMovieData { (success, object) in
//            print(object)
            if success {
                var movieArray = [Movie]()
                if let movieResults = object?["results"] as? [Dictionary<String,AnyObject>] {
                    for movie in movieResults {
                        let title = movie["original_title"] as! String
                        let description = movie["overview"] as! String
                        
                        guard let posterImage = movie["poster_path"] as? String else { continue }
                        
                        let movieObj = Movie(title: title, imagePath: posterImage, description: description)
                        
                        movieArray.append(movieObj)
                    
                    }
                    completion(true, movieArray)
                }else {
                    completion(false, nil)
                }
            }
        }
    }
}
