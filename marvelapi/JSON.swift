//
//  JSON.swift
//  marvelapi
//
//  Created by Taro on 2018/12/17.
//  Copyright © 2018 Taro. All rights reserved.
//

import Foundation

struct Characters:Codable{
    let id:Int
    let name:String
    let description:String
    let thumbnail: Thumbnail
}

extension Characters {
    struct Thumbnail:Codable {
        let path:String
        let `extension`:String
        var url:URL {
            return URL(string: path + "." + `extension`)!
        }
    }
}

struct CharacterResponse<T: Codable>: Codable {
    let data: CharacterResults<T>
}

struct CharacterResults<T: Codable>: Codable {
    let results : [T]
}
