//
//  SettingsViewController.swift
//  Movies App
//
//  Created by aleksandre on 22.01.22.
//

import UIKit
import Switches

class SettingsViewController: UIViewController {
    
    // Self identifier
    private(set) static var identifier = "SettingsViewController"
    
    // MARK: - Instances
    
    let menuHeight = UIScreen.main.bounds.height / 6
    private var isPresenting: Bool = false
    private var darkTheme: Bool = true {
        didSet {
            if darkTheme {
                self.menuView.backgroundColor = .mainAppColor
                
            } else {
                self.menuView.backgroundColor = .lightGray
            }
        }
    }
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        populateStackView()
        updateUI()
        initializeConstraints()
        addGestureRecognizers()

    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFrames()
    }
    
    // Add subviews
    private func addSubviews() {
        self.view.addSubview(backDropView)
        self.view.addSubview(menuView)
        self.view.addSubview(childStackView)
        self.view.addSubview(parentStackView)
    }
    
    // Populate StackView with arranged subviews
    private func populateStackView() {
        childStackView.addArrangedSubview(moonImageView)
        childStackView.addArrangedSubview(darkModeLabel)
        parentStackView.addArrangedSubview(childStackView)
        parentStackView.addArrangedSubview(darkModeButton)
        
    }
    
    
    // MARK: - UI Configuration
    
    // Update UI
    private func updateUI() {
        self.view.backgroundColor = .clear
        menuView.backgroundColor = .mainAppColor
    }
    
    // Update frames
    private func updateFrames() {
        _ = menuView.roundedCornersMaxCurve
    }
    
    // MARK: - UI Elements
    
    // Upper view
    lazy var backDropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bdView
    }()
    
    // Actual view of the controller
    private let menuView: UIView = {
        let menuView = UIView()
        menuView.translatesAutoresizingMaskIntoConstraints = false
        return menuView
    }()
    
    // MoonImageView
    private let moonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "moon.circle.fill")
        imageView.tintColor = .gray
        return imageView
    }()
    
    // DarkMode label
    private let darkModeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dark Mode"
        label.textColor = .white
        return label
    }()
    
    // DarkMode Button
    private let darkModeButton: UIButton = {
        var config = UIButton.Configuration.plain()
        let button = UIButton(configuration: config, primaryAction: .none)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("On", for: .normal)
        button.addTarget(self, action: #selector(navigateToColorsThemeVC), for: .touchUpInside)
        return button
    }()
    
    // Parent StackView
    private let parentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Child stackView
    private let childStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Gestures and Action
    
    // Method to dismiss Presented(self) ViewController
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    private func addGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        backDropView.addGestureRecognizer(tapGesture)
    }
    
    // Sends notification to all observers on tap
    @objc private func updateTheme() {
        NotificationCenter.default.post(name: .themeColorUpdated, object: nil)
        self.darkTheme = !self.darkTheme
    }
    
    // Action to navigate to app theme screen
    @objc private func navigateToColorsThemeVC() {
        let targetVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ColorsThemeViewController.identifier) as! ColorsThemeViewController
        targetVC.modalPresentationStyle = .currentContext
        present(targetVC, animated: true, completion: nil)
        
    }
}

    // MARK: - Transition Configuration, Delegate Methods

extension SettingsViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
        
        if isPresenting == true {
            containerView.addSubview(toVC.view)
            menuView.frame.origin.y += menuHeight
            backDropView.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.menuView.frame.origin.y -= self.menuHeight
                self.backDropView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
            
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.menuView.frame.origin.y += self.menuHeight
                self.backDropView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
            
        }
    }
}

    // MARK: - TableView Configuration, Delegate Methods
//
//extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
//
//
//    private func initializeTableView() {
//        colorSettingsTableView.register(ColorThemeSettingsTableViewCell.self, forCellReuseIdentifier: ColorThemeSettingsTableViewCell.identifier)
//        colorSettingsTableView.delegate = self
//        colorSettingsTableView.dataSource = self
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//
//
//}




    // MARK: - Constraints

extension SettingsViewController {
    
    private func initializeConstraints() {
        // Constants
        let topPadding = CGFloat(25)
        let leftPadding = CGFloat(30)
        let rightPadding = CGFloat(-30)
        let stackViewHeight = menuHeight / 5
   
        var constraints = [NSLayoutConstraint]()
        
        // Menu View
        constraints.append(menuView.heightAnchor.constraint(equalToConstant: menuHeight))
        constraints.append(menuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        constraints.append(menuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30))
        constraints.append(menuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30))
        
        // Parent StackView
        constraints.append(parentStackView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: leftPadding))
        constraints.append(parentStackView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: rightPadding))
        constraints.append(parentStackView.topAnchor.constraint(equalTo: menuView.topAnchor, constant: topPadding))
        constraints.append(parentStackView.heightAnchor.constraint(equalToConstant: stackViewHeight))
        constraints.append(childStackView.centerYAnchor.constraint(equalTo: parentStackView.centerYAnchor))
        

        NSLayoutConstraint.activate(constraints)
    }
}
