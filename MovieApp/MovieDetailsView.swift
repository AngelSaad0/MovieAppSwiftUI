//
//  MovieDetailsView.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//

import SwiftUI
import AVKit
import WebKit

struct MovieDetailsView: View {
    let networkManager = NetworkManager()
    @State private var movieName:String?
    @State private var movieDescription:String?
    @State private var movieTagline:String?
    @State private var videoID: String?

    let movieID:Int
    let isMovie:Bool
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {

                    WebView(url: URL(string: "https://www.youtube.com/embed/\(videoID ?? "")")!)
                        .frame(height: 350)
                        .background(Color.black)

                }
                VStack(spacing:25){
                    Spacer()
                    Text(movieName ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Text(movieTagline ?? "")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Text(movieDescription ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    Spacer()
                }
                Button(action: downloadVideo) {
                    Text("Download")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            .onAppear {
                fetchMovies()
                fetchMoviesVeido()

            }
            .navigationTitle("Movie Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func fetchMovies() {
        networkManager.fetchData(from:.details(id: movieID), responseType: MovieDetails.self) { movies in
            movieName = movies?.title ?? ""
            movieDescription = movies?.overview ?? ""
            movieTagline = movies?.tagline ?? ""

        }

    }
    private func fetchMoviesVeido() {
        let api:MovieApi = isMovie ? .moviePlayVideos(id: movieID): .moviePlayTV(id: movieID)
        networkManager.fetchData(from:api, responseType: MovieVideoModel.self) { movies in
            videoID = movies?.results.first?.key
        }

    }
}
struct WebView: UIViewRepresentable {
    let url: URL?

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: (url ?? URL(string: ""))!)
        uiView.load(request)
    }
}

func downloadVideo() {
    var isDownloading = false
    var downloadStatus = ""
    
    
    guard let url = URL(string: "") else {return}
    let session = URLSession(configuration: .default)
    let request = URLRequest(url: url)
    
    isDownloading = true
    downloadStatus = "Starting download..."
    
    let task = session.downloadTask(with: request) { localURL, response, error in
        if let error = error {
            print(error.localizedDescription)
            DispatchQueue.main.async {
                downloadStatus = "Error: \(error.localizedDescription)"
                isDownloading = false
            }
            return
        }
        
        if let localURL = localURL {
            // Get the destination path to store the video
            let fileManager = FileManager.default
            let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = documentsDirectory.appendingPathComponent("downloaded_video.mp4")
            
            do {
                // Remove file if it already exists
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }
                
                // Move the downloaded file to the destination URL
                try fileManager.moveItem(at: localURL, to: destinationURL)
                DispatchQueue.main.async {
                    downloadStatus = "Download completed: \(destinationURL)"
                }
            } catch {
                DispatchQueue.main.async {
                    downloadStatus = "File error: \(error.localizedDescription)"
                }
            }
        }
        DispatchQueue.main.async {
            isDownloading = false
        }
    }
    task.resume()
    
    
    
    
}


#Preview {
    MovieDetailsView( movieID: 923667, isMovie: true)
}
