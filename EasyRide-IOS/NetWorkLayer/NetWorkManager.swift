//
//  NetWorkManager.swift
//  EasyRide-IOS
//
//  Created by karthik on 4/3/24.
//

import UIKit
import Combine

class NetWorkManager: NSObject {
        
    static let instance = NetWorkManager()
    private let session = URLSession(configuration: .default)
    func postRequest() -> AnyPublisher<Data, URLError> {
        guard let url = URL(string: "http://127.0.0.1/mac/NewEndPoint.php?action=getCarsModels") else {
            fatalError("Invalid URL")
        }
        return session.dataTaskPublisher(for: url).map { $0.data }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
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
