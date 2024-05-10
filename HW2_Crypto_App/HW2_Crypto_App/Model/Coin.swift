//
//  Coin.swift
//  HW2_Crypto_App
//
//  Created by Zeynep Nur Altın on 1.05.2024.
//

import Foundation

struct NewAPI: Decodable {
    let status : String?
    let data : Data?
}

struct Data : Decodable {
    let coins : [Coins]?
}

struct Coins : Decodable {
    
    let volume24h : String?
    let btcPrice : String?
    let change : String?
    let iconUrl : String?
    let listedAt : Int?
    let marketCap: String?
    let price: String?
    let symbol: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        
        case volume24h = "24hVolume"
        case btcPrice
        case change
        case iconUrl
        case listedAt
        case marketCap
        case price
        case symbol
        case name
    }
}
