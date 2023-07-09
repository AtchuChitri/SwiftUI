//
//  WebService.swift
//  SwiftHub
//
//  Created by Atchibabu Chitri on 18/6/23.
//

import Foundation

struct WebService: WebServiceContract {
        
    init () {
    }
     func processWebService<T: Codable>(request: WebServiceRequest, as type: T.Type) async throws -> T {
         guard let urlStr = request.getURLRequest(), let url = URL(string: urlStr)  else { throw WebServiceError.invalidRequest}
         var urlRequest = URLRequest(url: url)
         urlRequest.httpMethod = request.method.rawValue
         let (data, response) = try await URLSession.shared.data(for: urlRequest)
         print(response)
         guard (response as? HTTPURLResponse)?.statusCode == 200 else {
             throw WebServiceError.invalidResponse(data)
            }
         let decoder = JSONDecoder()
         return try decoder.decode(T.self, from: data)
    }

   
}

protocol WebServiceContract {
    func processWebService<T: Codable>(request: WebServiceRequest, as type: T.Type) async throws -> T

}
