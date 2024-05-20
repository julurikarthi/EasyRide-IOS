//
//  AuthenticationModel.swift
//  EasyRide-IOS
//
//  Created by karthik on 4/3/24.
//

import UIKit
import Combine

@Observable class AuthenticationModel: ObservableObject {
    var datavalues: [String: Any]?
    var cancellables = Set<AnyCancellable>()
    var countries = [Country]()
    func loginUser(phoneNumber: String) {
        NetWorkManager.instance.postRequest(serverMethod: .singintapido,
                                                          parameters: ["phoneNumber": phoneNumber]).sink { error in
            print(error)
        } receiveValue: { data in
            do {
                if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(dictionary)
                    self.datavalues = dictionary
                }
            } catch _ {
                
            }
        }.store(in: &cancellables)
    }
    
    func getCountries() {
        NetWorkManager.instance.getContries().sink { error in
            switch error {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                print("fined")
            }
        } receiveValue: { data in
            do {
                let decoder = JSONDecoder()
                self.countries = try decoder.decode([Country].self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
        }.store(in: &cancellables)
    }

}


struct Country: Decodable {
    let name: String?
    let dial_code: String?
    let emoji: String?
    let code: String?
}
