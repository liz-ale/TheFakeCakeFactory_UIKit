//
//  ViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class TopTabBarController: UIViewController {
    private var tabBar: UIStackView!
    private var containerView: UIView!
    
    private let homeVC = UINavigationController(rootViewController: HomeViewController())
    private let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
    private let profileVC = UINavigationController(rootViewController: ProfileViewController())
    
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
        tabBar.backgroundColor = .white
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        
        let homeButton = createTabBarButton(title: "Home", image: UIImage(systemName: "house.fill"))
        let favoritesButton = createTabBarButton(title: "Favoritos", image: UIImage(systemName: "heart.fill"))
        let profileButton = createTabBarButton(title: "Perfil", image: UIImage(systemName: "person.circle"))
        
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
            tabBar.heightAnchor.constraint(equalToConstant: 50)
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
            containerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupViewControllers() {
        viewControllers = [homeVC, favoritesVC, profileVC]
    }
    
    private func createTabBarButton(title: String, image: UIImage?) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = .systemPurple
        button.imageView?.contentMode = .scaleAspectFit
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }
    
    @objc private func homeButtonTapped() {
        selectViewController(homeVC)
    }
    
    @objc private func favoritesButtonTapped() {
        selectViewController(favoritesVC)
    }
    
    @objc private func profileButtonTapped() {
        selectViewController(profileVC)
    }
    
    private func selectViewController(_ viewController: UIViewController) {
        if let currentVC = currentViewController {
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }
        
        addChild(viewController)
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        
        currentViewController = viewController
    }
}
