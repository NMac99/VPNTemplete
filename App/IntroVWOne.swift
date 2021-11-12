//
//  IntroVWOne.swift
//  App
//
//  Created by Narek Arsenyan on 28.10.21.
//

import SwiftUI

struct IntroVWOne: View {
    var body: some View {
        return NavigationView {
            ZStack() {
                Color.Neumorphic.main
                    .ignoresSafeArea()
                VStack() {
                    VStack(alignment: .leading) {
                        Spacer()
                        Image("apple")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        Text("Lorem ipsum dolor sit amet, consectetur\n")
                            .bold().font(.system(size: 24))
                        Text("""
                               Lorem ipsum dolor sit amet,nLorem ipsum dolor sit amet, consectetur adipiscing elit. In sed consectetur elit. Suspendisse et malesuada nunc. Donec a fermentum dui, sit amet maximus purus.
                               """).foregroundColor(Color.gray).font(.system(size: 18))
                        Spacer()
                    }.padding()
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            NavigationLink(destination: NavigationVW().navigationBarHidden(true)
                                            .navigationBarTitle("")) {
                                Text("Next")
                                    .fontWeight(.bold)
                                    .navigationBarHidden(true)
                                    .navigationBarTitle("")
                            }
                        }.keyboardShortcut(.defaultAction)
                            .simultaneousGesture(TapGesture().onEnded({ _ in
                                let defaults = UserDefaults.standard
                                defaults.set("true", forKey: defaultsKeys.keyAgreement)
                            }))
                    }.padding()
                        .background(Color(red: 173/256, green: 173/256, blue: 173/256))
                }
            }
        }.navigationBarHidden(false)
    }
}

struct IntroVWOne_Previews: PreviewProvider {
    static var previews: some View {
        IntroVWOne()
    }
}



