//
//  AppDelegate.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let onboardPage = OnboardPageController()
        let nc = UINavigationController(rootViewController: onboardPage)
        
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        let networkClient = NetworkClientImplementation(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImplementation(networkClient: networkClient)
        
        let mainPage = MainPageController()
        let webpage = WebPageController()
        let detailedArticlePage = DetailedArticlePageController(webpage: webpage)
        
        let appCoordinator = AppCoordinator(
            onboardPage: onboardPage,
            mainPage: mainPage,
            detailedArticlePage: detailedArticlePage,
            networkService: networkService
        )
        onboardPage.appCoordinator = appCoordinator
        mainPage.appCoordinator = appCoordinator
        
        appCoordinator.fetchFirstPagingNews()
        
        return true
    }

}

