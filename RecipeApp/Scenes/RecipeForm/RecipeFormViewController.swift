import UIKit

protocol RecipeFormDisplaying: AnyObject {
    func displaySomething()
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
    
    private lazy var titleTextField: FormTextField = {
        let textField = FormTextField()
        textField.placeholder = "Título"
        return textField
    }()
    
    private lazy var descriptionTextView: FormTextView = {
        let textView = FormTextView()
        textView.text = "Adicione uma descrição."
        textView.font = .preferredFont(forTextStyle: .body)
        return textView
    }()
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("Selecione uma categoria", for: .normal)
        button.addTarget(self, action: #selector(displayCategories), for: .touchUpInside)
        return button
    }()
    
    private lazy var dificultyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("Selecione uma dificuldade", for: .normal)
        button.addTarget(self, action: #selector(displayDificulties), for: .touchUpInside)
        return button
    }()
    
    private lazy var preparationTimeTextField: FormTextField = {
        let textField = FormTextField()
        textField.leftViewMode = .always
        textField.placeholder = "0"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var preparationTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Tempo de preparação (em minutos):"
        label.textColor = .darkGray
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var preparationTimeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [preparationTimeLabel, preparationTimeTextField])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var ingredientsTextView: FormTextView = {
        let textView = FormTextView()
        textView.text = "Ingredientes"
        textView.font = .preferredFont(forTextStyle: .body)
        return textView
    }()
    
    private lazy var stepsTextView: FormTextView = {
        let textView = FormTextView()
        textView.text = "Passos."
        textView.font = .preferredFont(forTextStyle: .body)
        return textView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleTextField,
            descriptionTextView,
            categoryButton,
            dificultyButton,
            preparationTimeStackView,
            ingredientsTextView,
            stepsTextView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = false
        return scrollview
    }()
    
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
        scrollView.addSubview(mainStackView)
        view.addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.width.bottom.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(16)
        }
        
        titleTextField.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.height.equalTo(96)
        }
        
        categoryButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        dificultyButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        preparationTimeTextField.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        ingredientsTextView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        stepsTextView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
    }

    func configureViews() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc
    private func displayCategories() {
        let alert = UIAlertController(title: "Categorias", message: nil, preferredStyle: .actionSheet)
        let categories = ["Prato principal", "Bebidas", "Doces e sobremesas"]
        for c in categories {
            let action = UIAlertAction(title: c, style: .default) { [weak self] _ in
                self?.interactor.set(category: RecipeCategory(id: 0, name: ""))
                self?.categoryButton.setTitle("Categoria: " + c, for: .normal)
            }
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
    
    @objc
    private func displayDificulties() {
        let alert = UIAlertController(title: "Dificuldades", message: nil, preferredStyle: .actionSheet)
        let dificults = ["Fácil", "Moderada", "Difícil"]
        for c in dificults {
            let action = UIAlertAction(title: c, style: .default) { [weak self] _ in
                //self?.interactor.set(category: RecipeDifficulty(ID: 1, Name: ""))
                self?.dificultyButton.setTitle("Dificuldade: " + c, for: .normal)
            }
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}

// MARK: - RecipeFormDisplaying
extension RecipeFormViewController: RecipeFormDisplaying {
    func displaySomething() {
        title = "Nova receita"
    }
}
