//
//  Reviews.swift
//  App
//
//  Created by Narek Arsenyan on 05.11.21.
//

import SwiftUI

struct Reviews: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text(" ").font(.system(size: 5))
                Text("Leave Feedback").font(.system(size: 8))
            HStack(alignment: .center, spacing: 30) {
                Spacer()
                Image("happiness").resizable().frame(width: 40, height: 40, alignment: .center).simultaneousGesture(TapGesture().onEnded({ _ in
                    print("happy")
                }))
                Image("WTF").resizable().frame(width: 40, height: 40, alignment: .center).simultaneousGesture(TapGesture().onEnded({ _ in
                    print("WTF")
                }))
                Image("sad").resizable().frame(width: 40, height: 40, alignment: .center).simultaneousGesture(TapGesture().onEnded({ _ in
                    print("sad")
                }))
                Spacer()
            }

                Text(" ").font(.system(size: 5))
                
            }
            .background(
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                )
                    .fill(Color(red: 173/256, green: 173/256, blue: 173/256)))
        }
        .padding()
        
    }
}

struct Reviews_Previews: PreviewProvider {
    static var previews: some View {
        Reviews()
    }
}
