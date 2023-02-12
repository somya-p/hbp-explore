//
//  LandingView.swift
//  iris-somya-hbp
//
//  Created by Somya Prabhakar on 2/11/23.
//

import SwiftUI

struct LandingView: View {
    @State var name: String = "";
    
    @State var options = ["native", "student", "commuter", "tourist"]
    @State var userType = "tourist"
    
    var body: some View {
        VStack {
            Spacer()
            TextField("name", text: $name)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .foregroundColor(Color.white)
                .cornerRadius(12)
                .frame(width: 300, height: 30, alignment: .center)
                .shadow(radius: 2)
            Picker("What kind of user are you?", selection: $userType) {
                ForEach(options, id: \.self) { item in
                    TextView(text: item)
                }
                
            }
            Spacer()
            
            
        }
    }
}

struct TextView: View {
    var text: String
    var body: some View {
        Text(text).bold()
            .font(.body)
            .foregroundColor(.blue)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
