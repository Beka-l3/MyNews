//
//  DetailedArticlePageController.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import UIKit


class DetailedArticlePageController: UIViewController, Colors, Fonts, HIG {
    
    private let viewModels = DetailedArticlePageViewModels()
    private var currentArticle: Article?
    private let webpage: WebPageController
    
    init(webpage: WebPageController) {
        self.webpage = webpage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    override func viewDidLoad() { super.viewDidLoad()
        view.backgroundColor = dominantColor
        setupViews()
        viewModels.linkButton.addTarget(self, action: #selector(openLink), for: .touchUpInside)
    }
    
    
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        setupNavStyle()
    }
    
//  MARK: - objc
    @objc func openLink() {
        webpage.urlString = viewModels.urlToArticle
        webpage.loadAddress()
        present(webpage, animated: true, completion: nil)
    }
    
//  MARK: - private funcs
    private func setupViews() {
        viewModels.setupViews(parent: view)
    }
    
    private func setupNavStyle() {
        self.navigationItem.title = "Article"
        self.navigationItem.hidesBackButton = false
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = focusColor
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let titleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = blurEffect
        appearance.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        appearance.titleTextAttributes = titleAttr
        
        self.navigationItem.standardAppearance = appearance
    }

    
//  MARK: - funcs
    func setArticleData(article: Article) {
        currentArticle = article
        viewModels.setupData(article: article)
    }

}
