//
//  Crypto.swift
//  CryptoRxMVVM
//
//  Created by Angel Iliev on 5.10.24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let crypto = try? JSONDecoder().decode(Crypto.self, from: jsonData)

import Foundation

// MARK: - CryptoElement
struct CryptoElement: Codable {
    let currency, price: String
}

typealias Crypto = [CryptoElement]
