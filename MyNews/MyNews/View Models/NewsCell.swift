//
//  NewsCell.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import UIKit


class NewsViewCell: UITableViewCell, Colors, Fonts, HIG {
    static let identifier = "NewsCellId"
    
    private lazy var newsImage: CachedImageView = {
        let i = CachedImageView()
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.layer.cornerRadius = 16
        i.layer.zPosition = 1
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var blackFade: CAGradientLayer = {
        let g = CAGradientLayer()
        
        g.type = .axial
        g.startPoint = CGPoint(x: 0, y: 0)
        g.endPoint = CGPoint(x: 0, y: 1)
        g.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor, UIColor.black.cgColor]
        g.locations = [0.6, 0.95]
        
        g.frame.origin = .zero
        g.frame.size = CGSize(width: UIScreen.main.bounds.width - 2*padding, height: newsCellHeight - 2*smallPadding)
        
        g.zPosition = 2
        return g
    }()
    
    private lazy var mainTitle: UILabel = {
        let l = UILabel()
        
        l.font = .boldSystemFont(ofSize: 16)
        l.textColor = .white
        l.numberOfLines = .zero
        l.layer.zPosition = 3
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    
//  MARK: - lifeCycle
    override func prepareForReuse() { super.prepareForReuse()
        newsImage.image = nil
        mainTitle.text = "Article Title"
    }
    
    
//  MARK: - Private funcs
    private func setupViews() {
        addSubview(newsImage)
        addSubview(mainTitle)
    
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: topAnchor, constant: smallPadding),
            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            newsImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -smallPadding),
            
            mainTitle.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: smallPadding),
            mainTitle.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: -smallPadding),
            mainTitle.bottomAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: -smallPadding),
        ])
        
        newsImage.layer.addSublayer(blackFade)
    }
    
    
//  MARK: - funcs
    func setArticleData(article: Article) {
        mainTitle.text = article.title
        
        if let urlToImage = article.urlToImage {
            newsImage.setImage(with: urlToImage)
        } else {
            newsImage.image = UIImage(named: "imagePlaceholder")
        }
    }
}
