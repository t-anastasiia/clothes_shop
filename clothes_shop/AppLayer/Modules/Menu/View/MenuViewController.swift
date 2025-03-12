//
//  MenuViewController.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-05.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {
    
    // Данные для демонстрации
    // TODO: подцеплять опции с бэка, в админке добавить возможность добавлять/удалять опции
    private let options = ["Новинки", "Джинсы", "Футболки", "Обувь", "Мужское", "Женское"]
    private var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()

        view.backgroundColor = .white
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8 // расстояние между cells
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) // делает отступ содержимого внутри
        
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(OptionCell.self, forCellWithReuseIdentifier: OptionCell.identifier)
        return collection
    }()
    
    private func setupCollectionView() {
        let shadowContainer = UIView()
        shadowContainer.backgroundColor = .white
        shadowContainer.layer.shadowColor = UIColor(red: 0x82/255, green: 0x88/255, blue: 0x8E/255, alpha: 0.25).cgColor
        shadowContainer.layer.shadowOpacity = 1
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowContainer.layer.shadowRadius = 15
        
        view.addSubview(shadowContainer)
        shadowContainer.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(34)
        }
        
        shadowContainer.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalToSuperview()
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension MenuViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCell.identifier, for: indexPath) as? OptionCell else {
            fatalError("Failed to dequeue OptionCell")
        }
        
        let isSelected = indexPath.item == selectedIndex
        cell.configure(text: options[indexPath.item], isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = options[indexPath.item]
        let width = (text as NSString).size(
            withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)]
        ).width + 36 // padding внутри ячейки
        
        return CGSize(width: width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData()

        // TODO: сообщить Presenter о новом выборе
        // presenter.didSelectOption(at: selectedIndex)
    }
}
