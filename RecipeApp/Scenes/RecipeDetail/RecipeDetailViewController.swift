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
    
    private lazy var contentView = UIView(frame: .zero)
    
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
        contentView.addSubview(headerView)
        contentView.addSubview(imageView)
        contentView.addSubview(groupedInfoView)
        contentView.addSubview(ingredientsView)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(2.0 / 3.0)
        }
        
        groupedInfoView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        ingredientsView.snp.makeConstraints {
            $0.top.equalTo(groupedInfoView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(16)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.width.bottom.equalToSuperview()
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
        headerView.display(recipe: recipe)
        imageView.sd_setImage(with: URL(string: recipe.imageUrl), completed: nil)
        groupedInfoView.display(recipe: recipe)
        ingredientsView.display(ingredients: recipe.ingredients)
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
