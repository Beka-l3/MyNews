//
//  MainPageViewCOntrollers.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import UIKit


class MainPageViewModels: Colors, Fonts, HIG {
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.register(NewsViewCell.self, forCellReuseIdentifier: NewsViewCell.identifier)
        t.separatorStyle = .none
        
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    
    func setupViews(parent: UIView) {
        parent.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: parent.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
        ])
    }
    
}
