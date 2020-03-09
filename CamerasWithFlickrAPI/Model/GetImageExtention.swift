//
//  GetImageExtention.swift
//  CamerasWithFlickrAPI
//
//  Created by Stepan Vasilyeu on 3/9/20.
//  Copyright © 2020 Stepan Vasilyeu. All rights reserved.
//

import UIKit

extension UIImageView {

    func setImage(imageURL: String?) {
        guard let url = URL(string: imageURL ?? "Unknown") else {
            self.image = nil
            return
        }
        
        if let chachedImage = self.getCachedImage(url: url) {
            self.image = chachedImage
            print("from cached")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) {  (data, response, error) in
            guard let data = data, let response = response else {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                print("from internet")
            }
            self.saveImageCache(data: data, response: response)
        }
        dataTask.resume()
    }
    
    private func getCachedImage(url: URL) -> UIImage? {
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    private func saveImageCache(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}

