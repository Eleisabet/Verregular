//
//  TrainViewController.swift
//  Verregular
//
//  Created by Elizaveta Potapova on 11/5/24.
//

import UIKit
import SnapKit

final class TrainViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var infinitiveLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pastSimpleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Simple"
        return label
    }()
    
    private lazy var participleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Participle"
        return label
    }()
    
    private lazy var pastSimpleTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.delegate = self
        return field
    }()
    
    private lazy var participleTextField: UITextField = {
        
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.setTitle("Skip".localized, for: .normal)
        button.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.setTitle("Check".localized, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        
        return button
    }()
    
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Properties
    private let edgeInsets = 30
    private let dataSource = IrregularVerbs.shared.selectedVerbs
    private var currentVerb: Verb? {
        guard dataSource.count > count else { return nil }
         return dataSource[count]
    }
    private var count = 0 {
        didSet {
            infinitiveLabel.text = currentVerb?.infinitive
            pastSimpleTextField.text = ""
            participleTextField.text = ""
            updateProgressLabel()
            
            checkButton.backgroundColor = .systemGray5
            checkButton.setTitle("Check".localized, for: .normal)
        }
    }
    
   
    private var score: Int = 0 {
        didSet {
            updateScoreLabel()
        }
    }
        
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Train verbs".localized
        setupUI()
        hideKeyboardWhenTappedAround()
        
        infinitiveLabel.text = dataSource.first?.infinitive
        updateProgressLabel()
        updateScoreLabel()
        
        // new
        updateProgressLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterForKeyboardNotification()
    }
    
    // MARK: - Private methods
    
    @objc
    private func skipAction() {
        count += 1
        
        pastSimpleTextField.text = ""
        participleTextField.text = ""
        
        checkButton.backgroundColor = .systemGray5
        checkButton.setTitle("Check".localized, for: .normal)
    }
    
    
    
    
    private func updateProgressLabel() {
        progressLabel.text = "\(count + 1) from \(dataSource.count)"
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "Score: \(score)"
    }
    @objc
    private func checkAction() {
        if checkAnswers() {
            
            score += 1
            // new
            print("Current score: \(score)")
            
            if currentVerb?.infinitive == dataSource.last?.infinitive {
                showScoreAlert()
                
            } else {
                count += 1
                
                checkButton.backgroundColor = .systemGray5
               
                checkButton.setTitle("Check".localized, for: .normal)
            }
        } else {
            checkButton.backgroundColor = .red
            checkButton.setTitle("Try again".localized, for: .normal)
        }
    }
    
    private func checkAnswers() -> Bool {
        pastSimpleTextField.text?.lowercased() == currentVerb?.pastSimple.lowercased() &&
        participleTextField.text?.lowercased() == currentVerb?.parcticiple.lowercased()
    }
    
    private func showScoreAlert() {
        let alertController = UIAlertController(
            title: "Congratulations!",
            message: "You scored \(score) out of \(dataSource.count) points",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([
                                 progressLabel,
                                 scoreLabel,
                                 infinitiveLabel,
                                 pastSimpleLabel,
                                 pastSimpleTextField,
                                 participleLabel,
                                 participleTextField,
                                 checkButton,
                                 skipButton
        ])
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        infinitiveLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
            
        }
        
        pastSimpleLabel.snp.makeConstraints { make in
            make.top.equalTo(infinitiveLabel.snp.bottom).offset(60)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleTextField.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleLabel.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleTextField.snp.makeConstraints { make in
            make.top.equalTo(participleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(participleTextField.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(edgeInsets)
            make.width.equalTo(150)
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(participleTextField.snp.bottom).offset(40)
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
            make.width.equalTo(150)
            //
            make.trailing.equalToSuperview().inset(edgeInsets)
        }
    }
}

// MARK: - UITextFieldDelegate

extension TrainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if pastSimpleTextField.isFirstResponder {
            participleTextField.becomeFirstResponder()
        } else {
            scrollView.endEditing(true)
        }
        return true
    }
}

    // MARK: - Keyboard events
private extension TrainViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        scrollView.contentInset.bottom = frame.height + 50
        
    }
    @objc
    func keyboardWillHide() {
        scrollView.contentInset.bottom = .zero - 50
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(recognizer)
    }
    
    @objc
    func hideKeyboard() {
        scrollView.endEditing(true)
    }
}
