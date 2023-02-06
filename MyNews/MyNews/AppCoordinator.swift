//
//  AppCoordinator.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import Foundation


class AppCoordinator {
    
    private let onboardPage: OnboardPageController
    private let mainPage: MainPageController
    private let detailedArticlePage: DetailedArticlePageController
    private let networkService: NetworkService
    private let fileCache: FileCache<Article>
    private let topResultsUrlsFileCache: FileCache<[String]> = .init()
    private var cachedTopResultsUrls: [String] {
        get {
            return (try? topResultsUrlsFileCache.get(for: "Base")) ?? []
        }
        set(newValue) {
            try? topResultsUrlsFileCache.insert(newValue, for: "Base")
        }
    }
    
    private var firstPageNews: [Article]
    private var isReadyForSession: Bool
    private var isGettingMoreArticles: Bool
    
    init(
        onboardPage: OnboardPageController,
        mainPage: MainPageController,
        detailedArticlePage: DetailedArticlePageController,
        networkService: NetworkService
    ) {
        self.onboardPage = onboardPage
        self.mainPage = mainPage
        self.detailedArticlePage = detailedArticlePage
        self.networkService = networkService
        self.firstPageNews = []
        self.fileCache = .init()
        self.isReadyForSession = false
        self.isGettingMoreArticles = false
    }
    
    
    func fetchFirstPagingNews() {
        firstPageNews = cachedTopResultsUrls.compactMap {
            return try? fileCache.get(for: $0)
        }
        self.finishedAnimation()
        networkService.fetchNews(credentials: 0) { [weak self] result in
            switch result {
            case .success(let news):
                if let articles = news.articles {
                    self?.firstPageNews = articles
                    self?.cachedTopResultsUrls = articles.compactMap { $0.url }
                    articles.forEach {
                        if let url = $0.url {
                            try? self?.fileCache.insert($0, for: url)
                        }
                    }
                }
            case .failure(_):
                break
            }
        }
    }
    

}


extension AppCoordinator: OnboardingPageDelegate {
    func finishedAnimation() {
        if isReadyForSession {
            mainPage.setFirstPageArticles(articles: firstPageNews)
            onboardPage.navigationController?.pushViewController(mainPage, animated: true)
        } else {
            isReadyForSession = true
        }
    }
}

extension AppCoordinator: MainPageDelegate {
    func pushDetailedArticlePage(with article: Article) {
        detailedArticlePage.setArticleData(article: article)
        mainPage.navigationController?.pushViewController(detailedArticlePage, animated: true)
    }
    
    func getMorePagingNews(paging: Int) {
        if !isGettingMoreArticles {
            isGettingMoreArticles = true
            networkService.fetchNews(credentials: paging) { [weak self] result in
                switch result {
                case .success(let news):
                    if let articles = news.articles {
                        self?.mainPage.addNewPageArticles(articles: articles)
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func didFinishReloadingTable() {
        isGettingMoreArticles = false
    }
}

