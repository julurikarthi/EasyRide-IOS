//
//  LoginOrSignUpView.swift
//  EasyRide-IOS
//
//  Created by karthik on 4/3/24.
//

import SwiftUI
import Combine

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
                                
                                TextField("Enter First Name", text: $firstName)
                                    .background(Color.clear)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .padding([.leading, .trailing], 20)
                                    .accentColor(.white).padding(.leading, 20)
                                    .colorScheme(.dark)
                            }

                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .padding([.leading, .trailing], 20)
                                
                                TextField("Enter Last Name", text: $lastName)
                                    .background(Color.clear)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .padding([.leading, .trailing], 20)
                                    .accentColor(.white).padding(.leading, 20)
                                    .colorScheme(.dark)
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
                                        Text(selectedCountry?.dial_code ?? "+1" + "\(selectedCountry?.emoji ?? "")").foregroundColor(.white).font(.system(size: 10))
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
                        
                      
                        Button(action: {
                            // Action for the button
                            movetoDocumentsubmitview = true
                        }) {
                            VStack {
                                Text("Continue with Phone")
                            }
                            .frame(maxWidth: .infinity, maxHeight: 45)
                            .background(Color(hex: "#545174") ?? .gray) // Use .background instead of .backgroundColor
                            .cornerRadius(10) // Apply corner radius here
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        }
                        .accentColor(Color.white)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 2, trailing: 0))

                        Button(action: {
                            // Button action goes here
                            self.movetoLogin = true
                        }) {
                            VStack {
                                Text("LOGIN")
                                    .underline()
                                    .font(.system(size: 12)).foregroundColor(.white)
                            }.padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).onAppear(perform: {
                        viewModel.getCountries()
                    })
                }.frame(maxWidth: .infinity, maxHeight: .infinity).backgroundColor(Color(hex: AppColors.backGroundColor.rawValue) ?? .black).navigationDestination(isPresented: $movetoselectContrycode) {
                    CountiresCodeView(selectedCountry: $selectedCountry, countries: viewModel.countries)
                }.navigationDestination(isPresented: $movetoLogin) {
                    LoginView()
                }.navigationDestination(isPresented: $movetoDocumentsubmitview) {
                    DocumentsView()
                }
        }).navigationBarBackButtonHidden(true)
        
       
    }

}

#Preview {
    SignUpView()
                .previewDisplayName("Empty Fields")
}
