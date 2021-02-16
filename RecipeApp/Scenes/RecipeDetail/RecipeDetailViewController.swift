import UIKit

protocol RecipeDetailDisplaying: AnyObject {
    func display(recipe: Recipe)
    func display(errorTitle: String, message: String)
}

private extension RecipeDetailViewController.Layout {
    //example
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class RecipeDetailViewController:UIViewController {
    fileprivate enum Layout { }
    
    private let interactor: RecipeDetailInteracting
    
    private lazy var editRecipeButton = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(editRecipe))
    
    private lazy var titleLabel: UILabel = {
       let label  = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label  = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
    init(interactor: RecipeDetailInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViewHierarchy()
        setupConstraints()
        configureViews()
        
        interactor.fetchRecipe()
    }

    private func buildViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureViews() {
        view.backgroundColor = .white
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = editRecipeButton
    }
    
    @objc
    private func editRecipe() {
        
    }
}

// MARK: - RecipeDetailDisplaying
extension RecipeDetailViewController: RecipeDetailDisplaying {
    func display(recipe: Recipe) {
        titleLabel.text = recipe.title
        descriptionLabel.text = recipe.description
    }
    
    func display(errorTitle: String, message: String) {
        let alertController = UIAlertController(title: errorTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
