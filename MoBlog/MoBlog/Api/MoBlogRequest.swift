//
//  MoBlogRequest.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-06-28.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation

enum MoBlogError: Error {
    case noDataAvailable
    case canNotProcessData
    case badRequest
    case unauthorized
    case serverError
    case resourceNotFound
}

struct MoBlogRequest {
    let API_KEY = "Bearer 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"
    let resourceString = "https://api.fpalmqvist.com/blog/"
    let resourceUrl: URL
    
    init(resource: String, params: String) {
        guard let resourceString = URL(string: resourceString + resource + params) else { fatalError() }
        self.resourceUrl = resourceString
    }
    
    func getData(completion: @escaping(Result<Data, MoBlogError>) -> Void) {
        var request = URLRequest(url: resourceUrl)
            
        request.allHTTPHeaderFields = [
          "Content-Type": "application/json",
          "Authorization": API_KEY
        ]
        
        performRequest(request: request, completion: completion)
    }
    
    func postData(dataToSend: Data, completion: @escaping(Result<Data, MoBlogError>) -> Void) {
        var request = URLRequest(url: resourceUrl)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
          "Content-Type": "application/json",
          "Authorization": API_KEY
        ]
       
        request.httpBody = dataToSend
        performRequest(request: request, completion: completion)
    }
    
    private func performRequest(request: URLRequest, completion: @escaping(Result<Data, MoBlogError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                fatalError()
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(self.handleBadResponse(statusCode: httpResponse.statusCode)))
                return
            }
            
            completion(.success(jsonData))
        }
        
        dataTask.resume()
    }
    
    func handleBadResponse(statusCode: Int) -> MoBlogError {
        switch statusCode {
            case 400:
                return .badRequest
            case 401:
                return .unauthorized
            case 404:
                return .resourceNotFound
        default:
            return.serverError
        }
    }
}

func parseData<T: Decodable>(_ data: Data) -> T {
    let decoder = JSONDecoder()
    
    do {
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Could not parse data to type: \(T.self)")
    }
}

func loadLocalData<T: Decodable>(_ fileName: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil)
        else {
            fatalError("Couldn't find \(fileName) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(fileName) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(fileName) as \(T.self):\n\(error)")
    }
}
