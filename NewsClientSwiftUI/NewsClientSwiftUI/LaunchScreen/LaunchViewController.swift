//
//  LaunchViewController.swift
//  NewsClientSwiftUI
//
//  Created by Ruslan Liulka on 17.03.2025.
//

import UIKit
import SnapKit
import Lottie

class LaunchViewController: UIViewController {
    
    private let launchAnimation = LottieAnimationView(name: "LaunchAnimation")

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(launchAnimation)
        
        launchAnimation.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    

}
