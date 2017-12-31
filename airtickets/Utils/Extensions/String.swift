//
//  String.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 31/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

extension String {
    
    func firstName() -> String {
        let parts = self.components(separatedBy: " ")
        return parts.first ?? self
    }
    
}
