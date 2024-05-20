//
//  NetWorkManager.swift
//  EasyRide-IOS
//
//  Created by karthik on 4/3/24.
//

import UIKit
import Combine


class NetWorkManager {
    static let instance = NetWorkManager()
    private let session = URLSession(configuration: .default)
    
    func fetchData(with request: URLRequest) -> AnyPublisher<Data, Error> {
        return session.dataTaskPublisher(for: request)
            .mapError { $0 as Error }
            .map { $0.data }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getRequest(url: URL) -> AnyPublisher<Data, Error> {
        let request = URLRequest(url: url)
        return fetchData(with: request)
    }
    
    func postRequest(serverMethod: ServerMethods, parameters: [String: Any]) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: EndPoints.baseUrl.rawValue) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(HTTPMethod.ContentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = ["method" : serverMethod.rawValue, "data" : parameters]
        let params: [String: Any] = ["params" : requestBody]
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(HTTPMethod.ContentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return fetchData(with: request)
    }
    
    func getContries() -> AnyPublisher<Data, URLError> {
        guard let url = URL(string: EndPoints.countries.rawValue) else {
            fatalError("Invalid URL")
        }
        return session.dataTaskPublisher(for: url).map { $0.data }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
}
