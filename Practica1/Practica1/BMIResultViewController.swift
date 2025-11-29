//
//  BMIResultViewController.swift
//  Practica1
//
//  Created by Anthony on 28/11/25.
//

import UIKit

class BMIResultViewController: UIViewController {
    
    // MARK: - Properties
    var bmiValue: Double = 0.0
    var bmiCategory: BMICalculatorViewController.BMICategory = .normal
    
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
    
    private let resultTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tu IMC es"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bmiValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.font = UIFont.boldSystemFont(ofSize: 72)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Peso Normal"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categorySelectorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var categoryButtons: [UIButton] = []
    
    private let explanationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "¿Qué significa tu IMC?"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let explanationTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .darkGray
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Guardar Resultado", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let recalculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Volver a Calcular", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupCategoryButtons()
        updateUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        title = "Resultado IMC"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(resultTitleLabel)
        contentView.addSubview(bmiValueLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(categorySelectorView)
        contentView.addSubview(explanationTitleLabel)
        contentView.addSubview(explanationTextView)
        contentView.addSubview(saveButton)
        contentView.addSubview(recalculateButton)
        
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
            
            resultTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            resultTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            resultTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            bmiValueLabel.topAnchor.constraint(equalTo: resultTitleLabel.bottomAnchor, constant: 10),
            bmiValueLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: bmiValueLabel.bottomAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            categorySelectorView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 30),
            categorySelectorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categorySelectorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            categorySelectorView.heightAnchor.constraint(equalToConstant: 100),
            
            explanationTitleLabel.topAnchor.constraint(equalTo: categorySelectorView.bottomAnchor, constant: 30),
            explanationTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            explanationTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            explanationTextView.topAnchor.constraint(equalTo: explanationTitleLabel.bottomAnchor, constant: 15),
            explanationTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            explanationTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            explanationTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            
            saveButton.topAnchor.constraint(equalTo: explanationTextView.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55),
            
            recalculateButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 15),
            recalculateButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recalculateButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recalculateButton.heightAnchor.constraint(equalToConstant: 55),
            recalculateButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupCategoryButtons() {
        let categories: [String] = ["Bajo\nPeso", "Normal", "Sobre\nPeso", "Obesidad"]
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, title) in categories.enumerated() {
            let button = createCategoryButton(title: title, tag: index)
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
    }
    
    private func createCategoryButton(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.tag = tag
        button.isUserInteractionEnabled = false
        return button
    }
    
    private func setupActions() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        recalculateButton.addTarget(self, action: #selector(recalculateButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Update UI
    private func updateUI() {
        bmiValueLabel.text = String(format: "%.1f", bmiValue)
        categoryLabel.text = bmiCategory.title
        bmiValueLabel.textColor = bmiCategory.color
        
        explanationTextView.text = getExplanationText(for: bmiCategory)
        
        updateCategorySelection()
    }
    
    private func updateCategorySelection() {
        typealias Category = BMICalculatorViewController.BMICategory
        let categories: [Category] = [.underweight, .normal, .overweight, .obese]
        
        for (index, button) in categoryButtons.enumerated() {
            let category = categories[index]
            if category == bmiCategory {
                button.backgroundColor = bmiCategory.color
                button.setTitleColor(.white, for: .normal)
                button.layer.borderColor = bmiCategory.color.cgColor
            } else {
                button.backgroundColor = .white
                button.setTitleColor(.systemGray, for: .normal)
                button.layer.borderColor = UIColor.systemGray4.cgColor
            }
        }
    }
    
    private func getExplanationText(for category: BMICalculatorViewController.BMICategory) -> String {
        switch category {
        case .underweight:
            return "Tu IMC está en el rango de Bajo Peso. Esto puede indicar que no estás recibiendo suficientes nutrientes o calorías. Es recomendable consultar con un profesional de la salud para evaluar tu dieta y estado de salud general."
        case .normal:
            return "Tu IMC está en el rango de Peso Normal. Mantener un peso saludable reduce el riesgo de enfermedades crónicas como diabetes, enfermedades cardíacas y ciertos tipos de cáncer. Continúa con una alimentación equilibrada y actividad física regular."
        case .overweight:
            return "Tu IMC está en el rango de Sobrepeso. Esto significa que tienes más peso del recomendado para tu altura. Considera adoptar hábitos más saludables como una dieta balanceada y ejercicio regular para reducir el riesgo de problemas de salud."
        case .obese:
            return "Tu IMC está en el rango de Obesidad. Esto aumenta significativamente el riesgo de desarrollar problemas de salud graves como diabetes tipo 2, enfermedades cardíacas, presión arterial alta y otros problemas. Es importante consultar con un profesional de la salud para crear un plan personalizado."
        }
    }
    
    // MARK: - Actions
    @objc private func saveButtonTapped() {
        let alert = UIAlertController(
            title: "Resultado Guardado",
            message: "Tu resultado de IMC ha sido guardado exitosamente.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func recalculateButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
