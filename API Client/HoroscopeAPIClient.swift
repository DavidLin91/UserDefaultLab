//
//  HoroscopeAPIClient.swift
//  UserDefaultLab
//
//  Created by David Lin on 1/13/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import Foundation
import NetworkHelper

struct HoroscopeAPIClient {
    static func getHoroscope(completion: @escaping(Result < [Horoscopes], AppError>) ->()) {
        
        let endpointURL = "http://sandipbgt.com/theastrologer/api/horoscope/all/today"
        
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        var horoscope = [Horoscopes]()
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let horoscopeData = try JSONDecoder().decode([Horoscopes].self, from: data)
                    horoscope = horoscopeData
                    completion(.success(horoscope))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
