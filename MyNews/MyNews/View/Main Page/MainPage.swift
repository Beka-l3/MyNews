//
//  ViewController.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import UIKit

protocol MainPageDelegate {
    func pushDetailedArticlePage(with article: Article)
    func getMorePagingNews(paging: Int)
    func didFinishReloadingTable()
}


class MainPageController: UIViewController, Colors, Fonts, HIG {

    var appCoordinator: MainPageDelegate?
    
    internal let viewModels = MainPageViewModels()
    internal var newsArticles: [Article]
    
    init() {
        self.newsArticles = []
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
//  MARK: - lifecycle
    override func viewDidLoad() { super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        setupViews()
        viewModels.tableView.dataSource = self
        viewModels.tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        setupNavStyle()
    }
    
    override func viewWillDisappear(_ animated: Bool) { super.viewWillDisappear(animated)
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

//  MARK: - objc
    
    
//  MARK: - private funcs
    private func setupViews() {
        viewModels.setupViews(parent: view)
    }
    
    private func setupNavStyle() {
        self.navigationItem.title = "News"
        self.navigationItem.hidesBackButton = true
//        self.navigationItem.largeTitleDisplayMode = .always
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = focusColor
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let largeTitleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)
        ]
        let titleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = blurEffect
        appearance.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        appearance.largeTitleTextAttributes = largeTitleAttr
        appearance.titleTextAttributes = titleAttr
        
        let largeAppearance = UINavigationBarAppearance()
        largeAppearance.backgroundEffect = nil
        largeAppearance.backgroundColor = .clear
        largeAppearance.shadowColor = .clear
        largeAppearance.largeTitleTextAttributes = largeTitleAttr
        largeAppearance.titleTextAttributes = titleAttr
        
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = largeAppearance
    }
    
    
//  MARK: - public func
    func setFirstPageArticles(articles: [Article]) {
        newsArticles = articles
    }
    
    func addNewPageArticles(articles: [Article]) {
        newsArticles.append(contentsOf: articles)
        viewModels.tableView.reloadData()
        appCoordinator?.didFinishReloadingTable()
    }
}

