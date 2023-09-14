import UIKit
import SwiftUI
import SnapKit

class ViewController: UIViewController {
    
    
    
    private let profileButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("프로필", for: .normal)
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(profileButton)
        profileButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
    }
    
    @objc func profileButtonTapped() {
        let profileDesignViewController = ProfileDesignViewController()
        self.present(profileDesignViewController, animated: true)
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
