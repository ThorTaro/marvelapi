//
//  CharacterDetailViewController.swift
//  marvelapi
//
//  Created by Taro on 2018/12/18.
//  Copyright © 2018 Taro. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController {
    private var characterID:Int = 0
    private var imageURL:URL?
    
    private lazy var characterImageView:UIImageView = {
        let myImageView = UIImageView()
            myImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/5 * 3)
            myImageView.backgroundColor = .black
            myImageView.contentMode = .scaleAspectFit
        return myImageView
    }()
    
    
    init(characterID:Int, imageURL: URL) {
        self.characterID = characterID
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.view.addSubview(characterImageView)
        self.setImage()

    }
    
    private func setupUI(){
        self.view.backgroundColor = .black
        self.title = "Character ID:\(characterID)"
    }
    
    private func setImage(){
        guard let url = imageURL else{ return }
        self.characterImageView.kf.indicatorType = .activity
        self.characterImageView.kf.setImage(with: url)
    }
    
    
}
