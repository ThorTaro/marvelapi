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
    private var characterName:String = "Character Name"
    private var characterDescription:String = "Character description"
    
    private lazy var characterIcon:UIImageView = {
        let myImageView = UIImageView()
            myImageView.frame = CGRect(x: self.view.frame.width/4,
                                       y: self.nameLabel.frame.minY - self.view.frame.width/2,
                                       width: self.view.frame.width/2,
                                       height: self.view.frame.width/2)
            myImageView.backgroundColor = .clear
            myImageView.contentMode = .scaleAspectFit
        return myImageView
    }()
    
    private lazy var characterImageView:UIImageView = {
        let myImageView = UIImageView()
            myImageView.frame = self.view.frame
            myImageView.backgroundColor = .black
            myImageView.contentMode = .scaleAspectFill
            myImageView.clipsToBounds = true
        return myImageView
    }()
    
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
            label.frame = CGRect(x: self.view.frame.width/20,
                                 y: self.view.frame.height/2,
                                 width: self.view.frame.width/20 * 18,
                                 height: self.view.frame.height/20 * 2)
            label.text = "Character Name"
            label.numberOfLines = 0
            label.backgroundColor = .clear
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: CGFloat(self.view.frame.height/24))
        return label
    }()
    
    private lazy var descriptionLabel:UITextView = {
        let textView = UITextView()
            textView.frame = CGRect(x: self.view.frame.width/20,
                                    y: nameLabel.frame.maxY,
                                    width: nameLabel.frame.width,
                                    height: nameLabel.frame.height)
            textView.font = UIFont.systemFont(ofSize: CGFloat(self.view.frame.height/24 * 0.7))
            textView.backgroundColor = .clear
            textView.textColor = .lightGray
            textView.isEditable = false
            textView.isSelectable = false
        return textView
    }()
    
    
    init(characterID:Int, imageURL: URL, characterName:String, characterDescription:String) {
        self.characterID = characterID
        self.imageURL = imageURL
        self.characterName = characterName
        self.characterDescription = characterDescription
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setImage()
        self.setBlur()
        self.setName()
        self.setDescriptionView()
        self.loadIcon()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *){
            let window = UIApplication.shared.keyWindow
            let bottom = window?.safeAreaInsets.bottom
            self.descriptionLabel.frame.size.height = self.view.frame.maxY - self.descriptionLabel.frame.minY - (bottom ?? 0)
        }
    }
    
    private func setupUI(){
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.topItem?.title = " "
        self.view.addSubview(characterImageView)
    }
    
    private func loadIcon(){
        self.view.addSubview(characterIcon)
        guard let url = imageURL else { return }
        self.characterIcon.kf.indicatorType = .activity
        self.characterIcon.kf.setImage(with: url)
    }
    
    private func setImage(){
        guard let url = imageURL else { return }
        self.characterImageView.kf.indicatorType = .activity
        self.characterImageView.kf.setImage(with: url)
    }
    
    private func setBlur(){
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 0.9
        visualEffectView.frame = characterImageView.frame
        self.view.addSubview(visualEffectView)
    }
    
    private func setName(){
        self.nameLabel.text = self.characterName
        self.view.addSubview(nameLabel)
    }
    
    private func setDescriptionView(){
        self.descriptionLabel.text = self.characterDescription == "" ? "No descriptiion": self.characterDescription
        self.view.addSubview(descriptionLabel)
    }
}
