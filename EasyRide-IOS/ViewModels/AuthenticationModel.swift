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
        
//        self.countries.removeAll()
//        let c1 = Country(name: "Aland Islands", dial_code: "+358", emoji: #"\ud83c\udde6\ud83c\uddfd"#, code: "AX")
//        let c2 = Country(name: "Albania", dial_code: "+355", emoji: #"\ud83c\udde6\ud83c\uddf1"#, code: "AL")
//        let c3 = Country(name: "Algeria", dial_code: "+213", emoji: #"\ud83c\udde9\ud83c\uddff"#, code: "DZ")
//        let c4 = Country(name: "AmericanSamoa", dial_code: "+1684", emoji: #"\ud83c\udde6\ud83c\uddf8"#, code: "AS")
//        let c5 = Country(name: "Andorra", dial_code: "+376", emoji: #"\ud83c\udde6\ud83c\udde9"#, code: "AD")
//        let c6 = Country(name: "Angola", dial_code: "+244", emoji: #"\ud83c\udde6\ud83c\uddf4"#, code: "AO")
//        let c7 = Country(name: "Anguilla", dial_code: "+1264", emoji: #"\ud83c\udde6\ud83c\uddee"#, code: "AI")
//        let c8 = Country(name: "Antarctica", dial_code: "+672", emoji: #"\ud83c\udde6\ud83c\uddf6"#, code: "AQ")
//        let c9 = Country(name: "Antigua and Barbuda", dial_code: "+1268", emoji: #"\ud83c\udde6\ud83c\uddec"#, code: "AG")
//        let c10 = Country(name: "India", dial_code: "+91", emoji: #"\ud83c\uddee\ud83c\uddf3"#, code: "IN")
//
//        self.countries.append(c1)
//        self.countries.append(c2)
//        self.countries.append(c3)
//        self.countries.append(c4)
//        self.countries.append(c5)
//        self.countries.append(c6)
//        self.countries.append(c7)
//        self.countries.append(c8)
//        self.countries.append(c9)
//        self.countries.append(c10)
//        localeCountry = getMyLocaleCountry()
        
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
                self.localeCountry = self.getMyLocaleCountry()
            } catch let error {
                print(error.localizedDescription)
            }
        }.store(in: &cancellables)
         
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

