//
//  CryptoViewModel.swift
//  CryptoRxMVVM
//
//  Created by Angel Iliev on 5.10.24.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    let crypto: PublishSubject<Crypto> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    /// Gets crypto currency data
    func requestData() {
        self.loading.onNext(true)
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downloadCurrencies(url: url) { result in
            self.loading.onNext(false)
            
            switch result {
            case .success(let cryptoResponse):
                self.crypto.onNext(cryptoResponse)
            case .failure(let error):
                switch error {
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
            }
        }
    }
}
