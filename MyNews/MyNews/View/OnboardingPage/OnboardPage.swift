//
//  OnboardPage.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import UIKit


protocol OnboardingPageDelegate {
    func finishedAnimation()
}

class OnboardPageController: UIViewController, Fonts, Colors, HIG {
    
    var appCoordinator: OnboardingPageDelegate?
    
    private let viewModels = OnboardPageViewModels()
    private var isReadyForSession: Bool
    
    init() {
        self.isReadyForSession = false
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
//  MARK: - lifecycle
    override func viewDidLoad() { super.viewDidLoad()
        view.backgroundColor = dominantColor
        setupViews()
    }
    
    override func viewWillLayoutSubviews() { super.viewWillLayoutSubviews()
        viewModels.setupLayers(parent: view)
    }
    
    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated)
        startAnimations()
    }
    
//  MARK: - private func
    private func setupViews() {
        viewModels.setupViews(parent: view)
    }
    
    private func startAnimations() {
        viewModels.startAnimations() { [weak self] in
            self?.appCoordinator?.finishedAnimation()
        }
    }
}
