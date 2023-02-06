//
//  MainPageTableViewExtension.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import UIKit


extension MainPageController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return newsCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModels.tableView.dequeueReusableCell(withIdentifier: NewsViewCell.identifier, for: indexPath) as! NewsViewCell
        cell.setArticleData(article: self.newsArticles[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appCoordinator?.pushDetailedArticlePage(with: newsArticles[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension MainPageController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > viewModels.tableView.contentSize.height - scrollView.frame.size.height - largePadding {
//            print("More news, baby")
            let paging = newsArticles.count / 20
            appCoordinator?.getMorePagingNews(paging: paging)
        }
    }
}
