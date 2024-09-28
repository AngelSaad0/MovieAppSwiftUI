//
//  SignUpScreenView.swift
//  MovieApp
//
//  Created by Engy on 9/26/24.
//

import SwiftUI

struct SignUpScreenView: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var emailOrPhone = ""
    @State private var password = ""
    @State private var rePassword = ""
    @State private var confirmPassword: String = ""
    @State private var rememberLogin: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.spiderMan)
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

                ScrollView {

                        ZStack {
                            
                            Rectangle()
                                .fill(Material.thin)
                                .opacity(0.2)
                                .cornerRadius(16)
                            VStack(spacing: 16) {
                                    Text("Sign Up")
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundStyle(.white)
                                        .padding(.top,30)

                                MovieLogoIcon()
                                    .scaleEffect(0.7)

                                // Email or mobile number field
                                TextField("",text: $firstName,prompt: Text("First Name").foregroundStyle(.gray))
                                    .padding()
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                                    .background(Color(.secondarySystemBackground).opacity(0.2))
                                    .cornerRadius(10)
                                
                                // Email or mobile number field
                                TextField("",text: $lastName,prompt: Text("Last Name").foregroundStyle(.gray))
                                    .padding()
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                                    .background(Color(.secondarySystemBackground).opacity(0.2))
                                    .cornerRadius(10)
                                
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
                                
                                SecureField("",text: $rePassword,prompt: Text("Re-enter Password").foregroundStyle(.gray))
                                    .padding()
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                                    .background(Color(.secondarySystemBackground).opacity(0.2))
                                    .cornerRadius(10)
                                
                                Toggle(isOn: $rememberLogin){                Text("I accept terms and conditions")
                                        .foregroundStyle(.white)
                                }
                                .tint(.red)
                                
                                Button(action: {
                                    
                                }, label : {
                                    Text("Sign up")
                                        .foregroundColor(.white)
                                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                                        .background(Color.red)
                                        .cornerRadius(10)
                                        .padding(.top, 20)
                                })
                                .padding(.bottom,30)
                            }
                            .padding(.horizontal)
                        }
                        .frame(width: UIScreen.main.bounds.width*0.94/*,height: UIScreen.main.bounds.height*/)
                        .padding(.top,50)
                        .padding(.bottom,100)

                }
            }

        }
    }
}

#Preview {
    SignUpScreenView()
}
