//
//  ProfileDesignViewController.swift
//  CoreDataProject
//
//  Created by t2023-m0061 on 2023/09/14.
//

import UIKit
import SwiftUI
import SnapKit

class ProfileDesignViewController: UIViewController {
    
    private let profileView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "nbcamp"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let menuButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(profileView)
        profileView.addSubview(userNameLabel)
        
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(54)
            make.centerX.equalToSuperview()
        }
    }
    
}

// SwiftUI를 활용한 미리보기
struct ProfileDesignViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ProfileDesignViewControllerReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct ProfileDesignViewControllerReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let profileDesignViewController = ProfileDesignViewController()
        return UINavigationController(rootViewController: profileDesignViewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    typealias UIViewControllerType = UIViewController
}
