//
//  RequestError.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 24/08/23.
//

import Foundation

struct RequestError: Error {
    let code: Int
    let type: RequestErrorType

    init(code: Int = 0, type: RequestErrorType) {
        self.code = code
        self.type = type
    }
    
    func asMessage() -> String {
        switch type {
        case .unknownError,
                .otherError(_):
            return "Oops! Something went wrong. Please try again later."
        case .invalidStatusCode:
            return "Oops! We're having trouble communicating with our servers. Please try again later."
        case .decodingError:
            return "Oops! We're having trouble processing the data we received. Please try again later."
        case .invalidUser:
            return "Oops! It looks like this user does not exist. Please check the username and try again."
        case .noInternet:
            return "Oops! It looks like you don't have an internet connection. Please connect to the internet and try again."
        }
    }
}

enum RequestErrorType: Equatable {
    case unknownError
    case invalidStatusCode
    case decodingError
    case invalidUser
    case noInternet
    case otherError(message: String)
}
