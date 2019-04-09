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
    static private let publicKey = "45b6b4bb029056072b78f8c88c1a8b95"
    static private let privateKey = "e9c679c23238a5867f1ac9f8dfef052761bfe0ae"
    
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
