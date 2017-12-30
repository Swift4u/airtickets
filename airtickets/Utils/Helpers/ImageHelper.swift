//
//  ImageHelper.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

struct ImageHelper {
    
    static func imageFromColor(_ color: UIColor, forSize size: CGSize, withCornerRadius radius: CGFloat) -> UIImage {
        let rect: CGRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Begin a new image that will be the new image with the rounded corners (here with the size of an UIImageView)
        UIGraphicsBeginImageContext(size)
        
        // Add a clip before drawing anything, in the shape of an rounded rect
        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
        // Draw your image
        image.draw(in: rect)
        
        // Get the image, here setting the UIImageView image
        image = UIGraphicsGetImageFromCurrentImageContext()!
        
        // Lets forget about that we were drawing
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
