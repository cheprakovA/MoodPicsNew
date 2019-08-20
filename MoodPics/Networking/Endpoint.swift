//
//  EndPoint.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 17/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var urlParameters: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponent: URLComponents {
        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path = path
        urlComponent?.queryItems = urlParameters
        
        return urlComponent!
    }
    
    var request: URLRequest {
        return URLRequest(url: urlComponent.url!)
    }
}

enum Order: String {
    case popular, latest, oldest
}

enum UnsplashEndpoint: Endpoint {
    case photos(id: String, order: Order)
    
    var baseUrl: String {
        return NetworkConstants.baseUrl
    }
    
    var path: String {
        switch self {
        case .photos:
            return "/photos"
        }
    }
    
    var urlParameters: [URLQueryItem] {
        switch self {
        case .photos(let id, let order):
            return [
                URLQueryItem(name: "client_id", value: id),
                URLQueryItem(name: "order_by", value: order.rawValue),
                URLQueryItem(name: "per_page", value: "20")
            ]
        }
    }
}
