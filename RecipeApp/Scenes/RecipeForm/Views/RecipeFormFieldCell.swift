import Foundation
import UIKit

final class RecipeFormFieldCell: UITableViewCell, RecipeFormCell {
    private lazy var fieldLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var fieldValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .darkGray
        return label
    }()
        
    var formField: RecipeFormField? {
        didSet {
            guard let field = formField else { return }
            fieldLabel.text = field.name
            fieldValue.text = field.formatedValue
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(fieldLabel)
        contentView.addSubview(fieldValue)
    }
    
    private func setupConstraints() {
        fieldLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        fieldValue.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(fieldLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureViews() {
        textLabel?.isHidden = true
        detailTextLabel?.isHidden = true
        accessoryType = .disclosureIndicator
        backgroundColor = .white
    }
}
