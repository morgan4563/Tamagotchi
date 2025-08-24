//
//  TamagochiData.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

struct TamagochiData: Codable {
    var id: Int
    var name: String
    var iamgeName: String
    let description: String
    var owner: String
    var lv: Int
    var rice: Int
    var water: Int

    init(
        id: Int = 0,
        name: String,
        iamgeName: String,
        description: String = "준비중입니다",
        owner: String = "대장",
        lv: Int = 0,
        rice: Int = 0,
        water: Int = 0
    ) {
        self.id = id
        self.name = name
        self.iamgeName = iamgeName
        self.description = description
        self.owner = owner
        self.lv = lv
        self.rice = rice
        self.water = water
    }
}
