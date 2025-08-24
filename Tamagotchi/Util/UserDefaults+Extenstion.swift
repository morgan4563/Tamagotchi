//
//  UserDefaults+Extenstion.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/25/25.
//

import Foundation

extension UserDefaults {
    func saveTamagochi(_ data: TamagochiData) {
        if let encodedData = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encodedData, forKey: "tamagochiData")
        }
    }

    func loadTamagochi() -> TamagochiData? {
        guard let savedData = UserDefaults.standard.data(forKey: "tamagochiData"),
              let decoded = try? JSONDecoder().decode(TamagochiData.self, from: savedData)
        else {
            return nil
        }
        return decoded
    }

    func removeTamagochi() {
        UserDefaults.standard.removeObject(forKey: "tamagochiData")
    }
}
