//
//  Cell.swift
//  marvelapi
//
//  Created by Taro on 2018/12/17.
//  Copyright © 2018 Taro. All rights reserved.
//

import UIKit
import Kingfisher

class tableviewCell:UITableViewCell{
    public let characterView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public let nameLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Hero name"
        label.textColor = .white
        return label
    }()
    
    public let descriptionLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Description"
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        backgroundColor = .black
        textLabel?.adjustsFontSizeToFitWidth = true
        textLabel?.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(size:CGRect){
        characterView.frame = size
        self.contentView.addSubview(characterView)
    }
    
    public func setName(size:CGRect, text:String){
        nameLabel.frame = size
        nameLabel.text = text
        nameLabel.font = UIFont.systemFont(ofSize: CGFloat(nameLabel.frame.height * 0.6))
//        self.contentView.addSubview(nameLabel)
    }
    
    public func setDescription(size:CGRect, text:String){
        descriptionLabel.frame = size
        descriptionLabel.text = text == "" ? "No description":text
        descriptionLabel.font = UIFont.systemFont(ofSize: CGFloat(descriptionLabel.frame.height * 0.8))
//        self.contentView.addSubview(descriptionLabel)
    }
    
    public func loadImage(imageURL:URL){
        self.characterView.kf.indicatorType = .activity
        self.characterView.kf.setImage(with: imageURL)
    }
}
