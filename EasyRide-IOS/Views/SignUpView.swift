//
//  LoginOrSignUpView.swift
//  EasyRide-IOS
//
//  Created by karthik on 4/3/24.
//

import SwiftUI
import Combine
import Foundation

struct SignUpView: View {
    @State private var movetoselectContrycode = false
    @State private var movetoLogin = false
    @State private var movetoDocumentsubmitview = false

    @EnvironmentObject var appstate: AppState
    let viewModel = AuthenticationModel()

    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var phoneNumber: String = ""
    @State var selectedCountry: Country?
    @State private var hasAppeared: Bool = false

    var body: some View {
        NavigationView(content: {
                VStack {
                    VStack {
                        VStack {
                            Text("Welcome to EasyRide").foregroundColor(.white).bold().font(.title3).frame(maxWidth: .infinity, alignment: .leading).background(.clear)
                            
                            Text("To sign up or log in, enter your number.").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))
                        
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .padding([.leading, .trailing], 20)
                                
                                TextField("Enter First Name*", text: $firstName)
                                    .background(Color.clear)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .padding([.leading, .trailing], 20)
                                    .accentColor(.white).padding(.leading, 20)
                                    .colorScheme(.dark)
                                    .onChange(of: firstName) {
                                        let newText = firstName.filter{ character  in
                                            character.isLetter || character == " " || character.isWhitespace
                                        }
                                        if newText != firstName {
                                            firstName = newText
                                        }
                                    }
                            }

                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .padding([.leading, .trailing], 20)
                                
                                TextField("Enter Last Name*", text: $lastName)
                                    .background(Color.clear)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .padding([.leading, .trailing], 20)
                                    .accentColor(.white).padding(.leading, 20)
                                    .colorScheme(.dark)
                                    .onChange(of: lastName) {
                                        let newText = lastName.filter{ character  in
                                            character.isLetter || character == " " || character.isWhitespace
                                        }
                                        if newText != lastName {
                                            lastName = newText
                                        }
                                    }
                            }
                        }
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
                        
                      
                        Button(action: {
                            // Action for the button
                            movetoDocumentsubmitview = allFieldsFilled()
                        }) {
                            VStack {
                                Text("Continue with Phone")
                            }
                            .disabled(allFieldsFilled() == true ? false : true)
                            .frame(maxWidth: .infinity, maxHeight: 45)
                            .background(Color(hex: allFieldsFilled() == true ? "#545174" : "#5a5a5e" )) //
                            .cornerRadius(10) // Apply corner radius here
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        }
                        .accentColor(Color.white)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 2, trailing: 0))

                        Button(action: {
                            // Button action goes here
                            movetoLogin = true
                        }) {
                            VStack {
                                Text("LOGIN")
                                    .underline()
                                    .font(.system(size: 12)).foregroundColor(.white)
                            }.padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }.frame(maxWidth: .infinity, maxHeight: .infinity).backgroundColor(Color(hex: AppColors.backGroundColor.rawValue) ?? .black).navigationDestination(isPresented: $movetoselectContrycode) {
                    CountiresCodeView(selectedCountry: $selectedCountry, countries: viewModel.countries)
                }.navigationDestination(isPresented: $movetoLogin) {
                    LoginView()
                }.navigationDestination(isPresented: $movetoDocumentsubmitview) {
                    OnBoardingView()
                }
        }).navigationBarBackButtonHidden(true)
    }
    
    func allFieldsFilled() -> Bool {
        if selectedCountry?.code == "IN" {
            if firstName.count > 0 && lastName.count > 0 && phoneNumber.isValidIndiaPhoneNumber() {
                return true
            }
        } else {
            if firstName.count > 0 && lastName.count > 0 && phoneNumber.isValidPhoneNumber() {
                return true
            }
        }
        return false
    }
    
//    func getMyLocaleCountry() -> Country {
//        let regionCode = Locale.current.region?.identifier
//        print("my current region \(regionCode ?? "US")") // "US"
//        let myCountry = viewModel.countries.first(where: { info in
//                info.code == regionCode
//            })
//        print("my current region \(myCountry?.code ?? "US")")
//        //{"name":"India","dial_code":"+91","emoji":"\ud83c\uddee\ud83c\uddf3","code":"IN"},
//        //{"name":"United States","dial_code":"+1","emoji":"\ud83c\uddfa\ud83c\uddf8","code":"US"},
//        return myCountry ?? Country(name: "United States", dial_code: "+1", emoji: #"\ud83c\uddfa\ud83c\uddf8"#, code: "US")
//    }

}

#Preview {
    SignUpView()
                .previewDisplayName("Empty Fields")
}

