//
//  MovieRequest.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/26/25.
//

struct MovieRequest: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [Movie]
}

struct Movie: Decodable {
    let rank: String
    let movieNm: String
}
