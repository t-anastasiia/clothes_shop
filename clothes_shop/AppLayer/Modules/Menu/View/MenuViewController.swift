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

    private let options = ["Men","Women"]
    private var selectedIndex = 0

    private var categories: [Category] = []
    private let categoryRepo: CategoryRepositoryProtocol = CategoryRepository()

    private lazy var optionsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cv.register(ChipCell.self, forCellWithReuseIdentifier: ChipCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    private lazy var categoriesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cv.register(ChipCell.self, forCellWithReuseIdentifier: ChipCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(optionsCollection)
        optionsCollection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(34)
        }

        view.addSubview(categoriesCollection)
        categoriesCollection.snp.makeConstraints { make in
            make.top.equalTo(optionsCollection.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(34)
        }

        fetchCategories(.men)
    }

    private func fetchCategories(_ endpoint: CategoryEndpoint) {
        Task {
            do {
                categories = try await categoryRepo.getCategories(for: endpoint)
                categoriesCollection.reloadData()
            } catch {
                print("Ошибка загрузки:", error)
            }
        }
    }

    // MARK: MenuViewProtocol
    func showLoading() {}
    func show(categories: [Category]) {}
    func show(error: String) {}
}

// MARK: – UICollectionViewDelegateFlowLayout, DataSource
extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cv == optionsCollection ? options.count : categories.count
    }

    func collectionView(_ cv: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(
            withReuseIdentifier: ChipCell.identifier,
            for: indexPath
        ) as! ChipCell

        if cv == optionsCollection {
            let isSel = indexPath.item == selectedIndex
            let full = options[indexPath.item]
            let text = isSel ? full : String(full.prefix(1))
            cell.configure(text: text, isSelected: isSel)
        } else {
            cell.configure(text: categories[indexPath.item].name, isSelected: false)
        }

        return cell
    }

    func collectionView(_ cv: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = cv.bounds.height

        if cv == optionsCollection {
            let other = (indexPath.item == 0 ? 1 : 0)
            let otherText = String(options[other].prefix(1))
            let otherWidth = (otherText as NSString)
                .size(withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
                .width + 20

            let spacing = (collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
            let insetH = optionsCollection.contentInset.left + optionsCollection.contentInset.right

            if indexPath.item == selectedIndex {
                let fullWidth = optionsCollection.bounds.width - otherWidth - spacing - insetH
                return CGSize(width: fullWidth, height: height)
            } else {
                let text = String(options[indexPath.item].prefix(1))
                let width = (text as NSString)
                    .size(withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
                    .width + 20
                return CGSize(width: width, height: height)
            }
        } else {
            let name = categories[indexPath.item].name
            let width = (name as NSString)
                .size(withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
                .width + 20
            return CGSize(width: width, height: height)
        }
    }

    func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard cv == optionsCollection else {
            // TODO: обработка подкатегорий...
            return
        }

        let old = selectedIndex
        selectedIndex = indexPath.item

        optionsCollection.performBatchUpdates({
            optionsCollection.reloadItems(at: [
                IndexPath(item: old, section: 0),
                IndexPath(item: selectedIndex, section: 0)
            ])
        }, completion: nil)

        let endpoint: CategoryEndpoint = (selectedIndex == 0 ? .men : .women)
        fetchCategories(endpoint)
    }
}
