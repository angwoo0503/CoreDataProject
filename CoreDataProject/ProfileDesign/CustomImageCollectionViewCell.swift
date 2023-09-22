import UIKit

class CustomImageCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    func setImage(_ image: UIImage?) {
        imageView.image = image
    }

    private func setupImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupImageView()
    }
}
