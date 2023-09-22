import UIKit
import SwiftUI
import SnapKit

class ViewController: UIViewController {
    
    
    
    private let profileDesignButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("프로필 디자인", for: .normal)
        button.addTarget(self, action: #selector(profileDesignButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let profileButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("프로필", for: .normal)
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let toDoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("TO DO", for: .normal)
        button.addTarget(self, action: #selector(toDoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(profileButton)
        view.addSubview(profileDesignButton)
        view.addSubview(toDoButton)
        
        profileButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        profileDesignButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileButton.snp.bottom).offset(12)
        }
        
        toDoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileDesignButton.snp.bottom).offset(12)
        }
        
    }
    
    @objc func profileDesignButtonTapped() {
        let profileDesignViewController = ProfileDesignViewController()
        profileDesignViewController.modalPresentationStyle = .fullScreen
        self.present(profileDesignViewController, animated: true)
    }
    
    @objc func profileButtonTapped() {

        let user = User(userName: "박상우", userAge: 25)
        
        let viewModel = ProfileViewModel(user: user)
        
        let profileViewController = ProfileViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @objc func toDoButtonTapped() {
        let toDoViewController = ToDoViewController()
        navigationController?.pushViewController(toDoViewController, animated: true)
    }
    
}


// SwiftUI를 활용한 미리보기
struct ViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ViewControllerReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct ViewControllerReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = ViewController()
        return UINavigationController(rootViewController: viewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    typealias UIViewControllerType = UIViewController
}
