import UIKit
import SnapKit

protocol RecipeListDisplaying: AnyObject {
    func displayLoadingAnimation()
    func hideLoadingAnimation()
    func display(recipes: [RecipePreview])
    func display(errorTitle: String, message: String)
}

private extension RecipeListViewController.Layout {
    //example
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class RecipeListViewController: UIViewController {
    fileprivate enum Layout { }
    
    private let interactor: RecipeListInteractor
    
    private lazy var addRecipeButton: UIBarButtonItem = {
        let action = UIAction { _ in
            self.interactor.openAddRecipeForm()
        }
        return UIBarButtonItem(systemItem: .add, primaryAction: action, menu: nil)
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
//        tableView.estimatedRowHeight = .infinity
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeListCell.self, forCellReuseIdentifier: RecipeListCell.reuseIdentifier)
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    private var recipePreviews = [RecipePreview]()
    
    init(interactor: RecipeListInteractor) {
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
        
        interactor.fetchRecipeList()
    }

    private func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureViews() {
        title = "Receitas"
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.rightBarButtonItem = addRecipeButton
    }
    
    @objc
    private func refresh() {
        interactor.fetchRecipeList()
    }
}

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor.openRecipeDescription(id: recipePreviews[indexPath.row].id)
    }
}

extension RecipeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipePreviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeListCell.reuseIdentifier)
        guard let recipeCell = cell as? RecipeListCell else {
            return UITableViewCell()
        }
        recipeCell.configure(title: recipePreviews[indexPath.row].title)
        return recipeCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recipePreviews.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

// MARK: - RecipeListDisplaying
extension RecipeListViewController: RecipeListDisplaying {
    func displayLoadingAnimation() {
        if refreshControl.isRefreshing {
            return
        }
        refreshControl.beginRefreshing()
    }
    
    func hideLoadingAnimation() {
        refreshControl.endRefreshing()
    }
    
    func display(recipes: [RecipePreview]) {
        recipePreviews = recipes
        tableView.reloadData()
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
