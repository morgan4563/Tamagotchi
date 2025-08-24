//
//  TamagochiData.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

struct TamagochiData {
    let name: String
    let iamgeName: String
    let description: String

    init(name: String, iamgeName: String, description: String = "준비중입니다") {
        self.name = name
        self.iamgeName = iamgeName
        self.description = description
    }
}
