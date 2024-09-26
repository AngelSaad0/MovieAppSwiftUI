//
//  MoviesView.swift
//  MovieApp
//
//  Created by Mohamed Ayman on 26/09/2024.
//

import SwiftUI

struct MoviesView: View {
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
                .opacity(0.5)
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Upcoming movies")
                            .font(.title2.bold())
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("View All")
                                .font(.title3)
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(alignment: .leading) {
                            
                            LazyHStack {
                                ForEach(0..<20) { item in
                                    VStack(spacing: 10) {
                                        Image(systemName: "heart.fill")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .foregroundStyle(.green)
                                        
                                        Text("Movie Name")
                                            .font(.title2)
                                        
                                        Text("Release Date")
                                            .font(.title3)
                                        
                                        Text("Rating")
                                            .font(.title3)
                                    }
                                    .padding(30)
                                    .background(.gray.opacity(0.3))
                                    .cornerRadius(16)
                                    .padding(.horizontal, 5)
                                    
                                }
                                .listStyle(.plain)
                            }
                            .padding()
                            .frame(height: 300)
                            Spacer()
                        }
                        //            .frame(width: UIScreen.main.bounds.width)
                    }
                    
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Popular movies")
                            .font(.title2.bold())
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("View All")
                                .font(.title3)
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(alignment: .leading) {
                            
                            LazyHStack {
                                ForEach(0..<20) { item in
                                    VStack(spacing: 10) {
                                        Image(systemName: "heart")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                        
                                        Text("Movie Name")
                                            .font(.title2)
                                        
                                        Text("Release Date")
                                            .font(.title3)
                                        
                                        Text("Rating")
                                            .font(.title3)
                                    }
                                    .padding(30)
                                    .background(.gray.opacity(0.3))
                                    .cornerRadius(16)
                                    .padding(.horizontal, 5)
                                    
                                }
                                .listStyle(.plain)
                            }
                            .padding()
                            .frame(height: 300)
                            Spacer()
                        }
                        //            .frame(width: UIScreen.main.bounds.width)
                    }
                    
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("New Series")
                            .font(.title2.bold())
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("View All")
                                .font(.title3)
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(alignment: .leading) {
                            
                            LazyHStack {
                                ForEach(0..<20) { item in
                                    VStack(spacing: 10) {
                                        Image(systemName: "heart")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                        
                                        Text("Movie Name")
                                            .font(.title2)
                                        
                                        Text("Release Date")
                                            .font(.title3)
                                        
                                        Text("Rating")
                                            .font(.title3)
                                    }
                                    .padding(30)
                                    .background(.gray.opacity(0.3))
                                    .cornerRadius(16)
                                    .padding(.horizontal, 5)
                                    
                                }
                                .listStyle(.plain)
                            }
                            .padding()
                            .frame(height: 300)
                            Spacer()
                        }
                        //            .frame(width: UIScreen.main.bounds.width)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    MoviesView()
}
