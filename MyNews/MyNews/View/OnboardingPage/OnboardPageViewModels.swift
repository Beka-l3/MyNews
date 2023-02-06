//
//  OnboardPageViewModels.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import UIKit


class OnboardPageViewModels: Fonts, Colors, HIG  {
    private lazy var appTitleMask: CAGradientLayer = {
        let g = CAGradientLayer()
        
        g.type = .axial
        g.startPoint = CGPoint(x: 0, y: 0)
        g.endPoint = CGPoint(x: 1, y: 0)
        g.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        g.locations = [0.0, 0.0]
        
        return g
    }()
    
    private lazy var appTitle: UILabel = {
        let l = UILabel()
        l.text = GConstants.appTitle
        l.font = appTitleFont
        l.textColor = focusColor
        l.layer.mask = appTitleMask
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var developerTitle: UILabel = {
        let l = UILabel()
        l.text = "\(GConstants.developerTitle) \(GConstants.developerName)"
        l.font = developerTitleFont
        l.textColor = secondaryColor
        l.layer.opacity = 0
        
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    private lazy var topSepartor: UIView = {
        let v = UIView()
        v.backgroundColor = focusSeparatorColor
        v.layer.cornerRadius = separatorHeight / 2
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    private lazy var bottomSepartor: UIView = {
        let v = UIView()
        v.backgroundColor = focusSeparatorColor
        v.layer.cornerRadius = CGFloat(smallSeparatorHeight / 2)
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    func setupViews(parent: UIView) {
        parent.addSubview(appTitle)
        parent.addSubview(developerTitle)
        parent.addSubview(topSepartor)
        parent.addSubview(bottomSepartor)
        
        NSLayoutConstraint.activate([
            appTitle.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            appTitle.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerYAnchor),
            
            developerTitle.leadingAnchor.constraint(equalTo: appTitle.leadingAnchor),
            developerTitle.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerYAnchor),
            
            topSepartor.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            topSepartor.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            topSepartor.bottomAnchor.constraint(equalTo: appTitle.topAnchor, constant: -largePadding),
//            topSepartor.bottomAnchor.constraint(equalTo: appTitle.topAnchor, constant: -parent.frame.height / 2),
            topSepartor.heightAnchor.constraint(equalToConstant: smallSeparatorHeight),
            
            bottomSepartor.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            bottomSepartor.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            bottomSepartor.topAnchor.constraint(equalTo: developerTitle.bottomAnchor, constant: largePadding),
//            bottomSepartor.topAnchor.constraint(equalTo: developerTitle.bottomAnchor, constant: parent.frame.height / 2),
            bottomSepartor.heightAnchor.constraint(equalToConstant: smallSeparatorHeight),
        ])
    }
    
    func setupLayers(parent: UIView) {
        appTitleMask.frame.origin = .zero
        appTitleMask.frame.size = CGSize(width: parent.frame.size.width, height: appTitleFont.pointSize + padding)
    }
    
    func startAnimations(completion: @escaping () -> Void) {
        let a1 = CABasicAnimation(keyPath: "locations")
        a1.toValue = [0.0, 0.2]
        a1.duration = 0.2;
        a1.autoreverses = false
        a1.fillMode = .forwards
        a1.isRemovedOnCompletion = false
        a1.repeatCount = 1
        
        let a2 = CABasicAnimation(keyPath: "locations")
        a2.toValue = [0.8, 1.0]
        a2.duration = 0.6;
        a2.autoreverses = false
        a2.fillMode = .forwards
        a2.isRemovedOnCompletion = false
        a2.repeatCount = 1
        
        let a3 = CABasicAnimation(keyPath: "locations")
        a3.toValue = [1.0, 1.0]
        a3.duration = 0.2;
        a3.autoreverses = false
        a3.fillMode = .forwards
        a3.isRemovedOnCompletion = false
        a3.repeatCount = 1
        
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.6) {
            DispatchQueue.main.async { [weak self] in
                self?.appTitleMask.add(a1, forKey: "animate1")
            }
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.8) {
            DispatchQueue.main.async { [weak self] in
                self?.appTitleMask.add(a2, forKey: "animate2")
            }
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.4) {
            DispatchQueue.main.async { [weak self] in
                self?.appTitleMask.add(a3, forKey: "animate3");
                UIView.animate(withDuration: 0.6) {
                    self?.developerTitle.layer.opacity = 1
                } completion: { done in
                    completion()
                }
            }
        }
    }
}
