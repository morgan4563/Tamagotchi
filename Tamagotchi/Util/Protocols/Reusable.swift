//
//  Reusable.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension UICollectionViewCell: Reusable {

    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {

    static var identifier: String {
        return String(describing: self)
    }
}
