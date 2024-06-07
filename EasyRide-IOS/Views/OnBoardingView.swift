//
//  DocumentsView.swift
//  EasyRide-IOS
//
//  Created by karthik on 5/16/24.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        VStack(content: {
            Text("To-do").frame(maxWidth: .infinity,
                                alignment: .leading).padding().foregroundColor(.white).bold()
            Image("sharerideimage")
                      .resizable()
                      .frame(maxWidth: .infinity, maxHeight: 200)
                      .padding(EdgeInsets(top: 5,
                                          leading: 0,
                                          bottom: 0, trailing: 0))
            
            HStack {
                HStack {
                    ZStack {
                        Circle().fill(Color(hex: "#FB7C73")!).frame(width: 30, height: 30)
                        Image("carimage")
                                  .resizable()
                                  .frame(maxWidth: 15, maxHeight: 15)
                    }
                    VStack(content: {
                        Text("Car details").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 13))
                        Text("We need the color, year, make and model").foregroundColor(Color(hex: "#BEBDC2")).bold().frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 0,leading: 0, bottom: 0, trailing: 0)).font(.system(size: 10))
                    })
                }.padding()
            }.frame(maxWidth: .infinity).background(Color.tileBGcolor).padding([.top, .leading, .trailing], 5).cornerRadius(10)
            
            HStack {
                HStack {
                    ZStack {
                        Circle().fill(Color(hex: "#FB7C73")!).frame(width: 30, height: 30)
                        Image("driverslicense")
                                  .resizable()
                                  .frame(maxWidth: 15, maxHeight: 15)
                    }
                    VStack(content: {
                        Text("Driver's license").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 13))
                        Text("Confirm your identity").foregroundColor(Color(hex: "#BEBDC2")).bold().frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 0,leading: 0, bottom: 0, trailing: 0)).font(.system(size: 10))
                    })
                }.padding()
            }.frame(maxWidth: .infinity).background(Color.tileBGcolor).padding([.top, .leading, .trailing], 5).cornerRadius(10)
            HStack {
                HStack {
                    ZStack {
                        Circle().fill(Color(hex: "#FB7C73")!).frame(width: 30, height: 30)
                        Image("idcard")
                                  .resizable()
                                  .frame(maxWidth: 15, maxHeight: 15)
                    }
                    VStack(content: {
                        Text("Social Document").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 13))
                        Text("We need to verify identity").foregroundColor(Color(hex: "#BEBDC2")).bold().frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 0,leading: 0, bottom: 0, trailing: 0)).font(.system(size: 10))
                    })
                }.padding()
            }.frame(maxWidth: .infinity).background(Color.tileBGcolor).padding([.top, .leading, .trailing], 5).cornerRadius(10)
            HStack {
                HStack {
                    ZStack {
                        Circle().fill(Color(hex: "#FB7C73")!).frame(width: 30, height: 30)
                        Image("user")
                                  .resizable()
                                  .frame(maxWidth: 15, maxHeight: 15)
                    }
                    VStack(content: {
                        Text("Profile Details").foregroundColor(.white).bold().frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 13))
                        Text("Make it easy for rides to find you").foregroundColor(Color(hex: "#BEBDC2")).bold().frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 0,leading: 0, bottom: 0, trailing: 0)).font(.system(size: 10))
                    })
                }.padding()
            }.frame(maxWidth: .infinity).background(Color.tileBGcolor).padding([.top, .leading, .trailing], 5).cornerRadius(10)
        }).frame(maxWidth: .infinity,
                 maxHeight: .infinity,
                 alignment: .top).backgroundColor(.backGroundColor)
    }
}

#Preview {
    OnBoardingView()
}
