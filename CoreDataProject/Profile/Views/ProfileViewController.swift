
import UIKit
import SwiftUI

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}

// MARK: - SwiftUI를 활용한 미리보기
struct ProfileViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ProfileViewControllerReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct ProfileViewControllerReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let profileViewController = ProfileViewController()
        return UINavigationController(rootViewController: profileViewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    typealias UIViewControllerType = UIViewController
}
