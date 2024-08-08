//
//  ViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//
import UIKit
import FirebaseAnalytics

class TopTabBarController: UIViewController {
    private var tabBar: UIStackView!
    private var containerView: UIView!
    
    var storageProvider: StorageProvider
    
    init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let homeVC = UINavigationController(rootViewController: HomeViewController())
    private let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
    lazy var profileVC = UINavigationController(rootViewController: ProfileViewController(storageProvider: storageProvider))
    
    private var viewControllers: [UIViewController]!
    
    private var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupContainerView()
        setupViewControllers()
        selectViewController(homeVC)
    }
    
    private func setupTabBar() {
        tabBar = UIStackView()
        tabBar.axis = .horizontal
        tabBar.distribution = .fillEqually
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        
        let homeButton = createTabBarButton(title: "Home", image: UIImage(systemName: "house.fill"), backgroundColor: .customTabItemPink1)
        let favoritesButton = createTabBarButton(title: "Favoritos", image: UIImage(systemName: "heart.fill"), backgroundColor: .customTabItemPink2)
        let profileButton = createTabBarButton(title: "Perfil", image: UIImage(systemName: "person.circle"), backgroundColor: .customTabItemPink3)
        
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        favoritesButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        
        tabBar.addArrangedSubview(homeButton)
        tabBar.addArrangedSubview(favoritesButton)
        tabBar.addArrangedSubview(profileButton)
        
        view.addSubview(tabBar)
        
        NSLayoutConstraint.activate([
            tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupContainerView() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: tabBar.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupViewControllers() {
        viewControllers = [homeVC, favoritesVC, profileVC]
    }
    
    private func createTabBarButton(title: String, image: UIImage?, backgroundColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12) // Ajustar el tamaño de la fuente si es necesario
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.backgroundColor = backgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let spacing: CGFloat = 6.0 // Espacio entre la imagen y el título
        button.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image!.size.width, bottom: -image!.size.height, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: -button.titleLabel!.intrinsicContentSize.height, left: 0, bottom: 0, right: -button.titleLabel!.intrinsicContentSize.width)
        
        return button
    }
    
    @objc private func homeButtonTapped() {
        selectViewController(homeVC)
    }
    
    @objc private func favoritesButtonTapped() {
        Analytics.logEvent("favorites_open", parameters: nil)
        selectViewController(favoritesVC)
    }
    
    @objc private func profileButtonTapped() {
        Analytics.logEvent("profile_open", parameters: nil)
        selectViewController(profileVC)
    }
    
    private func selectViewController(_ viewController: UIViewController) {
        if let currentVC = currentViewController {
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }
        
        addChild(viewController)
        
        containerView.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        viewController.didMove(toParent: self)
        currentViewController = viewController
    }
}
