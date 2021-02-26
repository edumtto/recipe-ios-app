import UIKit

protocol RecipeFormDisplaying: AnyObject {
    func displayFormFields(_ formFields: [RecipeFormField])
}

private extension RecipeFormViewController.Layout {
    //example
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class RecipeFormViewController: UIViewController {
    fileprivate enum Layout { }
    
    private let interactor: RecipeFormInteracting
    
    private let cellReuseIdentifier = "formFieldCell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FormFieldCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        return tableView
    }()
    
    private var recipeFormFields = [RecipeFormField]()
    
    init(interactor: RecipeFormInteracting) {
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
        
        interactor.populateView()
    }

    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureViews() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        title = "Nova receita"
    }
}

extension RecipeFormViewController: UITableViewDelegate {
    
}

extension RecipeFormViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeFormFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else {
            return UITableViewCell(style: .value1, reuseIdentifier: nil)
        }
        cell.textLabel?.text = recipeFormFields[indexPath.row].type.rawValue
        cell.detailTextLabel?.text = recipeFormFields[indexPath.row].value
        return cell
    }
}

// MARK: - RecipeFormDisplaying
extension RecipeFormViewController: RecipeFormDisplaying {
    func displayFormFields(_ formFields: [RecipeFormField]) {
        recipeFormFields = formFields
        tableView.reloadData()
    }
}
