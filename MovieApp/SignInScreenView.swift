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
    @State private var confirmPassword: String = ""
    @State private var rememberLogin: Bool = false
    @State private var presentingMovies = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.spiderMan)
                    .ignoresSafeArea()
                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.top,30)
                    Spacer()
                }
                .frame(height: UIScreen.main.bounds.height)
                ZStack {
                    
                    Rectangle()
                        .fill(Material.thin)
                        .opacity(0.2)
                        .cornerRadius(16)
                    VStack(spacing: 16) {
                        MovieLogoIcon()
                            .scaleEffect(0.7)
                        // Email or mobile number field
                        TextField("",text: $emailOrPhone,prompt: Text("Email Or Mobil Number ").foregroundStyle(.gray))
                            .padding()
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .background(Color(.secondarySystemBackground).opacity(0.2))
                            .cornerRadius(10)
                        
                        // Password field
                        SecureField("",text: $password,prompt: Text("Password").foregroundStyle(.gray))
                            .padding()
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .background(Color(.secondarySystemBackground).opacity(0.2))
                            .cornerRadius(10)
                        
                        Toggle(isOn: $rememberLogin){                Text("Remember my login")
                                .foregroundStyle(.white)
                        }
                        .tint(.red)
                        Button(action: {
                            presentingMovies = true
                        }, label : {
                            Text("Sign In")
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                                .background(Color("#BD4925"))
                                .cornerRadius(10)
                                .padding(.top, 20)
                        })
                        .padding(.bottom,30)
                    }
                    .padding(.horizontal)
                }
                .frame(width: UIScreen.main.bounds.width*0.94,height: 400)
            }
        }.background(.clear)
            .fullScreenCover(isPresented: $presentingMovies) {
                MoviesView()
            }
        
    }
}

#Preview {
    SignInScreenView()
}
