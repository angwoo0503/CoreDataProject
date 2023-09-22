import UIKit
import SnapKit

class ToDoTableViewCell: UITableViewCell {
    

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .gray
        return label
    }()
    
    let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(toggleSwitch)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8.0)
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalTo(toggleSwitch.snp.leading).offset(-8.0)
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView).offset(-16.0)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalTo(toggleSwitch.snp.leading).offset(-8.0)
            make.bottom.equalTo(contentView).offset(-8.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)가 구현되지 않음")
    }
    

    func configure(with title: String, date: String, isCompleted: Bool) {
        titleLabel.text = title
        dateLabel.text = date
        toggleSwitch.isOn = isCompleted
    }
}
