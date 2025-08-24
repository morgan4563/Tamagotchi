//
//  ViewDesignProtocol.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/23/25.
//

import Foundation

protocol ViewDesignProtocol: AnyObject {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}
