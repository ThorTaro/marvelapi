//
//  CharacterListViewController.swift
//  marvelapi
//
//  Created by Taro on 2018/12/17.
//  Copyright © 2018 Taro. All rights reserved.
//

import UIKit
import Kingfisher


class CharacterListViewController: UIViewController {
    public var searchWord:String = "searchWord"
    private let model = ListViewModel()
    private var characters = [Characters]()
    private var state:State = .Init {
        didSet{
            switch state {
            case .Init:
                self.label.isHidden = true
            case .Loading:
                self.label.text = "Loading..."
            case .Result:
                self.label.isHidden = true
            case .NotFound:
                self.label.text = "Not Found"
            case .Error:
                self.label.text = "Error"
            }
        }
    }
    
    private lazy var tableView:UITableView = {
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
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0,
                             y: self.view.frame.height/8 * 3,
                             width: self.view.frame.width,
                             height: self.view.frame.height/16)
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CGFloat(label.frame.height * 0.8))
        label.text = "Loading..."
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadCharacters()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *){
            let window = UIApplication.shared.keyWindow
            let bottom = window?.safeAreaInsets.bottom
            tableView.frame.size.height = self.view.frame.height - (bottom ?? 0)
            tableView.rowHeight = tableView.frame.height/4
        }
    }
    
    private func setupUI(){
        view.backgroundColor = .black
        view.addSubview(label)
    }
    
    private func loadCharacters(){
        self.state = .Loading
        model.requestCharacters(searchWord:searchWord){ [weak self] (status, result) in
            guard let weakself = self else { return }
            switch status {
            case .success:
                weakself.characters = result
                if weakself.characters.count != 0 {
                    weakself.view.addSubview(weakself.tableView)
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
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(tableviewCell.self), for: indexPath) as! tableviewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setImage(size: CGRect(x:0,
                                   y:0,
                                   width:self.tableView.bounds.width,
                                   height:self.tableView.rowHeight * 0.99))
        cell.setName(size: CGRect(x: self.tableView.bounds.width/20,
                                  y: self.tableView.rowHeight/2,
                                  width: self.tableView.bounds.width/20 * 18,
                                  height: self.tableView.rowHeight/2),
                     text: characters[indexPath.row].name)
        cell.setGradation(size: CGRect(x: 0,
                                       y: 0,
                                       width: self.tableView.bounds.width,
                                       height: self.tableView.rowHeight * 0.99))
        cell.loadImage(imageURL: characters[indexPath.row].thumbnail.url)
        return cell
    }
}

extension CharacterListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailVC = CharacterDetailViewController(characterID: characters[indexPath.row].id, imageURL:characters[indexPath.row].thumbnail.url,characterName:characters[indexPath.row].name,characterDescription:characters[indexPath.row].description)
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

