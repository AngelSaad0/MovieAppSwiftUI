//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//

protocol NetworkManagerProtocol:AnyObject{
    func fetchData<T:Codable>(from endpoint: MovieApi,responseType: T.Type,completion: @escaping(T?)->())
    func loadImage(from imageUrl: String, completion: @escaping (Data?) -> Void)

}
import Foundation
class NetworkManager:NetworkManagerProtocol{

    func fetchData<T:Codable>(from endpoint: MovieApi,responseType: T.Type,completion: @escaping(T?)->()){
        guard let url = URL(string: endpoint.urlString) else {
            print("error in url")
            completion(nil)
            return
        }
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data  else {
                print("error in data")
                completion(nil)
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData)


            } catch {
                print("error in decoded data")
                completion(nil)

            }


        }
        task.resume()
    }
    func loadImage(from imageUrl: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)")else{
            print("error in create image url")
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else {
                print("Invalid data or response")
                    completion(nil)
                return
            }
                completion(data)
        }
        task.resume()
    }

}


