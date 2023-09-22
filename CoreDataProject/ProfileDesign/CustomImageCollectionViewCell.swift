import UIKit

class CustomImageCollectionViewCell: UICollectionViewCell {
    
    // 이미지를 표시할 이미지 뷰를 선언합니다.
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    // 이미지를 설정하는 메서드를 정의합니다.
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }

    // 이미지 뷰의 Auto Layout 설정을 수행하는 메서드를 정의합니다.
    private func setupImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // 셀이 재사용될 때 호출되는 메서드입니다.
    override func prepareForReuse() {
        super.prepareForReuse()
        // 셀이 재사용될 때 이미지 초기화 또는 재설정 작업을 수행합니다.
        imageView.image = nil
    }
    
    // 초기화 메서드 - frame을 사용하는 초기화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
    }

    // 초기화 메서드 - Interface Builder에서 사용하는 초기화 메서드
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupImageView()
    }
}
