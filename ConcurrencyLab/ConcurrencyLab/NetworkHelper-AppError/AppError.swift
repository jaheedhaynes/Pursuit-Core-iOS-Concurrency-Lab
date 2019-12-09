//
//  AppError.swift
//  ConcurrencyLab
//
//  Created by Jaheed Haynes on 12/9/19.
//  Copyright © 2019 Jaheed Haynes. All rights reserved.
//

import Foundation

enum AppError: Error {
    
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int)
    case badMimeType(String)
    
}
