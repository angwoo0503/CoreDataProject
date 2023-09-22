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
    
    // MARK: - UI Component
    
    // 배경 뷰
    private let profileView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // 유저 아이디 레이블
    private let userIdLabel : UILabel = {
        let label = UILabel()
        label.text = "Park Sang Woo"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    // 메뉴 버튼
    private let menuButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    // 취소 버튼
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "profile_image")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 44
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    // 포스트 숫자 레이블
    private lazy var postNumLabel : UILabel = {
        let label = UILabel()
        label.text = "7"
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    // 팔로워 숫자 레이블
    private lazy var followerNumLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    // 팔로잉 숫자 레이블
    private lazy var followingNumLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    // 포스트 레이블
    private lazy var postLabel : UILabel = {
        let label = UILabel()
        label.text = "post"
        label.textAlignment = .center
        return label
    }()
    
    // 팔로워 레이블
    private lazy var followerLabel : UILabel = {
        let label = UILabel()
        label.text = "follower"
        label.textAlignment = .center
        return label
    }()
    
    // 팔로잉 레이블
    private lazy var followingLabel : UILabel = {
        let label = UILabel()
        label.text = "following"
        label.textAlignment = .center
        return label
    }()
    
    // 유저 이름 레이블
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "박상우"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    // 유저 설명 레이블
    private lazy var userDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer 🍎"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // 유저 링크 레이블
    private lazy var userLinkLabel: UILabel = {
        let label = UILabel()
        label.text = "https://velog.io/@danjychchi"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.061, green: 0.274, blue: 0.492, alpha: 1)
        return label
    }()
    
    // 팔로우 버튼
    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = UIColor(red: 0.22, green: 0.596, blue: 0.953, alpha: 1)
        button.layer.cornerRadius = 4
        return button
    }()
    
    // 메세지 버튼
    private lazy var messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Message", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    // 더보기 버튼
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .darkGray
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    // 내비게이션 바
    // 내비게이션 바탕뷰
    private lazy var navBarView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
       return view
    }()
    
    // 구분선
    private lazy var divideLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    // 격자 아이콘
    private lazy var gridButtonImage: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "Grid.png")
        view.image = image
        return view
    }()
    
    // 버튼 밑줄
    private lazy var highlightLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    // 컬렉션 뷰
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2 // 수직 간격
        layout.minimumInteritemSpacing = -8 // 수평 간격
        let itemWidth = (view.frame.width - 2 * layout.minimumInteritemSpacing - 20) / 3 // 3 x 3 그리드로 조절
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth) // 아이템 크기 설정
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    // 탭 바
    private lazy var tabBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // 사람 아이콘
    private lazy var humanIcon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "person.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageView.image = image
        return imageView
    }()
    
    // MARK: - 스택 뷰
    
    // 이름 메뉴바 스택뷰
    private lazy var barStackView : UIStackView = {
        let stview = UIStackView(arrangedSubviews: [cancelButton, userIdLabel, menuButton])
        stview.axis = .horizontal
        stview.distribution = .equalCentering
        stview.alignment = .center
        return stview
    }()
    
    // 포스트 숫자 레이블과 포스트 레이블 스택뷰
    private lazy var postStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [postNumLabel, postLabel])
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.spacing = -40
        return stview
    }()
    
    // 팔로워 숫자 레이블과 팔로워 레이블 스택뷰
    private lazy var followerStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [followerNumLabel, followerLabel])
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.spacing = -40
        return stview
    }()
    
    // 팔로워 숫자 레이블과 팔로워 레이블 스택뷰
    private lazy var followingStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [followingNumLabel, followingLabel])
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.spacing = -40
        return stview
    }()
    
    // 포스트 스택 뷰, 팔로워 스택 뷰, 팔로잉 스택 뷰를 묶은 스택 뷰
    private lazy var userFollowInfoStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [postStackView, followerStackView, followingStackView])
        stview.axis = .horizontal
        stview.distribution = .fillEqually
        return stview
    }()
    
    // 유저 이름, 유저 설명, 유저 링크 레이블을 묶음 스택 뷰
    private lazy var userInfoStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [userNameLabel, userDescriptionLabel, userLinkLabel])
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.spacing = 2
        return stview
    }()
    
    // 팔로우, 메세지, 더보기 버튼을 묶은 스택 뷰
    private lazy var activityStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [followButton, messageButton, moreButton])
        stview.axis = .horizontal
        stview.distribution = .fillProportionally
        stview.spacing = 8
        return stview
    }()
    

    // MARK: - 여백 뷰
    // 여백 뷰
    private let space1: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let space2: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        collectionView.register(CustomImageCollectionViewCell.self, forCellWithReuseIdentifier: "CustomImageCollectionViewCell")

    }
    
    // MARK: - UI AutoLayout 설정
    private func setupUI() {

        
        view.addSubview(profileView)
        profileView.addSubview(barStackView)
        profileView.addSubview(profileImageView)
        profileView.addSubview(userFollowInfoStackView)
        profileView.addSubview(userInfoStackView)
        profileView.addSubview(activityStackView)
        profileView.addSubview(navBarView)
        navBarView.addSubview(divideLine)
        navBarView.addSubview(gridButtonImage)
        navBarView.addSubview(highlightLine)
        profileView.addSubview(collectionView)
        profileView.addSubview(tabBarView)
        tabBarView.addSubview(humanIcon)
        
        
        // 바탕 뷰
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 상단 바 스택뷰
        barStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(54)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        // 유저의 포스트, 팔로워, 팔로잉을 담은 스택뷰
        userFollowInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(barStackView.snp.bottom).offset(14)
            make.left.equalTo(profileImageView.snp.right).offset(14)
            make.right.equalTo(-14)
            make.centerY.equalTo(profileImageView)
        }
        
        // 유저 정보를 묶은 스택 뷰
        userInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(14)
            make.left.equalTo(15)
        }
        
        // 팔로우, 메세지, 더보기 버튼을 묶은 스택 뷰
        activityStackView.snp.makeConstraints { make in
            make.top.equalTo(userInfoStackView.snp.bottom).offset(11)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        // 프로필 이미지 뷰
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(barStackView.snp.bottom).offset(14)
            make.width.height.equalTo(88)
            make.left.equalTo(14)
        }
        
        // 내비게이션 바탕 뷰
        navBarView.snp.makeConstraints { make in
            make.top.equalTo(activityStackView.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.left.right.equalToSuperview()
        }
        
        divideLine.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
        }
        
        gridButtonImage.snp.makeConstraints { make in
            make.bottom.equalTo(highlightLine.snp.top).offset(-8)
            make.height.width.equalTo(22.5)
            make.centerX.equalTo(highlightLine)
        }
        
        highlightLine.snp.makeConstraints { make in
            make.bottom.equalTo(navBarView.snp.bottom).offset(1)
            make.height.equalTo(1)
            make.width.equalTo(140)
            make.left.equalToSuperview().dividedBy(3)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(navBarView.snp.bottom).offset(3)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(tabBarView.snp.top)
        }
        
        tabBarView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(10)
            make.height.equalTo(85)
            make.left.right.equalToSuperview()
        }
        
        humanIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tabBarView.snp.top).offset(19)
            make.width.height.equalTo(25)
        }
        
        // 메뉴 버튼 뷰
        menuButton.snp.makeConstraints { make in
            make.width.equalTo(21)
        }
        
        // 더보기 버튼
        moreButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        // 팔로우 버튼
        followButton.snp.makeConstraints { make in
            make.width.equalTo(messageButton)
        }
        //        // space
        //        space1.snp.makeConstraints { make in
        //            make.width.equalTo(0)
        //        }
        //        space2.snp.makeConstraints { make in
        //            make.width.equalTo(0)
        //        }
    }
    
    // MARK: - 버튼 메서드
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// 데이터 소스 및 델리게이트 메서드 구현
extension ProfileDesignViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(imageModels.count)
        return imageModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomImageCollectionViewCell", for: indexPath) as? CustomImageCollectionViewCell else {
            fatalError("커스텀 셀을 재사용할 수 없습니다.")
        }
        
        let imageName = imageModels[indexPath.item].imageName
        cell.setImage(UIImage(named: imageName))
        
        return cell
    }
}



// MARK: - SwiftUI를 활용한 미리보기
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
