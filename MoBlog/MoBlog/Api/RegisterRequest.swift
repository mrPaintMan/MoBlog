//
//  RegisterRequest.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-09-22.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation

fileprivate struct RegisterResponse: Decodable {
    let status: String
}

fileprivate struct RegisterMessage: Encodable {
    let device_token: String
    let source_codes: [String]
    
    init(deviceToken: String, sourceCodes: [String]) {
        self.device_token = deviceToken
        self.source_codes = sourceCodes
    }
}

class RegisterRequest {
    let resource: String
    fileprivate var response: RegisterResponse?
    
    init(_ deviceToken: String, _ sourceCodes: [String]) {
        resource = "register"
        let message = RegisterMessage(deviceToken: deviceToken, sourceCodes: sourceCodes)
        var data = Data()
        let params = ""
        let moBlogResuest = MoBlogRequest(resource: self.resource, params: params)
        
        do {
            data = try JSONEncoder().encode(message)
        } catch {
            fatalError("Failed to either post data to register endpoint, or to encode json message")
        }
        
        moBlogResuest.postData(dataToSend: data) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let data):
                self?.response = parseData(data)
            }
        }
    }
}


