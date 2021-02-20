import UIKit

final class RecipeDetailGroupedInfoView: UIView {
    private lazy var groupedInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
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
        addSubview(groupedInfoLabel)
    }
    
    private func setupConstraints() {
        groupedInfoLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureViews() {
        backgroundColor = .clear
    }
    
    func display(recipe: Recipe) {
        let infos = [
            recipe.category.name,
            recipe.difficulty.name,
            "\(recipe.serving) porções",
            "\(recipe.accessCount) acessos"
        ]
        groupedInfoLabel.text = infos.joined(separator: " \u{2022} ")
    }
}
