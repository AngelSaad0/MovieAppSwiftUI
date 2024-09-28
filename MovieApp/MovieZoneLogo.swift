//
//  MovieZoneLogo.swift
//  MovieApp
//
//  Created by Engy on 9/27/24.
//
import SwiftUI

struct MovieZoneLogo: View {
    var body: some View {
            VStack {
                MovieLogoIcon()
                VStack(spacing:-10){
                    HStack {
                        Text("Movie")
                        Text("Zone")
                    }
                    .padding(.top, 15)
                    Text("app")
                }
                .font(.custom("IBMPlexMono-Bold", size: 30))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)

            }

            .padding()
            .background(.black.opacity(0.4))
            .cornerRadius(15)
            .shadow(color:.white.opacity(0.5),radius: 10)
        }
    }

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct MovieLogoIcon: View {
    var body: some View {

        ZStack {
            Circle()
                .fill(Color("#3498db"))
                .frame(width: 120, height: 120)

            Circle()
                .fill(Color("#2C3E50"))
                .frame(width: 100, height: 100)

            Triangle()
                .fill(Color("#BD4925"))
                .frame(width: 40, height: 40)
                .rotationEffect(.degrees(90))
                .offset(x:5)
        }
    }
}
struct MovieZoneLogoView: View {
    var body: some View {
        ZStack {
            Image(.spiderMan)
                .resizable()
                .ignoresSafeArea()
            MovieZoneLogo()

        }
        
    }
}




#Preview {
    MovieZoneLogoView()
}
