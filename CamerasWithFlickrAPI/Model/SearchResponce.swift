//
//  SearchResponce.swift
//  CamerasWithFlickrAPI
//
//  Created by Stepan Vasilyeu on 3/9/20.
//  Copyright © 2020 Stepan Vasilyeu. All rights reserved.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let cameras: Cameras?
    let stat: String?
}

// MARK: - Cameras
struct Cameras: Codable {
    let brand: String?
    let camera: [Camera]?
}

// MARK: - Camera
struct Camera: Codable {
    let id: String?
    let name: Name?
    let details: Details?
    let images: Images?
}

// MARK: - Details
struct Details: Codable {
    let megapixels, lcdScreenSize, memoryType: Name?

    enum CodingKeys: String, CodingKey {
        case megapixels
        case lcdScreenSize = "lcd_screen_size"
        case memoryType = "memory_type"
    }
}

// MARK: - Name
struct Name: Codable {
    let content: String?

    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}

// MARK: - Images
struct Images: Codable {
    let small, large: Name?
}
