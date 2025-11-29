//
//  BMICalculatorViewController.swift
//  Practica1
//
//  Created by Anthony on 28/11/25.
//

import UIKit

class BMICalculatorViewController: UIViewController {
    
    // MARK: - Properties
    private var selectedCategory: BMICategory = .normal
    private var currentBMI: Double = 0.0
    
    enum BMICategory {
        case underweight
        case normal
        case overweight
        case obese
        
        var title: String {
            switch self {
            case .underweight: return "Bajo Peso"
            case .normal: return "Peso Normal"
            case .overweight: return "Sobrepeso"
            case .obese: return "Obesidad"
            }
        }
        
        var color: UIColor {
            switch self {
            case .underweight: return .systemYellow
            case .normal: return .systemGreen
            case .overweight: return .systemOrange
            case .obese: return .systemRed
            }
        }
    }
    
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calcula tu IMC"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Introduce tus datos a continuación para calcular tu índice de masa corporal."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categorySelectorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var categoryButtons: [UIButton] = []
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Peso (kg)"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ej: 70"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Altura (cm)"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ej: 170"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let resultContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let resultTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tu resultado de IMC"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resultValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resultCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "---"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calcular IMC", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupCategoryButtons()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        title = "Calculadora IMC"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(categorySelectorView)
        contentView.addSubview(weightLabel)
        contentView.addSubview(weightTextField)
        contentView.addSubview(heightLabel)
        contentView.addSubview(heightTextField)
        contentView.addSubview(resultContainerView)
        contentView.addSubview(calculateButton)
        
        resultContainerView.addSubview(resultTitleLabel)
        resultContainerView.addSubview(resultValueLabel)
        resultContainerView.addSubview(resultCategoryLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            categorySelectorView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30),
            categorySelectorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categorySelectorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            categorySelectorView.heightAnchor.constraint(equalToConstant: 100),
            
            weightLabel.topAnchor.constraint(equalTo: categorySelectorView.bottomAnchor, constant: 30),
            weightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 8),
            weightTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            weightTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            weightTextField.heightAnchor.constraint(equalToConstant: 44),
            
            heightLabel.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            heightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            heightTextField.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 8),
            heightTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heightTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            heightTextField.heightAnchor.constraint(equalToConstant: 44),
            
            resultContainerView.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 30),
            resultContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            resultContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            resultContainerView.heightAnchor.constraint(equalToConstant: 150),
            
            resultTitleLabel.topAnchor.constraint(equalTo: resultContainerView.topAnchor, constant: 20),
            resultTitleLabel.leadingAnchor.constraint(equalTo: resultContainerView.leadingAnchor, constant: 20),
            resultTitleLabel.trailingAnchor.constraint(equalTo: resultContainerView.trailingAnchor, constant: -20),
            
            resultValueLabel.centerYAnchor.constraint(equalTo: resultContainerView.centerYAnchor),
            resultValueLabel.centerXAnchor.constraint(equalTo: resultContainerView.centerXAnchor),
            
            resultCategoryLabel.bottomAnchor.constraint(equalTo: resultContainerView.bottomAnchor, constant: -20),
            resultCategoryLabel.leadingAnchor.constraint(equalTo: resultContainerView.leadingAnchor, constant: 20),
            resultCategoryLabel.trailingAnchor.constraint(equalTo: resultContainerView.trailingAnchor, constant: -20),
            
            calculateButton.topAnchor.constraint(equalTo: resultContainerView.bottomAnchor, constant: 30),
            calculateButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            calculateButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            calculateButton.heightAnchor.constraint(equalToConstant: 55),
            calculateButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupCategoryButtons() {
        let categories: [(BMICategory, String)] = [
            (.underweight, "Bajo\nPeso"),
            (.normal, "Normal"),
            (.overweight, "Sobre\nPeso"),
            (.obese, "Obesidad")
        ]
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, (category, title)) in categories.enumerated() {
            let button = createCategoryButton(title: title, category: category, tag: index)
            categoryButtons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        categorySelectorView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: categorySelectorView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: categorySelectorView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: categorySelectorView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: categorySelectorView.bottomAnchor)
        ])
        
        updateCategorySelection()
    }
    
    private func createCategoryButton(title: String, category: BMICategory, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.tag = tag
        button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    private func setupActions() {
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        let categories: [BMICategory] = [.underweight, .normal, .overweight, .obese]
        selectedCategory = categories[sender.tag]
        updateCategorySelection()
    }
    
    @objc private func calculateButtonTapped() {
        guard let weightText = weightTextField.text, !weightText.isEmpty,
              let heightText = heightTextField.text, !heightText.isEmpty else {
            showAlert(title: "Error", message: "Por favor ingresa el peso y la altura.")
            return
        }
        
        guard let weight = Double(weightText), weight > 0 else {
            showAlert(title: "Error", message: "Por favor ingresa un peso válido.")
            return
        }
        
        guard let heightCm = Double(heightText), heightCm > 0 else {
            showAlert(title: "Error", message: "Por favor ingresa una altura válida.")
            return
        }
        
        let heightM = heightCm / 100.0
        let bmi = weight / (heightM * heightM)
        
        currentBMI = bmi
        
        let category = getBMICategory(bmi: bmi)
        
        resultValueLabel.text = String(format: "%.1f", bmi)
        resultCategoryLabel.text = category.title
        resultValueLabel.textColor = category.color
        
        let resultVC = BMIResultViewController()
        resultVC.bmiValue = bmi
        resultVC.bmiCategory = category
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    private func getBMICategory(bmi: Double) -> BMICategory {
        if bmi < 18.5 {
            return .underweight
        } else if bmi >= 18.5 && bmi <= 24.9 {
            return .normal
        } else if bmi >= 25 && bmi <= 29.9 {
            return .overweight
        } else {
            return .obese
        }
    }
    
    private func updateCategorySelection() {
        let categories: [BMICategory] = [.underweight, .normal, .overweight, .obese]
        
        for (index, button) in categoryButtons.enumerated() {
            let category = categories[index]
            if category == selectedCategory {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
                button.layer.borderColor = UIColor.systemBlue.cgColor
            } else {
                button.backgroundColor = .white
                button.setTitleColor(.systemBlue, for: .normal)
                button.layer.borderColor = UIColor.systemGray4.cgColor
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
