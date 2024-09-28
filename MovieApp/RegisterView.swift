//
//  RegisterView.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//


import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseAuth



struct RegisterView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isShowPassword: Bool = false
    @State private var errorMessage: String?
    @State private var isSignedIn = false




    var body: some View {
        ZStack {
            Image(.back)
                .resizable()
                .ignoresSafeArea()
            Color.black.opacity(0.7).edgesIgnoringSafeArea(.all)
            ScrollView {
                Image(.pngegg)
                    .resizable()
                    .frame(width: 100, height: 100)
                VStack(spacing:8) {

                    VStack(spacing: 25) {
                        HStack {
                            TextField("", text: $username,prompt:
                                        Text("Username")
                                .foregroundStyle(.white.opacity(0.5)))
                            .foregroundColor(.white)
                                Image(systemName: "person")
                                    .resizable()
                                    .frame(width: 18,height: 18)
                                    .foregroundStyle(.white.opacity(0.7))
                        }
                        .padding()
                        .frame(height:50)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(5)
                        HStack {
                            TextField("", text: $username,prompt:
                                        Text("Email Adress")
                                .foregroundStyle(.white.opacity(0.5)))
                            .foregroundColor(.white)
                                Image(systemName: "person")
                                    .resizable()
                                    .frame(width: 18,height: 18)
                                    .foregroundStyle(.white.opacity(0.7))
                        }
                        .padding()
                        .frame(height:50)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(5)

                        HStack {
                            if isShowPassword {
                                TextField("", text: $password,prompt: Text("Password").foregroundStyle(.white.opacity(0.5)))
                                    .padding()
                            } else {
                                SecureField("", text: $password,prompt: Text("Password").foregroundStyle(.white.opacity(0.5)))
                                    .padding()
                            }

                            Button(action: {
                                isShowPassword.toggle()

                            }){
                                Image(systemName:isShowPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                        }
                        .frame(height:50)
                        .padding(.trailing,10)
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(5)
                        HStack {
                            if isShowPassword {
                                TextField("", text: $password,prompt: Text("Password").foregroundStyle(.white.opacity(0.5)))
                                    .padding()
                            } else {
                                SecureField("", text: $password,prompt: Text("Conform Password").foregroundStyle(.white.opacity(0.5)))
                                    .padding()
                            }

                            Button(action: {
                                isShowPassword.toggle()

                            }){
                                Image(systemName:isShowPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                        }
                        .frame(height:50)
                        .padding(.trailing,10)
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(5)

                        Button(action: {

                        }) {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()

                    Spacer()
                    HStack(spacing: 5) {
                        Button(action: {
                            signInWithGoogle()

                        }) {
                            HStack {
                                Image(.google1)
                                    .resizable()
                                    .frame(width: 25, height: 25)

                            }
                            .frame(height:6)
                            .padding()
                            .cornerRadius(8)
                        }

                        Button(action: {
                        }) {
                            HStack {
                                Image(.facebook)
                                    .resizable()
                                    .frame(width: 25, height: 25)

                            }
                            .padding()
                            .cornerRadius(8)

                        }
                    }

                    .padding(.bottom,10)

                    Spacer()

                    HStack {
                        Text("Aleardy I have an account?")
                            .foregroundColor(.white)
                        Button(action: {
                        }) {
                            Text("login.")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.bottom, 20)
                    NavigationLink(destination: MainTabBarView()) {

                        Text("Skip for now")
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .foregroundColor(.white)

                            .overlay{
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("#BD4925"),lineWidth:2)

                            }
                            .padding()

                    }
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 100)
                    } else {
                        Rectangle()
                            .frame(height: 100)
                            .opacity(0)

                    }
                }
                .padding(.top,15)
            }
        }
    }
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController) { user, error in
            if let error = error {
                errorMessage = "Google Sign-In Error: \(error.localizedDescription)"
                return
            }

            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else {
                errorMessage = "Google Authentication failed"
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    errorMessage = "Firebase sign-in failed: \(error.localizedDescription)"
                } else {
                    isSignedIn = true
                    print("Signed in with Google and Firebase!")
                }
            }
        }
    }
}




#Preview {
    RegisterView()
}

