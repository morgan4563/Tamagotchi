//
//  TamagochiData.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

struct TamagochiData: Codable {
    var id: Int
    var name: String
    var imageName: String
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
        self.imageName = iamgeName
        self.description = description
        self.owner = owner
        self.lv = lv
        self.rice = rice
        self.water = water
    }

    var lvDescription: Int {
        let score = (Double(rice) / 5.0) + (Double(water) / 2.0)
        let rawLv = Int(score / 10.0)
        let lv = max(1, min(10, rawLv))
		return lv
    }

    var statusDescription: String {
        return "LV\(lvDescription) • 밥알 \(rice) • 물방울 \(water)"
    }

    var imageDescroption: String {
        let maxLv = min(9,lvDescription)
        return "\(id)-\(maxLv)"
    }
}
