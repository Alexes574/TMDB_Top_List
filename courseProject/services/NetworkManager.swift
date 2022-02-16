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
        
        let weekTrendMoviesUrl = Constants.network.TMDBPath + "trending/movie/week?api_key=" + Constants.network.apiKey
        
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
        let weekTrendSerilasUrl = Constants.network.TMDBPath + "trending/tv/week?api_key=" + Constants.network.apiKey
        
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
    
    func loadMovieVideoKey(_ mediaId: String, completion: @escaping((String) -> ())) {
        
        let url = Constants.network.TMDBPath + "movie/\(mediaId)/videos?api_key=" + Constants.network.apiKey
        
        AF.request(url).responseJSON { response in

            let decoder = JSONDecoder()

            if let data = try? decoder.decode(VideoServerRespons.self, from: response.data!) {
                let videoKey =  data.results?.first?.key ?? ""
                completion(videoKey)
            }
        }
    }
    
    func loadSerialVideoKey(_ mediaId: String, completion: @escaping((String) -> ())) {
        
        let url = Constants.network.TMDBPath + "tv/\(mediaId)/videos?api_key=" + Constants.network.apiKey
        
        AF.request(url).responseJSON { response in

            let decoder = JSONDecoder()

            if let data = try? decoder.decode(VideoServerRespons.self, from: response.data!) {
                let videoKey =  data.results?.first?.key ?? ""
                completion(videoKey)
            }
        }
    }
    
    func loadMovieGenresList(completionBlock: @escaping(([MediaGenres])->())){
        let movieGenresListUrl = Constants.network.TMDBPath + "genre/movie/list?api_key=\(Constants.network.apiKey)&language=en-US"
        
        AF.request(movieGenresListUrl).response { response in
            guard let response = response.data else {
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let movieGenresListModel = try jsonDecoder.decode(GenresServerRespons.self, from: response)
                
                completionBlock(movieGenresListModel.genres ?? [])
            }catch {
                debugPrint(error)
            }
        }
    }
    
    func loadSerialGenresList(completionBlock: @escaping(([MediaGenres])->())){
        let serialGenresListUrl = Constants.network.TMDBPath + "genre/tv/list?api_key=\(Constants.network.apiKey)&language=en-US"
        
        AF.request(serialGenresListUrl).response { response in
            guard let response = response.data else {
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let serialGenresListModel = try jsonDecoder.decode(GenresServerRespons.self, from: response)
                
                completionBlock(serialGenresListModel.genres ?? [])
            }catch {
                debugPrint(error)
            }
        }
    }
    
    
    
//    func loadAllDayTrendings(completionBlock: @escaping(([Serial],[Movie]) ->())){
//        let dayTrendingsUrl = "https://api.themoviedb.org/3/trending/all/day?api_key=cac5c02f253fd54711409de68de3e9fa"
//        AF.request(dayTrendingsUrl).response { response in
//            guard let response = response.data else{
//                return
//            }
//
//            do {
//
//            }catch {
//                debugPrint(error)
//            }
//        }
//    }
}

