//
//  CameraDetailCell.swift
//  CamerasWithFlickrAPI
//
//  Created by Stepan Vasilyeu on 3/9/20.
//  Copyright © 2020 Stepan Vasilyeu. All rights reserved.
//

import UIKit

class CameraDetailCell: UITableViewCell {
    
    static let reuseId = "CameraDetailCell"
    
    @IBOutlet weak var cameraDetailTitleLabel: UILabel!
    @IBOutlet weak var megapixelsDetailTitleLabel: UILabel!
    @IBOutlet weak var screenSizeDetailTitleLabel: UILabel!
    @IBOutlet weak var memoryTypeDetailTitleLabel: UILabel!
    @IBOutlet weak var cameraDetailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCamera(camera: Camera) {
        cameraDetailTitleLabel.text = camera.name?.content ?? "Unknown"
        megapixelsDetailTitleLabel.text = camera.details?.megapixels?.content ?? "Unknown"
        screenSizeDetailTitleLabel.text = camera.details?.lcdScreenSize?.content ?? "Unknown"
        memoryTypeDetailTitleLabel.text = camera.details?.memoryType?.content ?? "Unknown"
        cameraDetailImageView.setImage(imageURL: camera.images?.large?.content)
    }
}
