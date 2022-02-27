//
//  Products.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 25/02/22.
//

struct SpotLightProduct: Decodable {
    let name: String
    let bannerURL: String
    let description: String
}

struct Product: Decodable {
    let name: String
    let imageURL: String
    let description: String
}

struct Cash: Decodable {
    let title: String
    let bannerURL: String
    let description: String
}

struct AllProducts: Decodable {
    let spotlight: [SpotLightProduct]
    let products: [Product]
    let cash: Cash
}
