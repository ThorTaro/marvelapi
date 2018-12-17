//
//  ViewModel.swift
//  marvelapi
//
//  Created by Taro on 2018/12/17.
//  Copyright © 2018 Taro. All rights reserved.
//

import UIKit
import Moya

public class ListViewModel{
    private let provider = MoyaProvider<Model>()
    private var characterList = [Characters]()
    private var state:resultState = .failure
    
    func requestCharacters(searchWord:String,getResponse:@escaping (resultState,[Characters]) -> ()){
        provider.request(.search(searchWord)){ [weak self] result in
            guard let weakself = self else { return }
            switch result {
            case .success(let response):
                do{
                    weakself.characterList = try response.map(CharacterResponse<Characters>.self).data.results
                    weakself.state = .success
                } catch {
                    print("JSON ERROR")
                    weakself.state = .failure
                }
            case .failure(let error):
                print(error)
                weakself.state = .failure
            }
            getResponse(weakself.state,weakself.characterList)
        }
    }
}

extension ListViewModel {
    enum resultState {
        case success
        case failure
    }
}

