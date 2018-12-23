//
//  CharacterListViewController.swift
//  marvelapi
//
//  Created by Taro on 2018/12/17.
//  Copyright © 2018 Taro. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController {
    private var searchWord: String = "searchWord"
    private let model = ListViewModel()
    private var characters = [Characters]()
    private var state: State = .Init {
        didSet{
            switch state {
            case .Init:
                self.statusLabel.isHidden = true
            case .Loading:
                self.statusLabel.text = "Loading..."
            case .Result:
                self.statusLabel.isHidden = true
                self.view.addSubview(characterListView)
            case .NotFound:
                self.statusLabel.text = "Not Found"
            case .Error:
                self.statusLabel.text = "Error"
            }
        }
    }
    
    private lazy var characterListView:UITableView = {
        let table = UITableView()
            table.frame = self.view.frame
            table.tableFooterView = UIView(frame: .zero)
            table.backgroundColor = .black
            table.register(tableviewCell.self, forCellReuseIdentifier: NSStringFromClass(tableviewCell.self))
            table.separatorStyle = .none
            table.delegate = self
            table.dataSource = self
        return table
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
            label.frame = CGRect(x: 0,
                                 y: self.view.frame.minY - (self.navigationController?.navigationBar.frame.height ?? 0),
                                 width: self.view.frame.width,
                                 height: self.view.frame.height/20)
            label.center = self.view.center
            label.backgroundColor = .black
            label.textColor = .lightGray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: CGFloat(label.frame.height * 0.8))
            label.text = "Loading..."
        return label
    }()
    
    init(searchWord:String){
        self.searchWord = searchWord
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavUI()
        setupUI()
        loadCharacters()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *){
            let window = UIApplication.shared.keyWindow
            let bottom = window?.safeAreaInsets.bottom ?? 0
            let top = (window?.safeAreaInsets.top ?? 0) + (self.navigationController?.navigationBar.frame.height ?? 0)
            self.characterListView.frame.origin.y = top
            self.characterListView.frame.size.height = self.view.frame.height - top - bottom
            self.characterListView.rowHeight = characterListView.frame.height/4
        }
    }
    
    private func setupNavUI(){
        self.title = " "
    }
    
    private func setupUI(){
        self.view.backgroundColor = .black
        self.view.addSubview(statusLabel)
    }
    
    private func loadCharacters(){
        self.state = .Loading
        model.requestCharacters(searchWord:searchWord){ [weak self] (status, result) in
            guard let weakself = self else { return }
            switch status {
            case .success:
                weakself.characters = result
                if weakself.characters.count != 0 {
                    weakself.state = .Result
                } else {
                    weakself.state = .NotFound
                }
            case .failure:
                weakself.state = .Error
            }
        }
    }
}


extension CharacterListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(tableviewCell.self), for: indexPath) as! tableviewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.setImage(size: CGRect(x:0,
                                       y:0,
                                       width:self.characterListView.bounds.width,
                                       height:self.characterListView.rowHeight * 0.99))
            cell.setName(size: CGRect(x: self.characterListView.bounds.width/20,
                                      y: self.characterListView.rowHeight/2,
                                      width: self.characterListView.bounds.width/20 * 18,
                                      height: self.characterListView.rowHeight/2),
                         text: self.characters[indexPath.row].name)
            cell.loadImage(imageURL: self.characters[indexPath.row].thumbnail.url)
        return cell
    }
}

extension CharacterListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailVC = CharacterDetailViewController(imageURL: self.characters[indexPath.row].thumbnail.url,
                                                              characterName: self.characters[indexPath.row].name,
                                                              characterDescription: self.characters[indexPath.row].description)
        self.navigationController?.pushViewController(characterDetailVC, animated: true)
    }
}

extension CharacterListViewController {
    enum State {
        case Init
        case Loading
        case Result
        case NotFound
        case Error
    }
}

