import UIKit
import SnapKit

protocol FormTextFieldEditingDisplaying: AnyObject {
    func displayEditingField(viewModel: FormTextFieldEditingViewModel)
}

final class FormTextFieldEditingViewController: UIViewController {
    fileprivate enum Layout { }

    private let interactor: FormTextFieldEditingInteracting
    
    private let cellReuseIdentifier = String(describing: FormTextFieldEditingCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FormTextFieldEditingCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        return tableView
    }()
    
    private lazy var okButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(didTapOkButton))
    
    private var fieldViewModel: FormTextFieldEditingViewModel?
    
    init(interactor: FormTextFieldEditingInteracting) {
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
        
        interactor.configureView()
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
        view.backgroundColor = .systemGroupedBackground
        navigationItem.rightBarButtonItem = okButton
    }
    
    @objc
    private func didTapOkButton() {
        interactor.didConfirm(value: fieldViewModel?.fieldValue)
    }
}

extension FormTextFieldEditingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
    }
}

extension FormTextFieldEditingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? FormTextFieldEditingCell else {
            return UITableViewCell(style: .value1, reuseIdentifier: nil)
        }
        cell.viewModel = fieldViewModel
        cell.didChangeValue = { [weak self] newValue in
            self?.fieldViewModel?.fieldValue = newValue
        }
        cell.openKeyboard()
        return cell
    }
    
    
}

// MARK: - FormTextFieldEditingDisplaying
extension FormTextFieldEditingViewController: FormTextFieldEditingDisplaying {
    func displayEditingField(viewModel: FormTextFieldEditingViewModel) {
        title = viewModel.navigationTitle
        fieldViewModel = viewModel
        tableView.reloadData()
//        textField.keyboardType = viewModel.keyboardType
    }
}
