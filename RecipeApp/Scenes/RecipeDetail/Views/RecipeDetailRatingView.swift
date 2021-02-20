import UIKit

final class RecipeDetailRatingView: UIView {
    private lazy var starIcon: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "star"))
        view.contentMode = .scaleAspectFit
        view.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return view
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
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
        addSubview(starIcon)
        addSubview(ratingLabel)
    }
    
    private func setupConstraints() {
        starIcon.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
            $0.width.greaterThanOrEqualTo(32)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(starIcon.snp.bottom).offset(2)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureViews() {
        backgroundColor = .clear
    }
    
    func display(rating: Int) {
        ratingLabel.text = String(rating)
    }
}
