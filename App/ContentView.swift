//
//
//
//  Created by Narek Arsenyan on 27/10/2021.
//  Copyright © 2021 NMac99. All rights reserved.

import SwiftUI
import Neumorphic

struct MenuItem: Identifiable {
    var id = UUID()
    var value: String
    var task: (Any) -> Void = {_ in}
}

struct ListVW: View {
    
    private var menuItems = [MenuItem(value: "Trusted Networks"), MenuItem(value: "Privacy Policy", task: {_ in
        if let url = URL(string: "http://www.africau.edu/images/default/sample.pdf") {
            UIApplication.shared.open(url)
        }
    }), MenuItem(value: "Contact Support", task: { _ in
        print("Contact Support was clicked")
    })] 
    
    var body: some View {
        
        return List(menuItems) {menuItem in
            Text(menuItem.value).gesture(TapGesture().onEnded({ _ in
                menuItem.task(true)
            }))
        }
        .navigationTitle("Title")
        .background(Color.Neumorphic.main)
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct IntroVW: View {
    
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
                            NavigationLink(destination: IntroVWOne().navigationBarHidden(true)
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
                                
                                //                         hasFulfilled = YOUR_CONDITION_VARIABLE
                                //                         showNextView = true
                            }))
                    }.padding()
                        .background(Color(red: 173/256, green: 173/256, blue: 173/256))
                }
            }
        }
    }
}
