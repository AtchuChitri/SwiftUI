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

struct MockWebService: WebServiceContract {
    func processWebService<T: Codable>(request: WebServiceRequest, as type: T.Type) async throws -> T {
        let json = """
        {"dates":{"maximum":"2023-07-18","minimum":"2023-05-31"},"page":1,"results":[{"adult":false,"backdrop_path":"/woJbg7ZqidhpvqFGGMRhWQNoxwa.jpg","genre_ids":[28,12,878],"id":667538,"original_language":"en","original_title":"Transformers: Rise of the Beasts","overview":"When a new threat capable of destroying the entire planet emerges, Optimus Prime and the Autobots must team up with a powerful faction known as the Maximals. With the fate of humanity hanging in the balance, humans Noah and Elena will do whatever it takes to help the Transformers as they engage in the ultimate battle to save Earth.","popularity":2759.747,"poster_path":"/gPbM0MK8CP8A174rmUwGsADNYKD.jpg","release_date":"2023-06-06","title":"Transformers: Rise of the Beasts","video":false,"vote_average":7.3,"vote_count":719},{"adult":false,"backdrop_path":"/oqP1qEZccq5AD9TVTIaO6IGUj7o.jpg","genre_ids":[14,28,12],"id":455476,"original_language":"en","original_title":"Knights of the Zodiac","overview":"When a headstrong street orphan, Seiya, in search of his abducted sister unwittingly taps into hidden powers, he discovers he might be the only person alive who can protect a reincarnated goddess, sent to watch over humanity. Can he let his past go and embrace his destiny to become a Knight of the Zodiac?","popularity":2233.242,"poster_path":"/tBiUXvCqz34GDeuY7jK14QQdtat.jpg","release_date":"2023-04-27","title":"Knights of the Zodiac","video":false,"vote_average":6.5,"vote_count":423}]}
        """
        let jsonData = Data(json.utf8)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: jsonData)

    }
}




   
