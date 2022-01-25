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
    
    let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    let menuHeight = UIScreen.main.bounds.height / 3
    private var isPresenting: Bool = false
    private var sections = [SettingsSection]()
    private var colorOption: SettingsSection!
    private var optionTitle = "Dark Mode"
    private let option1 = "     on"
    private let option2 = "     off"
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        updateUI()
        setUpThemeSection()
        initializeConstraints()
        initializeTableView()
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
        self.view.addSubview(settingsLabel)
        self.view.addSubview(colorSettingsTableView)
    }
    
    
    // Set up option sections
    private func setUpThemeSection() {
        var initialTitle: String {
            if isDarkMode {
                return optionTitle + option1
            } else {
                return optionTitle + option2
            }
        }
        colorOption = SettingsSection(title: initialTitle, options: [option1, option2], icon: UIImage(systemName: "moon.circle.fill")!)
        let languageOption = SettingsSection(title: "Language", options: [], icon: UIImage(systemName: "globe")!)
        let privacyOption = SettingsSection(title: "Privacy", options: [], icon: UIImage(systemName: "lock.circle")!)
        let helpOption = SettingsSection(title: "Help", options: [], icon: UIImage(systemName: "questionmark.app.fill")!)
        
        sections.append(colorOption)
        sections.append(languageOption)
        sections.append(privacyOption)
        sections.append(helpOption)
    }
    
    
    // MARK: - UI Configuration
    
    
    private func updateUI() {
        self.view.backgroundColor = .clear
        menuView.backgroundColor = .primaryColor
        updateTheme()
        self.colorSettingsTableView.backgroundColor = .clear
        
    }
    
    private func updateFrames() {
        _ = menuView.roundedCornersMaxCurve
    }
    
    private func updateTheme() {
        if isDarkMode {
            menuView.overrideUserInterfaceStyle = .dark
        } else {
            menuView.overrideUserInterfaceStyle = .light
        }
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
    
    // Settings label
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .white
        return label
    }()
    
    // Sections tableView
    private let colorSettingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bounces = false
        tableView.isPagingEnabled = true
        return tableView
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

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    private func initializeTableView() {
        colorSettingsTableView.register(SettingsSectionTableViewCell.self, forCellReuseIdentifier: SettingsSectionTableViewCell.identifier)
        colorSettingsTableView.delegate = self
        colorSettingsTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 40
        }
        return 30
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        if section.isOpened  {
            return section.options.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSectionTableViewCell.identifier, for: indexPath) as! SettingsSectionTableViewCell
        if indexPath.row == 0 {
            cell.optionCellTitle.text = sections[indexPath.section].title
            cell.optionCellIcon.image = sections[indexPath.section].icon
        } else {
            cell.optionCellTitle.text = sections[indexPath.section].options[indexPath.row - 1]
            cell.optionCellIcon.image = nil
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        
        sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
        tableView.reloadSections([indexPath.section], with: .none)
        if indexPath.row == 1 {
                colorOption.title = optionTitle + option1
                tableView.reloadSections([indexPath.section], with: .none)
            if isDarkMode != true {
                UserDefaults.standard.set(true, forKey: "isDarkMode")
                updateTheme()
                menuView.overrideUserInterfaceStyle = .dark
            }
            NotificationCenter.default.post(name: .darkTheme, object: nil)
            
        } else if indexPath.row == 2 {
            colorOption.title = optionTitle + option2
            tableView.reloadSections([indexPath.section], with: .none)
            if isDarkMode == true {
                UserDefaults.standard.set(false, forKey: "isDarkMode")
                updateTheme()
                menuView.overrideUserInterfaceStyle = .light
            }
            NotificationCenter.default.post(name: .lightTheme, object: nil)
            
        }
        
    }
    
}




// MARK: - Constraints

extension SettingsViewController {
    
    private func initializeConstraints() {
        // Constants
        let topPadding = CGFloat(25)
        let leftPadding = CGFloat(30)
        let rightPadding = CGFloat(-30)
        let bottomPadding = CGFloat(-50)
        let paddingBetweenItems = CGFloat(10)
        
        var constraints = [NSLayoutConstraint]()
        
        // Menu view
        constraints.append(menuView.heightAnchor.constraint(equalToConstant: menuHeight))
        constraints.append(menuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        constraints.append(menuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        constraints.append(menuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        
        // Settings label
        constraints.append(settingsLabel.topAnchor.constraint(equalTo: menuView.topAnchor, constant: topPadding))
        constraints.append(settingsLabel.centerXAnchor.constraint(equalTo: menuView.centerXAnchor))
        
        
        // TableView
        constraints.append(colorSettingsTableView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: paddingBetweenItems))
        constraints.append(colorSettingsTableView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: leftPadding))
        constraints.append(colorSettingsTableView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: rightPadding))
        constraints.append(colorSettingsTableView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor, constant: bottomPadding))
        
        NSLayoutConstraint.activate(constraints)
    }
}
