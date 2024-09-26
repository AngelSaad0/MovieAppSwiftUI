//
//  ContentView.swift
//  MovieApp
//
//  Created by Engy on 9/26/24.
//

import SwiftUI
import CoreData
import GoogleSignIn
import FirebaseCore
import FirebaseAuth


struct HomeScreen: View {
    @EnvironmentObject var userData: UserData
    @State private var isSignedIn = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            ZStack {
                Image(.spiderMan)
                    .resizable()
                    .ignoresSafeArea()
                VStack(spacing: 25) {
                    Spacer()
                    NavigationLink(destination: SignInScreenView()) {
                        Text("Sign In")
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 45)
                            .background(Color("#BD4925"))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                    }
                    NavigationLink(destination: SignUpScreenView()) {
                        Text("Sign Up")
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 45)
                            .background(Color("#BD4925"))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                    }
                    Button {
                        signInWithGoogle()
                    } label: {
                        HStack {
                            Image(.google)
                                .resizable()
                                .frame(width: 25, height: 25)
                            Text("Continue with Google")

                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: 45)
                    .background(Color("#2B2A2A"))
                    .foregroundColor(.white)
                    .cornerRadius(16)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 150)
                    } else {
                        Rectangle()
                            .frame(height: 150)
                            .opacity(0)

                    }

                }
                .frame(height: UIScreen.main.bounds.height*0.7)
            }
            .navigationTitle("back")
            .tint(.red)
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



struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(UserData()) // Provide a mock UserData if needed
    }
}
