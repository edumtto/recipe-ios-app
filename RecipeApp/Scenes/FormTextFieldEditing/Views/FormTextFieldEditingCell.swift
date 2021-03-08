import Foundation
import UIKit

final class FormTextFieldEditingCell: UITableViewCell {
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .body)
        textField.textColor = .darkGray
        textField.addTarget(self, action: #selector(didChangeFieldValue), for: .editingChanged)
        return textField
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textColor = .darkGray
        textView.delegate = self
        return textView
    }()
        
    var viewModel: FormTextFieldEditingViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            switch viewModel.fieldDisplayType {
            case .shortText:
                textField.text = viewModel.fieldValue
                textField.keyboardType = viewModel.keyboardType
                configureOneLineTextField()
            default:
                textView.text = viewModel.fieldValue
                textView.keyboardType = viewModel.keyboardType
                configureMultilineTextField()
            }
        }
    }
    
    var didChangeValue: ((String?) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        

        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureOneLineTextField() {
        contentView.addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
    }
    
    private func configureMultilineTextField() {
        contentView.addSubview(textView)

        textView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(80)
        }
    }

    private func configureViews() {
        textLabel?.isHidden = true
        detailTextLabel?.isHidden = true
        backgroundColor = .white
        contentView.isUserInteractionEnabled = true
    }
    
    @objc
    private func didChangeFieldValue() {
        didChangeValue?(textField.text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        openKeyboard()
    }
    
    func openKeyboard() {
        guard let viewModel = viewModel else { return }
        switch viewModel.fieldDisplayType {
        case .shortText:
            textField.becomeFirstResponder()
        default:
            textView.becomeFirstResponder()
        }
        
    }
}

extension FormTextFieldEditingCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        didChangeValue?(textView.text)
    }
}
