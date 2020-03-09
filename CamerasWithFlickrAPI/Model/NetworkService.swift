//
//  NetworkService.swift
//  CamerasWithFlickrAPI
//
//  Created by Stepan Vasilyeu on 3/9/20.
//  Copyright © 2020 Stepan Vasilyeu. All rights reserved.
//

import Foundation

class NetworkService {
    
    func fetchTrack(apiKey: String, search: String, completion: @escaping (SearchResponse?) -> Void) {
        let jsonUrl = "https://www.flickr.com/services/rest/?method=flickr.cameras.getBrandModels&api_key=\(apiKey)&brand=\(search)&format=json&nojsoncallback=1"
        
        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let tracksProperty = try JSONDecoder().decode(SearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(tracksProperty)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
