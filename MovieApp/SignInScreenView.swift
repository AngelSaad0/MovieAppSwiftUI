//
//  SignInScreenView.swift
//  MovieApp
//
//  Created by Engy on 9/26/24.
//

import SwiftUI

struct SignInScreenView: View {
    
    @State private var emailOrPhone = ""
    @State private var password = ""
    @State private var rememberMe = false
    var body: some View {
        NavigationView {
            ZStack {
                Image(.spiderMan)
                    .ignoresSafeArea()

                ZStack {
                    Rectangle()
                        .fill(Material.thin)
                        .opacity(0.2)
                    VStack(spacing: 16) {
                        Text("Sign In")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.top,100)
                        // Email or mobile number field
                        TextField("Email Or Mobil Number ",text: $emailOrPhone)
                            //.textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(height: 50)
                            .background(.white.opacity(0.1))
                            .foregroundColor(.white)
                            .cornerRadius(8)





                        // Password field
                        SecureField("Email Or Mobil Number ",text: $password){

                        }


                    }
                    .padding(.horizontal)

                }
                .frame(width: UIScreen.main.bounds.width*0.94,height: 400)


            }.background(.clear)

        }
    }
}

#Preview {
    SignInScreenView()
}
