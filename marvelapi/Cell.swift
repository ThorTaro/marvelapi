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
    private let characterView:UIImageView = {
        let imageView = UIImageView()
            imageView.backgroundColor = .black
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
            label.backgroundColor = .clear
            label.textColor = .white
            label.numberOfLines = 0
            label.textAlignment = .right
            label.text = "Hero name"
        return label
    }()
    
    private let gradationLabel:CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        let colorTop = UIColor.clear
        let blackColor = UIColor.black
        let colorBottom = blackColor.withAlphaComponent(0.9)
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        return gradientLayer
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.layoutMargins = .zero
        self.preservesSuperviewLayoutMargins = false
        self.backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(size:CGRect){
        self.characterView.frame = size
        self.contentView.addSubview(characterView)
        self.setGradation(size: size)
    }
    
    public func setName(size:CGRect, text:String){
        self.nameLabel.frame = size
        self.nameLabel.text = text
        self.nameLabel.font = UIFont.systemFont(ofSize: CGFloat(nameLabel.frame.height/3))
        self.contentView.addSubview(nameLabel)
    }
    
    private func setGradation(size:CGRect){
        gradationLabel.frame = size
        self.characterView.layer.insertSublayer(gradationLabel, at: 0)
    }
    
    public func loadImage(imageURL:URL){
        self.characterView.kf.indicatorType = .activity
        self.characterView.kf.setImage(with: imageURL)
    }
}
