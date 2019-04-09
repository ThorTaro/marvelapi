//
//  ViewController.swift
//  marvelapi
//
//  Created by Taro on 2018/12/17.
//  Copyright © 2018 Taro. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
            imageView.frame = self.view.frame
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: "home")
        return imageView
    }()
    
    private lazy var searchBar: UITextField = {
        let textField = UITextField()
            textField.frame = CGRect(x: self.view.frame.width/6,
                                     y: self.view.frame.height/16 * 11,
                                     width: self.view.frame.width/12 * 8,
                                     height: self.view.frame.height/20)
            textField.backgroundColor = .clear
            textField.textAlignment = .center
            textField.textColor = .white
            textField.attributedPlaceholder = NSAttributedString(string: "Search character name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            textField.keyboardType = .asciiCapable
            textField.delegate = self
        return textField
    }()
    
    private lazy var searchBarBack: UILabel = {
        let label = UILabel()
            label.frame = self.searchBar.frame
            label.backgroundColor = .black
            label.alpha = 0.5
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
            button.frame = CGRect(x: self.searchBar.frame.minX,
                                  y: self.searchBar.frame.maxY + searchBar.frame.height/4,
                                  width: self.searchBar.frame.width,
                                  height: self.searchBar.frame.height)
            button.backgroundColor = .white
            button.alpha = 0.75
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(.gray, for: UIControl.State())
            button.setTitle("Search", for: UIControl.State())
            button.addTarget(self, action:#selector(didTapButton),
                             for: .touchUpInside)
            button.addTarget(self, action: #selector(downButtonAnimation), for: .touchDown)
            button.addTarget(self, action: #selector(upButtonAnimation), for: [.touchUpInside, .touchUpOutside])
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavUI()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.configureObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserver()
    }
    
    private func setupNavUI(){
        self.title = " "
    }
    
    private func setupUI(){
        self.view.backgroundColor = .black
        self.view.addSubview(backImage)
        self.view.addSubview(searchBarBack)
        self.view.addSubview(searchBar)
        self.view.addSubview(searchButton)
    }
    
    @objc func didTapButton(sender: UIButton){
        self.view.endEditing(true)
        Timer.scheduledTimer(timeInterval: 0.1,
                             target: self,
                             selector: #selector(goNextVC),
                             userInfo: nil,
                             repeats: false)
    }
    
    @objc func goNextVC(){
        guard let text = self.searchBar.text else { return }
        if !text.isEmpty {
            let characterListVC = CharacterListViewController(searchWord: text)
            self.navigationController?.pushViewController(characterListVC, animated: true)
        } else {
            return
        }
    }
    
    @objc func downButtonAnimation(sender: UIButton){
        UIView.animate(withDuration: 0.06){ () -> Void in
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    @objc func upButtonAnimation(sender: UIButton){
        UIView.animate(withDuration: 0.1){ () -> Void in
            sender.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    private func configureObserver(){
        let notification = NotificationCenter.default
        notification.addObserver(self,
                                 selector: #selector(keyboardWillShow(notification:)),
                                 name: UIResponder.keyboardWillShowNotification,
                                 object: nil)
        notification.addObserver(self,
                                 selector: #selector(keyboardWillHide(notification:)),
                                 name: UIResponder.keyboardWillHideNotification,
                                 object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification?){
        let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!){ () in
            let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)! + 50)
            self.view.transform = transform
        }
    }
    
    private func removeObserver(){
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    @objc func keyboardWillHide(notification: Notification?){
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!){ () in
            self.view.transform = CGAffineTransform.identity
        }
    }
    
}

extension SearchViewController:UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
