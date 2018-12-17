//
//  ViewController.swift
//  marvelapi
//
//  Created by Taro on 2018/12/17.
//  Copyright © 2018 Taro. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    private lazy var searchBar:UISearchBar = {
        let bar = UISearchBar()
        bar.frame = CGRect(x: self.view.frame.width/20, y: self.view.frame.height/4, width: self.view.frame.width/20 * 18, height: self.view.frame.height/20)
        bar.placeholder = "Name starts with...?"
        bar.delegate = self
        bar.backgroundColor = .white
        let barBackImage = bar.value(forKey: "_background") as! UIImageView
        barBackImage.removeFromSuperview()
        return bar
    }()
    
    private lazy var button:UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: self.view.frame.width/20 * 6,
                              y: self.searchBar.frame.maxY + self.searchBar.frame.height,
                              width: self.view.frame.width/20 * 8,
                              height: self.view.frame.height/16)
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .red
        button.setTitle("Search!", for: UIControl.State())
        button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(button.frame.height/2))
        button.setTitleColor(.white, for: UIControl.State())
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action:#selector(didTapButton),
                         for: .touchUpInside)
        button.addTarget(self, action: #selector(onDownButton), for: .touchDown)
        button.addTarget(self, action: #selector(onUpButton), for: [.touchUpInside, .touchUpOutside])
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .red
        view.addSubview(searchBar)
        view.addSubview(button)
        
    }
    
    private func setupNavUI(){
        title = "Search"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.red]
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .red
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func didTapButton(sender: UIButton){
        self.view.endEditing(true)
        Timer.scheduledTimer(timeInterval: 0.1,target: self,selector: #selector(goNextVC), userInfo: nil, repeats: false)
    }
    
    @objc func goNextVC(){
        guard let text = searchBar.text else { return }
        if !text.isEmpty {
            let nextVC = CharacterListViewController()
            nextVC.searchWord = text
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            return
        }
    }
    
    @objc func onDownButton(sender: UIButton){
        UIView.animate(withDuration: 0.06){ () -> Void in
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    @objc func onUpButton(sender: UIButton){
        UIView.animate(withDuration: 0.1){ () -> Void in
            sender.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}

extension SearchViewController:UISearchBarDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.didTapButton(sender: button)
    }
}


