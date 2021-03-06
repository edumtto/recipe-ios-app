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
    
    private let cellReuseIdentifier = String(describing: RecipeFormFieldCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeFormFieldCell.self, forCellReuseIdentifier: cellReuseIdentifier)
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
        
        interactor.fetchFormSelectableValues()
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
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        title = "Nova receita"
    }
}

extension RecipeFormViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
        
        guard
            let cell = tableView.cellForRow(at: indexPath) as? RecipeFormCell,
            let formField = cell.formField
        else {
            return
        }
        interactor.editField(formField)
    }
}

extension RecipeFormViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeFormFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? RecipeFormFieldCell else {
            return UITableViewCell(style: .value1, reuseIdentifier: nil)
        }
        cell.formField = recipeFormFields[indexPath.row]
        return cell
    }
}
/*
extension RecipeFormViewController: RecipeFormCellDelegate {
    func didChangeValue(newValue: String?, fieldType: RecipeFormFieldType) {
        interactor.didEditField(newValue: newValue, type: fieldType)
    }
    
    func displaySelectableOptions(fieldType: RecipeFormFieldType, options: [RecipeSelectableValue]) {
        let actionSheet = UIAlertController(title: fieldType.rawValue, message: nil, preferredStyle: .actionSheet)
        
        options.forEach { option in
            let alertAction = UIAlertAction(title: option.name, style: .default) { [weak self] action in
                self?.didChangeValue(fieldType: fieldType, newValue: option.name)
            }
            actionSheet.addAction(alertAction)
        }
        
        let alertDismissAction = UIAlertAction(title: "Cancelar", style: .cancel) { action in
            actionSheet.dismiss(animated: true)
        }
        actionSheet.addAction(alertDismissAction)
        
        present(actionSheet, animated: true)
    }
}*/

// MARK: - RecipeFormDisplaying
extension RecipeFormViewController: RecipeFormDisplaying {
    func displayFormFields(_ formFields: [RecipeFormField]) {
        recipeFormFields = formFields
        tableView.reloadData()
    }
}
