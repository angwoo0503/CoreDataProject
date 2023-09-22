
import UIKit
import SwiftUI
import SnapKit

class ProfileViewController: UIViewController {
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.userName
        return label
    }()
    
    private lazy var userAgeLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.userAge
        return label
    }()
    
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)가 구현되지 않음..")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(userNameLabel)
        view.addSubview(userAgeLabel)
        
        userNameLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        userAgeLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
}

// SwiftUI 미리보기
struct ProfileViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ProfileViewControllerReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct ProfileViewControllerReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let user = users.first!
        let viewModel = ProfileViewModel(user: user)
        let profileViewController = ProfileViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: profileViewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    typealias UIViewControllerType = UIViewController
}
