//
//  RegisterRequest.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-09-22.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation

struct RegisterResponse: Decodable {
    let status: String
}

struct RegisterMessage: Encodable {
    let device_token: Data
    let source_codes: [String]
    
    init(deviceToken: Data, sourceCodes: [String]) {
        self.device_token = deviceToken
        self.source_codes = sourceCodes
    }
}

class RegisterRequest {
    let resource: String
    var response: RegisterResponse?
    
    init(_ deviceToken: Data, _ sourceCodes: [String]) {
        resource = "register"
        var data = Data()
        
        let message = RegisterMessage(deviceToken: deviceToken, sourceCodes: sourceCodes)
        
        do {
            data = try JSONEncoder().encode(message)
        } catch {
            fatalError("Failed to either post data to register endpoint, or to encode json message")
        }
        
        let params = ""
        let moBlogResuest = MoBlogRequest(resource: self.resource, params: params)
        
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


