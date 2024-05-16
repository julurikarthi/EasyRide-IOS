//
//  LoginView.swift
//  EasyRide-IOS
//
//  Created by karthik on 5/8/24.
//

import SwiftUI

struct LoginView: View {
    @State private var movetoselectContrycode = false
    
    let viewModel = AuthenticationModel()

    @State var selectedCountry: Country?
    @State var phoneNumber: String = ""
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to EasyRide").foregroundColor(.white).bold().font(.title3).frame(maxWidth: .infinity, alignment: .leading).background(.clear)
                
                Text("To sign up or log in, enter your number.").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
            }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))
            ZStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding([.leading, .trailing], 20)
                
                HStack {
                    ZStack {
                        HStack {
                            Text(selectedCountry?.dialCode ?? "+1" + "\(selectedCountry?.emoji ?? "")").foregroundColor(.white).font(.system(size: 10))
                            Image("downarrow").resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 15, height: 10)
                        }.frame(width: 50, height: 50).onTapGesture {
                            self.movetoselectContrycode = true
                        }
                    }.frame(maxWidth: 50, maxHeight: 50).padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
                    
                    VStack {
                        
                    }.frame(maxWidth: 1, maxHeight: 20).background(Color.gray)
                    
                    TextField("Enter Phone Number", text: $phoneNumber)
                        .background(Color.clear)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .padding([.leading, .trailing], 0)
                        .accentColor(.white).padding(.leading, 5)
                        .colorScheme(.dark)
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity,
                alignment: .top).backgroundColor(Color(hex: AppColors.backGroundColor.rawValue) ?? .black).onAppear(perform: {
            viewModel.getCountries()
        }).navigationDestination(isPresented: $movetoselectContrycode) {
            CountiresCodeView(selectedCountry: $selectedCountry, countries: viewModel.countries)
        }
    }
}

#Preview {
    LoginView()
}
