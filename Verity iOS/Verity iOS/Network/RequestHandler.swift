//
//  RequestHandler.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 24/08/23.
//

import Foundation

protocol RequestHandlerProtocol {
    func fetchUserDetails(user: String, completion: @escaping (Result<User, RequestError>) -> Void)
    func fetchUsersList(pagination: Int, completion: @escaping (Result<[User], RequestError>) -> Void)
    func fetchUserRepo(user: String, completion: @escaping (Result<[Repository], RequestError>) -> Void)
}

class RequestHandler: RequestHandlerProtocol {
    func fetchUserDetails(user: String, completion: @escaping (Result<User, RequestError>) -> Void) {
        apiCall(url: APIRoute.getUserDetails(user: user).asRequest(),
                completion: { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let items = try decoder.decode(User.self, from: data)
                    completion(.success(items))
                } catch {
                    let error = RequestError(code: 0, type: .decodingError)
                    completion(.failure(error))
                }
            case .failure(let error):
                
                completion(.failure(error))
            }
        })
    }
    
    func fetchUsersList(pagination: Int, completion: @escaping (Result<[User], RequestError>) -> Void) {
        apiCall(url: APIRoute.getUsersList(pagination: pagination).asRequest(),
                completion: { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let items = try decoder.decode([User].self, from: data)
                    completion(.success(items))
                } catch {
                    let error = RequestError(code: 0, type: .decodingError)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func fetchUserRepo(user: String, completion: @escaping (Result<[Repository], RequestError>) -> Void) {
        apiCall(url: APIRoute.getUserRepositories(user: user).asRequest(),
                completion: { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let items = try decoder.decode([Repository].self, from: data)
                    completion(.success(items))
                } catch {
                    let error = RequestError(code: 0, type: .decodingError)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    private func apiCall(url: URLRequest, completion: @escaping (Result<Data, RequestError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response:\n\(jsonString)")
                }
            }

            if let error = error {
                if let urlError = error as? URLError, urlError.code == URLError.notConnectedToInternet {
                    let requestError = RequestError(code: 0, type: .noInternet)
                    completion(.failure(requestError))
                }
                
                let requestError = RequestError(code: 0, type: .otherError(message: error.localizedDescription))
                completion(.failure(requestError))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else  {
                let requestError = RequestError(code: 0, type: .unknownError)
                completion(.failure(requestError))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let requestError = RequestError(code: httpResponse.statusCode, type:  httpResponse.statusCode == 404 ? .invalidUser : .invalidStatusCode)
                completion(.failure(requestError))
                 return
             }
            
            if let data = data {
                completion(.success(data))
                return
            }
        }.resume()
    }

}
