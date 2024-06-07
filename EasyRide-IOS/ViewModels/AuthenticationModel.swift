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
    var localeCountry: Country?
    
    func loginUser(phoneNumber: inout String) {
        let charactersToRemove: Set<Character> = ["(", ")", " ", "-"]
        phoneNumber = String(phoneNumber.filter { !charactersToRemove.contains($0) })
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
    
    func getCountries() async {
        do {
            let data = try await NetWorkManager.instance.getContries()
            let decoder = JSONDecoder()
            DispatchQueue.main.async {
                do {
                    self.countries = try decoder.decode([Country].self, from: data)
                    self.localeCountry = self.getMyLocaleCountry()
                } catch {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getMyLocaleCountry() -> Country {
        let regionCode = Locale.current.region?.identifier
        print("my current region \(regionCode ?? "US")") // "US"
        let myCountry = self.countries.first(where: { info in
            info.code == regionCode
        })
        print("my current region \(myCountry?.code ?? "US")")
        return myCountry ?? Country(name: "United States", dial_code: "+1", emoji: #"\ud83c\uddfa\ud83c\uddf8"#, code: "US")
    }

}


class Country: Codable, Equatable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        return  lhs.name == rhs.name
    }
    
    var name: String?
    var dial_code: String?
    var emoji: String?
    var code: String?
    
    init(name: String?, dial_code: String?, emoji: String?, code: String?) {
        self.name = name
        self.dial_code = dial_code
        self.emoji = emoji
        self.code = code
    }
}

