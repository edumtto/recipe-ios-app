import UIKit
import SnapKit

final class RecipeDetailStepsView: UIView {
    private lazy var ingredientsLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Passos"
        return label
    }()
    
    private lazy var ingredientsTextView: UITextView = {
        let view = UITextView()
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        view.adjustsFontForContentSizeCategory = true
        view.isEditable = false
        view.isScrollEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        addSubview(ingredientsLabel)
        addSubview(ingredientsTextView)
    }
    
    private func setupConstraints() {
        ingredientsLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        ingredientsTextView.snp.makeConstraints {
            $0.top.equalTo(ingredientsLabel.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureViews() {
        backgroundColor = .clear
    }
    
    func display(steps: [String]) {
        let stepsList = steps.map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
        
        var stepsText = ""
        for (index, step) in stepsList.enumerated() {
            let lineBreak = index != steps.count - 1 ? "\n" : ""
            stepsText.append("\(index + 1) - \(step)\(lineBreak)")
        }
        ingredientsTextView.text = stepsText
    }
}

