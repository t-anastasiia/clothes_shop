//
//  MenuViewController.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-05.
//

import UIKit
import SnapKit
import SkeletonView

class MenuViewController: UIViewController, MenuViewProtocol {

    var presenter: MenuPresenterProtocol!
    var router: MenuRouterProtocol!

    private var categories: [Category] = []
    private var selectedCategoryIndex: Int?
    private var products: [Product] = []
    private var isLoading: Bool = true
    private var isCategoriesLoaded: Bool = false

    private lazy var categoriesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collection.delegate = self
        collection.dataSource = self
        collection.register(ChipCell.self, forCellWithReuseIdentifier: ChipCell.identifier)
        return collection
    }()

    private lazy var productsTableView: UITableView = {
        let tv = UITableView()
        tv.register(CatalogProductCell.self, forCellReuseIdentifier: CatalogProductCell.identifier)
        tv.register(CatalogProductCellShimmered.self, forCellReuseIdentifier: CatalogProductCellShimmered.identifier)
        tv.dataSource = self
        tv.delegate = self
        tv.tableFooterView = UIView()
        tv.isSkeletonable = true
        tv.separatorStyle = .singleLine
        tv.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tv.rowHeight = 180 // Примерная высота ячейки с отступами
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationController?.setNavigationBarHidden(true, animated: false)

        isLoading = true
        productsTableView.reloadData()
        categoriesCollection.reloadData()

        presenter?.didLoadView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if isLoading {
            view.layoutIfNeeded()
            productsTableView.showAnimatedGradientSkeleton()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }

    private func setupUI() {
        view.backgroundColor = .white

        let shadowContainer = UIView()
        shadowContainer.backgroundColor = .white
        shadowContainer.layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        shadowContainer.layer.shadowOpacity = 1
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowContainer.layer.shadowRadius = 15

        view.addSubview(productsTableView)
        view.addSubview(shadowContainer)
        shadowContainer.addSubview(categoriesCollection)

        shadowContainer.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        categoriesCollection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(34)
        }

        productsTableView.snp.makeConstraints { make in
            make.top.equalTo(shadowContainer.snp.bottom).offset(0)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: - Shimmer
    private func showInitialShimmer() {
        isLoading = true
        isCategoriesLoaded = false
        productsTableView.reloadData()
        categoriesCollection.reloadData()
        view.layoutIfNeeded()
        productsTableView.showAnimatedGradientSkeleton()
    }

    private func showProductsShimmer() {
        isLoading = true
        productsTableView.reloadData()
        view.layoutIfNeeded()
        productsTableView.showAnimatedGradientSkeleton()
    }

    private func hideShimmer() {
        isLoading = false
        productsTableView.hideSkeleton()
    }

    // MARK: MenuViewProtocol
    func showLoading() {
        DispatchQueue.main.async {
            guard !self.isCategoriesLoaded else { return }
            
            self.isLoading = true
            self.productsTableView.reloadData()
            self.productsTableView.showAnimatedGradientSkeleton()
        }
    }

    func show(categories: [Category]) {
        DispatchQueue.main.async {
            guard !self.isCategoriesLoaded else { return }
            
            guard !categories.isEmpty else {
                self.show(error: "Не удалось загрузить категории")
                return
            }
            
            self.categories = categories
            self.isCategoriesLoaded = true
            self.categoriesCollection.reloadData()
            
            // Выбираем первую категорию сразу после загрузки
            self.selectedCategoryIndex = 0
            self.presenter.didSelectCategory(self.categories[0])
        }
    }

    func show(error: String) {
        DispatchQueue.main.async {
            self.hideShimmer()
            print("Ошибка: \(error)")
            self.productsTableView.reloadData()
        }
    }

    func showProducts(_ products: [Product]) {
        DispatchQueue.main.async {
            self.products = products
            self.hideShimmer()
            self.productsTableView.reloadData()
        }
    }
}

// MARK: — UITableViewDataSource, UITableViewDelegate, SkeletonTableViewDataSource
extension MenuViewController: UITableViewDataSource, UITableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 5 : products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: CatalogProductCellShimmered.identifier, for: indexPath) as! CatalogProductCellShimmered
            cell.showShimmer()
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CatalogProductCell.identifier, for: indexPath) as! CatalogProductCell
            let product = products[indexPath.row]
            cell.configure(with: product)
            cell.selectionStyle = .none
            return cell
        }
    }

    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return isLoading ? CatalogProductCellShimmered.identifier : CatalogProductCell.identifier
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !isLoading else { return }
        let selectedProduct = products[indexPath.row]
        if let nav = self.parent as? UINavigationController {
            router.openProductDetails(navigationController: nav, with: selectedProduct)
        }
    }
}

// MARK: – UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource
extension MenuViewController: UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCell.identifier, for: indexPath) as! ChipCell
        
        guard indexPath.item < categories.count else { return cell }
        
        let name = categories[indexPath.item].name
        let isSelected = indexPath.item == selectedCategoryIndex
        cell.configure(text: name, isSelected: isSelected)
        return cell
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ChipCell.identifier
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = categories[indexPath.item].name
        let width = (name as NSString)
            .size(withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
            .width + 36
        return CGSize(width: width, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !isLoading || isCategoriesLoaded else { return }
        selectedCategoryIndex = indexPath.item
        collectionView.reloadData()
        let category = categories[indexPath.item]
        showProductsShimmer()
        presenter.didSelectCategory(category)
    }
}
