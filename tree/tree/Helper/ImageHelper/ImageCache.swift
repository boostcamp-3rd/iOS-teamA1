//
//  ImageCache.swift
//  tree
//
//  Created by hyeri kim on 03/02/2019.
//  Copyright © 2019 gardener. All rights reserved.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    let memoryCache = NSCache<AnyObject, AnyObject>()
    private let ioQueue = DispatchQueue(label: "diskCache")
    
    func loadImageFromMemoryCache(articleUrl: String) -> UIImage? {
        if let memoryImage = memoryCache.object(forKey: articleUrl as AnyObject) as? UIImage {
            return memoryImage
        } 
        return nil
    }
    
    func loadImageFromDisckCache(imagePath: String) -> UIImage? {
        if let imagePath = path(for: imagePath),
            let diskImage = UIImage(contentsOfFile: imagePath.path) {
                return diskImage
        } 
        return nil
    }
    
    func storeImageToMemory(image: UIImage, imageName: String) {
        memoryCache.setObject(image, 
                              forKey: imageName as AnyObject
        )
    }
    
    func path(for imageName: String) -> URL? {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        return directory?.appendingPathComponent(imageName)
    }
    
    func storeImageToDisk(image: UIImage, name: String) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        guard let imagePath = self.path(for: name) else { return }
        if !FileManager.default.fileExists(atPath: imagePath.path) {
            do {
                try imageData.write(to: imagePath)
            } catch let error as NSError {
                print("error occured \(error)")
            }   
        }
    }
    
    func storeServerImageToDisk(image: UIImage, imageName: String) {
        ioQueue.async {
            try? self.storeImageToDisk(image: image, name: imageName)
        }
    }
}
