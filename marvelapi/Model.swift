//
//  Model.swift
//  marvelapi
//
//  Created by Taro on 2018/12/17.
//  Copyright © 2018 Taro. All rights reserved.
//

import Foundation
import Moya

public enum Model {
    static private let publicKey = " YOUR MARVEL COMICS API PUBLIC KEY"
    static private let privateKey = " YOUR MARVEL COMICS API PRIVATE KEY"
    
    case search(String)
}

extension Model:TargetType{
    public var baseURL: URL {
        return URL(string: "https://gateway.marvel.com/v1/public")!
    }
    
    public var path: String {
        switch self{
        case .search:
            return "/characters"
        }
    }
    
    public var method: Moya.Method {
        switch self{
        case .search:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        let ts = "\(Date().timeIntervalSince1970)"
        
        let hash = (ts + Model.privateKey + Model.publicKey).md5()
        
        switch self{
        case .search(let searchWord):
            return .requestParameters(
                parameters: [
                    "nameStartsWith":searchWord,
                    "apikey": Model.publicKey,
                    "ts": ts,
                    "hash": hash],
                encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
    
    public var validationType: ValidationType{
        return .successCodes
    }
}
