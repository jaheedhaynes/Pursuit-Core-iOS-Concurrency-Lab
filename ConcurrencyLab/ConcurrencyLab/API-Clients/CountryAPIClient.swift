//
//  CountryAPIClient.swift
//  ConcurrencyLab
//
//  Created by Jaheed Haynes on 12/9/19.
//  Copyright © 2019 Jaheed Haynes. All rights reserved.
//

import Foundation

import Foundation

struct CountryAPIClient {
    
    static func getCountries(completion: @escaping (Result<[Country], AppError>) -> ()) {
        
        let url = "https://restcountries.eu/rest/v2/name/united"
        
        NetworkHelper.shared.performDataTask(with: url) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countries))
                } catch {
                    print(error)
                }
            }
        }
    }
    
}
