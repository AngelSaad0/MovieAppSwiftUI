//
//  ContentView.swift
//  MovieApp
//
//  Created by Engy on 9/26/24.
//

import SwiftUI
import CoreData

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image(.spiderMan)
                    .edgesIgnoringSafeArea(.all)


                VStack(spacing:30){
                    Spacer()
                    Button{
                        print("Sing In")
                    }label: {
                        Text ("Sing In")
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width*0.8,height: 45)
                            .background(Color("#BD4925"))
                            .cornerRadius(16)
                    }
                    Button{
                        print("Sing In")
                    }label: {
                        HStack(spacing:10) {
                            Image(.google).resizable().frame(width: 25,height: 25)
                            Text ("Continue with Google")
                        }
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width*0.8,height: 45)
                            .background(Color("#2B2A2A"))
                            .cornerRadius(16)
                    }
                }.frame(height: UIScreen.main.bounds.height)
                .padding(.bottom, 200)
            }

        }

    }

}
struct CustomButton: View {
    var title: String
    var action: ()->Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 35)
                .background(Color.orange)
                .cornerRadius(16)
        }
    }
}





#Preview {

    HomeScreen()
}
