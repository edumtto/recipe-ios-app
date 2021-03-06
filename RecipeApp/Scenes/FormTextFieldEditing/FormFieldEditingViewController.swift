import UIKit
import SnapKit

protocol FormTextFieldEditingDisplaying: AnyObject {
    func displayEditingField(viewModel: FormTextFieldEditingViewModel)
}

private extension FormTextFieldEditingViewController.Layout {
    //example
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class FormTextFieldEditingViewController: UIViewController {
    fileprivate enum Layout { }

    private let interactor: FormTextFieldEditingInteracting
    
    private lazy var textField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .white
        //view.keyboardType = .asciiCapable
        return view
    }()
    
    private lazy var okButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(didTapOkButton))
    
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
        view.addSubview(textField)
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
    }

    private func configureViews() {
        view.backgroundColor = .systemGroupedBackground
        navigationItem.rightBarButtonItem = okButton
    }
    
    @objc
    private func didTapOkButton() {
        interactor.didConfirm(value: textField.text)
    }
}

// MARK: - FormTextFieldEditingDisplaying
extension FormTextFieldEditingViewController: FormTextFieldEditingDisplaying {
    func displayEditingField(viewModel: FormTextFieldEditingViewModel) {
        title = viewModel.navigationTitle
        textField.text = viewModel.fieldValue
        textField.keyboardType = viewModel.keyboardType
    }
}
