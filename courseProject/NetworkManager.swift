//
//  NetworkManager.swift
//  courseProject
//
//  Created by Alexey Soloviov on 19.01.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    private init (){ }
    
    static let shared = NetworkManager()
    
    func loadMoviesList(completionBlock: @escaping(([Movie])->())){

        let weekTrendMoviesUrl = "https://api.themoviedb.org/3/trending/movie/week?api_key=cac5c02f253fd54711409de68de3e9fa"
        
        AF.request(weekTrendMoviesUrl).response { response in
            
            guard let response = response.data else {
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let moviesResponseModel = try jsonDecoder.decode(MovieServerResponse.self, from: response)
                
                completionBlock(moviesResponseModel.results ?? [])
            }catch {
                debugPrint(error)
            }
        }
    }
    
    
    func loadSerialsList(completionBlock: @escaping(([Serial])->())){
        let weekTrendSerilasUrl = "https://api.themoviedb.org/3/trending/tv/week?api_key=cac5c02f253fd54711409de68de3e9fa"

        AF.request(weekTrendSerilasUrl).response { response in
            guard let response = response.data else {
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let serialsResponseModel = try jsonDecoder.decode(SerialServerResponse.self, from: response)
                
                completionBlock(serialsResponseModel.results ?? [])
            }catch {
                debugPrint(error)
            }
        }
    }
}
