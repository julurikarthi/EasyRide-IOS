//
//  CountiresCodeView.swift
//  EasyRide-IOS
//
//  Created by karthik on 5/1/24.
//

import SwiftUI

struct CountiresCodeView: View {
    @Binding var selectedCountry: Country?
    var countries: [Country]
    @State private var searchText: String = ""
    @Environment(\.presentationMode) var presentationMode
    var filteredItems: [Country] {
           if searchText.isEmpty {
               return countries
           } else {
               return countries.filter { $0.name?.localizedCaseInsensitiveContains(searchText) ?? false}
           }
       }
    var body: some View {
        NavigationView(content: {
            Form {
                Section(header: Text("Select Country Code")) {
                    TextField("Search", text: $searchText)
                                       .padding(7)
                                       .padding(.horizontal, 25)
                                       .background(Color(.systemGray6))
                                       .cornerRadius(8)
                                       .padding(.horizontal, 10)
                                       .overlay(
                                           HStack {
                                               Spacer()
                                               if !searchText.isEmpty {
                                                   Button(action: {
                                                       self.searchText = ""
                                                   }) {
                                                       Image(systemName: "xmark.circle.fill")
                                                           .foregroundColor(Color(.systemGray))
                                                           .padding(.trailing, 8)
                                                   }
                                               }
                                           }
                                       )
                                       .padding(.top, 10)
                    
                    
                    List(filteredItems, id: \.code) { country in
                        Button(action: {
                            print("Country selected = \(country)")
                            self.selectedCountry = country
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Text(country.name ?? "")
                                Spacer()
                                Text(country.emoji?.decodedUnicode ?? "")
                                if self.selectedCountry == country {
                                                           Image(systemName: "checkmark")
                                                               .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    
                }
            }
        })
    }
}

#Preview {
    CountiresCodeView(selectedCountry: .constant(Country(name: "United States", dial_code: "+1", emoji: #"\ud83c\uddfa\ud83c\uddf8"#, code: "US")), countries: [])
}

