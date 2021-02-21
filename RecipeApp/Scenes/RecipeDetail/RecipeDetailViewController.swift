import UIKit
import SDWebImage

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
    
    private lazy var headerView = RecipeDetailHeaderView(frame: .zero)
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var groupedInfoView = RecipeDetailGroupedInfoView()
    
    private lazy var ingredientsView = RecipeDetailIngredientsView()
    private lazy var stepsView = RecipeDetailStepsView()
    
    private lazy var separatorView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "separator0.pdf"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                headerView,
                imageView,
                groupedInfoView,
                separatorView,
                ingredientsView,
                stepsView
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var scrollView = UIScrollView()
    
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
        scrollView.addSubview(contentStackView)
        view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.height.equalTo(imageView.snp.width).multipliedBy(2.0 / 3.0)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.bottom.equalToSuperview()
            $0.width.equalToSuperview().inset(16)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.width.bottom.equalToSuperview()
        }
    }

    private func configureViews() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = editRecipeButton
    }
    
    @objc
    private func editRecipe() {
        interactor.editRecipe()
    }
}

// MARK: - RecipeDetailDisplaying
extension RecipeDetailViewController: RecipeDetailDisplaying {
    func display(recipe: Recipe) {
        headerView.display(recipe: recipe)
        
        if recipe.imageUrl.isEmpty {
            imageView.isHidden = true
        } else {
            imageView.sd_setImage(with: URL(string: recipe.imageUrl), completed: nil)
        }
        
        groupedInfoView.display(recipe: recipe)
        ingredientsView.display(ingredients: recipe.ingredients)
        stepsView.display(steps: recipe.steps)
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
