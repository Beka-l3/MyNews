//
//  DetailedArticlePageViewModels.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import UIKit


class DetailedArticlePageViewModels: Colors, Fonts, HIG {
    
    var urlToArticle: String = ""
    let dateFormatter = ISO8601DateFormatter()
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
//        s.contentMode = .center
        s.distribution = .fill
        s.backgroundColor = .clear
        s.spacing = smallPadding
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    
    private lazy var mainTitle: UILabel = {
        let l = UILabel()
        
        l.font = .boldSystemFont(ofSize: 24)
        l.textColor = .black
        l.numberOfLines = .zero
        l.layer.zPosition = 3
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var descriptionText: UILabel = {
        let l = UILabel()
        
        l.font = .systemFont(ofSize: 14)
        l.textColor = .black
        l.numberOfLines = .zero
        l.layer.zPosition = 3
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var newsImage: CachedImageView = {
        let i = CachedImageView()
        i.contentMode = .scaleAspectFit
        i.clipsToBounds = true
        i.layer.cornerRadius = 16
        i.layer.zPosition = 1
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var authorText: UILabel = {
        let l = UILabel()
        
        l.font = .systemFont(ofSize: 14)
        l.textColor = .black
        l.numberOfLines = .zero
        l.layer.zPosition = 3
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var dateText: UILabel = {
        let l = UILabel()
        
        l.font = .systemFont(ofSize: 14)
        l.textColor = .gray
        l.numberOfLines = .zero
        l.layer.zPosition = 3
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var sourceText: UILabel = {
        let l = UILabel()
        
        l.font = .boldSystemFont(ofSize: 14)
        l.textColor = .gray
        l.numberOfLines = .zero
        l.layer.zPosition = 3
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var linkButton: UIButton = {
        let b = UIButton(type: .system)
        
        b.setTitle("Full article", for: .normal)
        b.setTitleColor(dominantColor, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 14)
        b.backgroundColor = focusColor
        b.layer.cornerRadius = largePadding / 2
        
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    func setupViews(parent: UIView) {
        parent.addSubview(stackView)
        parent.addSubview(linkButton)
        
        stackView.addArrangedSubview(mainTitle)
        stackView.addArrangedSubview(descriptionText)
        stackView.addArrangedSubview(newsImage)
        stackView.addArrangedSubview(authorText)
        stackView.addArrangedSubview(sourceText)
        stackView.addArrangedSubview(dateText)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            newsImage.heightAnchor.constraint(equalToConstant: newsCellHeight),
            
            linkButton.heightAnchor.constraint(equalToConstant: largePadding),
            linkButton.widthAnchor.constraint(equalToConstant: parent.frame.width * 0.6),
            linkButton.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
            linkButton.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
        ])
    }
    
    func setupData(article: Article) {
        mainTitle.text = article.title
        descriptionText.text = article.description
        
        if let urlToImage = article.urlToImage {
            newsImage.isHidden = false
            newsImage.setImage(with: urlToImage)
        } else {
            newsImage.isHidden = true
        }
        
        if let author = article.author {
            authorText.text = author
            authorText.isHidden = false
        } else {
            authorText.isHidden = true
        }
        
        if let isodate = article.publishedAt {
            dateText.text = dateFormatter.date(from: isodate)!.formatted(date: .abbreviated, time: .shortened)
            dateText.isHidden = false
        } else {
            dateText.isHidden = true
        }
        
        if let source = article.source, let name = source.name {
            sourceText.text = name
            sourceText.isHidden = false
        } else {
            sourceText.isHidden = true
        }
        
        
        if let url = article.url {
            urlToArticle = url
            linkButton.isHidden = false
        } else {
            linkButton.isHidden = true
        }
        
    }
}
