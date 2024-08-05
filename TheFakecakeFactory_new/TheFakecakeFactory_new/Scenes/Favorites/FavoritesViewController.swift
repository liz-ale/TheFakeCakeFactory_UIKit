//
//  FavoritesViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {

    let imagesBanner = ["bn1", "bn2", "bn3", "bn4"]
    let images = ["f1", "f2", "f3"]
    var carouselTimer: Timer?

    let carouselView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let bannerLabel = UILabel()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBgPink

        setupCarouselView()
        setupBannerLabel()
        setupTableView()
        setupLayout()
        startCarousel()
    }

    func setupCarouselView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width, height: 200)

        carouselView.collectionViewLayout = layout
        carouselView.isPagingEnabled = true
        carouselView.showsHorizontalScrollIndicator = false
        carouselView.delegate = self
        carouselView.dataSource = self
        carouselView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "carouselCell")
        view.addSubview(carouselView)
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
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            carouselView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -50),
            carouselView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carouselView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carouselView.heightAnchor.constraint(equalToConstant: 200),

            bannerLabel.topAnchor.constraint(equalTo: carouselView.topAnchor, constant: 10),
            bannerLabel.leadingAnchor.constraint(equalTo: carouselView.leadingAnchor, constant: 10),

            tableView.topAnchor.constraint(equalTo: carouselView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func startCarousel() {
        carouselTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(handleCarouselTransition), userInfo: nil, repeats: true)
    }

    @objc func handleCarouselTransition() {
        let visibleItems = carouselView.indexPathsForVisibleItems.sorted()
        guard let currentItem = visibleItems.first else { return }
        let nextItem = currentItem.item + 1 < imagesBanner.count ? currentItem.item + 1 : 0
        let nextIndexPath = IndexPath(item: nextItem, section: 0)
        carouselView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }

    // MARK: - UICollectionView DataSource and Delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesBanner.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath)
        cell.contentView.layer.contents = UIImage(named: imagesBanner[indexPath.item])?.cgImage
        return cell
    }

    // MARK: - UITableView DataSource and Delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return images.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customFavoritesCell", for: indexPath) as! CustomFavoritesTableViewCell
        cell.configure(name: "Lorem Ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", imageName: images[indexPath.section])
        cell.backgroundColor = .purple
        cell.textLabel?.textColor = .white
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
}
