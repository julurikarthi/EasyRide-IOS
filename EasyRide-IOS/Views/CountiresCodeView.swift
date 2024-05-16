//
//  CountiresCodeView.swift
//  EasyRide-IOS
//
//  Created by karthik on 5/1/24.
//

import SwiftUI

struct CountiresCodeView: View {
    @Binding var selectedCountry: Country?
    var countries: [Country]?
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView(content: {
            Form {
                Section(header: Text("Select Country Code")) {
                    ForEach(countries ?? [], id: \.code) { country in
                        Button(action: {
                            self.selectedCountry = country
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Text(country.name ?? "")
                                Spacer()
                                Text(country.emoji ?? "")
                            }
                        }
                    }
                }
            }
        })
    }
}
