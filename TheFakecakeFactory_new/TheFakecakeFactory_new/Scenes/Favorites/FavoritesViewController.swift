//
//  FavoritesViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let interactor: CakesInteractor
    
    init(interactor: CakesInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var carouselImages: [UIImage] = []
    private let carousel = CarouselView()
    
   
    let imagesBanner = ["bn1", "bn2", "bn3", "bn4"]
    let images = ["f1", "f2", "f3"]
   
    let bannerLabel = UILabel()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBgPink

        setupCarouselView()
        setupBannerLabel()
        setupTableView()
        setupLayout()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()  // Recarga la tabla cada vez que la vista aparece
    }


    func setupCarouselView() {
        carouselImages = [UIImage(named: "bn1")!, UIImage(named: "bn2")!, UIImage(named: "bn3")!, UIImage(named: "bn4")!]
        carousel.setImages(carouselImages)
        view.addSubview(carousel)
        carousel.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupBannerLabel() {
        bannerLabel.text = "Quizás pueda interesarte..."
        bannerLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        bannerLabel.textColor = .white
        bannerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerLabel)
    }
    
    func setupTableView() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(CustomFavoritesTableViewCell.self, forCellReuseIdentifier: "customFavoritesCell")
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 120
            tableView.separatorStyle = .none
            tableView.backgroundColor = .customBgPink
            view.addSubview(tableView)
        }
    
    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            carousel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -50),
            carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carousel.heightAnchor.constraint(equalToConstant: 200),
            
            bannerLabel.topAnchor.constraint(equalTo: carousel.topAnchor, constant: 10),
            bannerLabel.leadingAnchor.constraint(equalTo: carousel.leadingAnchor, constant: 10),

            tableView.topAnchor.constraint(equalTo: carousel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - UITableView DataSource and Delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        //return images.count
        //return 1
        return interactor.favoriteCakes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customFavoritesCell", for: indexPath) as! CustomFavoritesTableViewCell
        let favoriteCakesArray = Array(interactor.favoriteCakes)
        let cake = favoriteCakesArray[indexPath.section]
        
        let baseURL = "https://eniadesign.com.mx/"
        if let imageURL = URL(string: baseURL)?.appendingPathComponent(cake.image) {
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.configure(name: cake.name, description: cake.description, imageName: image!)
                    cell.backgroundColor = .customBgPurple
                    cell.textLabel?.textColor = .white
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Set a fixed height for each cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .customBgPink
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5 // Set the spacing between cells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteCakesArray = Array(interactor.favoriteCakes)
        let selectedCake = favoriteCakesArray[indexPath.section]
        let detailVC = DetailViewController(cake: selectedCake, interactor: interactor)
        present(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            let favoriteCakesArray = Array(self.interactor.favoriteCakes)
            let cakeToRemove = favoriteCakesArray[indexPath.section]
            self.interactor.removeFavorite(cake: cakeToRemove)
            tableView.deleteSections([indexPath.section], with: .automatic)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.circle.fill")
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
