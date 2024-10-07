//
//  Webservice.swift
//  CryptoRxMVVM
//
//  Created by Angel Iliev on 5.10.24.
//

import Foundation

enum CryptoError: Error {
    case serverError
    case parsingError
}

class Webservice {
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<Crypto, CryptoError>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(CryptoError.serverError))
            } else if let data = data {
                let crypto = try? JSONDecoder().decode(Crypto.self, from: data)
                
                if let crypto = crypto {
                    completion(.success(crypto))
                } else {
                    completion(.failure(CryptoError.parsingError))
                }
                
            }
        }.resume()
    }
}
