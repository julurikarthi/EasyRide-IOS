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
    @State private var hasAppeared: Bool = false
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
                            Text(selectedCountry?.dial_code ?? "+1" + "\(selectedCountry?.emoji ?? "")")
                                .foregroundColor(.white).font(.system(size: 10))
                                .onAppear{
                                    if !hasAppeared {
                                        viewModel.getCountries()
                                        selectedCountry = viewModel.localeCountry
                                        hasAppeared = true
                                    }
                                    if selectedCountry?.dial_code == "+91" {
                                        phoneNumber = phoneNumber.formatPhoneNumber(with: "XXXXXXXXXX")
                                    } else {
                                        phoneNumber = phoneNumber.formatPhoneNumber(with: "(XXX) XXX-XXXX")
                                    }
                                }
                            Text(selectedCountry?.emoji?.decodedUnicode ?? #"\ud83c\uddfa\ud83c\uddf8"#.decodedUnicode)
                            
                        }
                        .onTapGesture {
                            self.movetoselectContrycode = true
                        }
                    }.frame(maxWidth: 80, maxHeight: 50).padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
                    
                    
                    VStack {
                        //Vertical line
                    }.frame(maxWidth: 1, maxHeight: 20).background(Color.gray)
                    
                    TextField("Enter Phone Number*", text: $phoneNumber)
                        .background(Color.clear)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .padding([.leading, .trailing], 0)
                        .accentColor(.white).padding(.leading, 5)
                        .colorScheme(.dark)
                        .keyboardType(.numberPad)
                        .onChange(of: phoneNumber) {
                            if selectedCountry?.dial_code == "+91" {
                                phoneNumber = phoneNumber.formatPhoneNumber(with: "XXXXXXXXXX")
                            } else {
                                phoneNumber = phoneNumber.formatPhoneNumber(with: "(XXX) XXX-XXXX")
                            }
                            
                        }
                }
                
            }
            loginBtn
        }.frame(maxWidth: .infinity, maxHeight: .infinity,
                alignment: .top).backgroundColor(Color(hex: AppColors.backGroundColor.rawValue) ?? .black).onAppear(perform: {
           
        }).navigationDestination(isPresented: $movetoselectContrycode) {
            CountiresCodeView(selectedCountry: $selectedCountry, countries: viewModel.countries)
        }.task {
            viewModel.getCountries()
        }
    }
    
    /// Login Action
    var loginBtn: some View {
        Button(action: {
            let phoneNumer = (selectedCountry?.dial_code ?? "") + phoneNumber
            viewModel.loginUser(phoneNumber: phoneNumer)
        }) {
            Text("Login").foregroundColor(.white)
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)).task {
            
        }
    }
}

#Preview {
    LoginView()
}
