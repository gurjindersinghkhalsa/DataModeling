//
//  APIService.swift
//  DataModelingUsingStruct
//
//  Created by Gurjinder Singh on 03/06/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
}


class APIService {
    static let sharedInstance = APIService()
    
    let sourceURL = "https://breakingbadapi.com/api/episodes"
    func callService(completionHandler: @escaping (Result<[EpisodeModel], NetworkError>)->Void) {
        var urlReq = URLRequest.init(url: URL(string: sourceURL)!)
        urlReq.httpMethod = "Get"
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: urlReq) { (data, response, error) in
            guard  error == nil else {
                   completionHandler(.failure(.badURL))
                   return
               }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
              return
            }
            if let data = data,
               let episodeModel = try? JSONDecoder().decode([EpisodeModel].self, from: data) {
                completionHandler(.success(episodeModel))
            }
        }.resume()
    }
}
