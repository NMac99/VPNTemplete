//
//  NavigationVW.swift
//  App
//
//  Created by Narek Arsenyan on 17.10.21.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var showModalOne = false
    @Published var showModalTwo = false
    var cancellableOne: AnyCancellable?
    var cancellableTwo: AnyCancellable?
    
    init() {
        self.cancellableOne = NotificationCenter.default.publisher(for: .notificationOne, object: nil)
            .sink { _ in
                self.showModalOne.toggle()
            }
        self.cancellableTwo = NotificationCenter.default.publisher(for: .notificationTwo, object: nil)
            .sink { _ in
                self.showModalTwo.toggle()
            }
        print(ScreenSize.screenHeight)
    }
    
    deinit {
        self.cancellableOne?.cancel()
        self.cancellableTwo?.cancel()
    }
}

struct NavigationVW: View {
    @State var isConnected: Bool = false
    @State var isTap = false
    @State var buttonPressed = false
    @ObservedObject var model = MainViewModel()
    @State var isAnimating = false
    private let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)

    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(Color.Neumorphic.main)
        UINavigationBar.appearance().tintColor = .black
    }
    
    
    var body: some View {
        let mainColor = Color.Neumorphic.main
        
        return NavigationView {
            
            ZStack {
                
                if ScreenSize.screenHeight > 600 {
                    Reviews().padding(.bottom, 20)
                } else {
                    Reviews().padding(.bottom, -10)
                }
                VStack(alignment: .center, spacing: 20) {
                    VStack(spacing: 20) {
                        Text(isConnected ? "Connect" : "Disconnect").font(.system(size: 45, weight: .heavy)).foregroundColor(isConnected ? Color(red: 128/256, green: 186/256, blue: 210/256) : .red)
                        VStack() {
                            Text("Your current IP").font(.system(size: 16)).foregroundColor(Color.gray)
                            Text("192.168.0.1").font(.system(size: 28)).foregroundColor(Color.black)
                        }
                    }
                    ZStack {
                        Circle().fill(mainColor).softOuterShadow()
                        
                        Circle().fill(mainColor).frame(width: 170, height: 170)
                            .softInnerShadow(Circle())
                        
                        
                        if !buttonPressed {
                            Circle().fill(mainColor).frame(width: 80, height: 80)
                                .softOuterShadow(lightShadow: Color.Neumorphic.darkShadow, radius: 10)
                        }
                        Image(isConnected ? "on" : "off").resizable().frame(width: 40, height: 40, alignment: .center)
                    }.frame(width: 200, height: 200).modifier(TouchDownUpEventModifier(changeState: { (buttonState) in
                        if buttonState == .pressed {
                            buttonPressed = true
                        } else {
                            buttonPressed = false
                            isConnected.toggle()
                            
                            // THIS PART IS FOR TESTING AND SHOWING TO YOU
                            if(isConnected) {
                                NotificationCenter.default.post(name: .notificationOne, object: nil)
                            } else {
                                NotificationCenter.default.post(name: .notificationTwo, object: nil)
                            }
                        }
                    }))
                    ZStack {
                            VStack{
                                Image("up").resizable().frame(width: 20, height: 20, alignment: .center).scaleEffect(self.isAnimating ? 1 : 1.5).onAppear {
                                    withAnimation(self.animation, {
                                        self.isAnimating.toggle()
                                    })
                                }

                                Text(" ").font(.system(size: 5))
                                if isConnected {
                                Text("Tap to Disconnect").font(.system(size: 10))
                                } else {
                                    Text("Tap to Connect").font(.system(size: 10))
                                }
                                Text(" ").font(.system(size: 22))
                            }
                        
                        
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: HStack(alignment: .top) {
                Button(action: {
                    isTap = true
                }) {
                    NavigationLink(destination: ListVW()) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow(offset: 5, radius: 6).frame(width: 40, height: 40, alignment: .center)
                            
                            Image("burger").resizable().frame(width: 30, height: 30, alignment: .center)
                        }
                    } 
                }
            }).frame(maxWidth: .infinity, maxHeight: .infinity)
                .accentColor(Color.white)
                .background(Color.Neumorphic.main)
                .edgesIgnoringSafeArea(.all)
        }.sheet(isPresented: self.$model.showModalOne) {
            ModalOne()
        }.sheet(isPresented: self.$model.showModalTwo) {
            ModalTwo()
        }
        
    }
}

struct NavigationVW_Previews: PreviewProvider {
    static var previews: some View {
        NavigationVW()
    }
}
