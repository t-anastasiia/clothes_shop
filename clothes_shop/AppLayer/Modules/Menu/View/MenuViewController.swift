//
//  MenuViewController.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-05.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController, MenuViewProtocol {

    var presenter: MenuPresenterProtocol!
    var router: MenuRouterProtocol!

    private var categories: [Category] = []
    private var selectedCategoryIndex: Int?
    private var products: [Product] = []

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
        tv.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        tv.dataSource = self
        tv.delegate = self
        tv.tableFooterView = UIView()
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.didLoadView()
    }

    private func setupUI() {
        view.backgroundColor = .white

        let shadowContainer = UIView()
        shadowContainer.backgroundColor = .white
        shadowContainer.layer.shadowColor = UIColor(red: 0x82/255, green: 0x88/255, blue: 0x8E/255, alpha: 0.25).cgColor
        shadowContainer.layer.shadowOpacity = 1
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowContainer.layer.shadowRadius = 15

        view.addSubview(shadowContainer)
        shadowContainer.addSubview(categoriesCollection)
        
        categoriesCollection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(34)
        }

        shadowContainer.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        view.addSubview(productsTableView)
        productsTableView.snp.makeConstraints { make in
            make.top.equalTo(shadowContainer.snp.bottom).offset(25)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: MenuViewProtocol
    func showLoading() {
    }

    func show(categories: [Category]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.categoriesCollection.reloadData()
        }
    }

    func show(error: String) {
    }

    func showProducts(_ products: [Product]) {
        self.products = products
        DispatchQueue.main.async {
            self.productsTableView.reloadData()
        }
    }
}

// MARK: – UICollectionViewDelegateFlowLayout, DataSource
extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(_ cv: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: ChipCell.identifier,
                                          for: indexPath) as! ChipCell
        let name = categories[indexPath.item].name
        let isSelected = indexPath.item == selectedCategoryIndex
        cell.configure(text: name, isSelected: isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = categories[indexPath.item].name
        let width = (name as NSString)
            .size(withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
            .width + 36
        return CGSize(width: width, height: collectionView.bounds.height)
    }

    func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath.item
        cv.reloadData()
        let category = categories[indexPath.item]
        presenter.didSelectCategory(category)
    }
}

// MARK: — UITableViewDataSource, UITableViewDelegate
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        if let nav = self.parent as? UINavigationController {
            print("✅ Навигация доступна, открываем продукт:", selectedProduct.title)
            router.openProductDetails(navigationController: nav, with: selectedProduct)
        } else {
            print("❌ Навигация недоступна")
        }
    }
}
