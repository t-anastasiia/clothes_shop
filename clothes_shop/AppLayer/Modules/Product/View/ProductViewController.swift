//
//  ProductViewController.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import UIKit
import SnapKit

class ProductViewController: UIViewController {

    // TODO: создать фабрики для передачи зависимостей
    private let imageLoader = UIImageLoader()
    var presenter: ProductPresenterProtocol!

    private var sizes: [SizeDetailed] = []
    private var selectedSizeIndex: Int?

    // MARK: - Elements

    private let markLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW"
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = .white
        label.backgroundColor = UIColor(named: "BrownLight")
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()

    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let productName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor(named: "Text/Primary")
        return label
    }()

    private let infoButton: UIButton = {
        // TODO: заменить на иконку из макета
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "info.circle")
        config.baseForegroundColor = UIColor(named: "BrownLight")
        config.background.backgroundColor = UIColor(named: "Beige")
        return UIButton(configuration: config)
    }()

    private let productDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: "Text/Second")
        label.numberOfLines = 0
        return label
    }()

    private let bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var sizeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(ChipCell.self, forCellWithReuseIdentifier: ChipCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        cv.alwaysBounceVertical = false
        cv.contentInsetAdjustmentBehavior = .never
        return cv
    }()

    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Divider") ?? UIColor.lightGray.withAlphaComponent(0.3)
        return view
    }()

    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину · 0 ₽", for: .normal)
        button.backgroundColor = UIColor(named: "BrownLight")
        button.tintColor = UIColor(named: "Text/White")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        sutupUI()
        setupAddToCartView()
        presenter.viewDidLoad()
    }

    // MARK: - UI Setup

    private func sutupUI() {
        view.backgroundColor = .white

        view.addSubview(markLabel)
        view.addSubview(productImage)
        view.addSubview(productName)
        view.addSubview(infoButton)
        view.addSubview(productDescription)

        markLabel.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(markLabel.intrinsicContentSize.width + 12)
        }

        productImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(250)
        }

        productName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(productImage.snp.bottom).offset(8)
            make.right.equalTo(infoButton.snp.left).offset(-8)
        }

        infoButton.snp.makeConstraints { make in
            make.centerY.equalTo(productName)
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(32)
        }

        productDescription.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
    }

    private func setupAddToCartView() {
        let shadowContainer = UIView()
        shadowContainer.backgroundColor = .white
        shadowContainer.layer.shadowColor = UIColor(red: 0x82/255, green: 0x88/255, blue: 0x8E/255, alpha: 0.25).cgColor
        shadowContainer.layer.shadowOpacity = 1
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: -2)
        shadowContainer.layer.shadowRadius = 15
        shadowContainer.clipsToBounds = false

        view.addSubview(shadowContainer)
        shadowContainer.addSubview(bottomBar)
        bottomBar.addSubview(sizeCollectionView)
        bottomBar.addSubview(divider)
        bottomBar.addSubview(addToCartButton)

        bottomBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(80)
        }

        addToCartButton.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        shadowContainer.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }

        sizeCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(34)
        }

        divider.snp.makeConstraints { make in
            make.top.equalTo(sizeCollectionView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }

        addToCartButton.snp.remakeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}

// MARK: - UICollectionView
extension ProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sizes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCell.identifier, for: indexPath) as! ChipCell
        let size = sizes[indexPath.item]
        let isSelected = indexPath.item == selectedSizeIndex
        cell.configure(text: size.brandSize, isSelected: isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = sizes[indexPath.item].brandSize
        let width = (text as NSString)
            .size(withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
            .width + 36
        return CGSize(width: width, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSizeIndex = indexPath.item
        collectionView.reloadData()
        // TODO: сообщить Presenter о новом выборе
    }
}

// MARK: - ProductViewProtocol
extension ProductViewController: ProductViewProtocol {
    func displayProduct(_ product: Product) {
        productName.text = product.title
        productDescription.text = product.description
        selectedSizeIndex = nil
        addToCartButton.setTitle("В корзину · \(Int(product.price)) ₽", for: .normal)

        imageLoader.loadImage(from: product.image) { [weak self] image in
            DispatchQueue.main.async {
                self?.productImage.image = image
            }

            // после загрузки картинки
            self?.sizes = [
                SizeDetailed(brandSize: "S", isAvailable: true),
                SizeDetailed(brandSize: "M", isAvailable: true),
                SizeDetailed(brandSize: "L", isAvailable: true),
                SizeDetailed(brandSize: "XL", isAvailable: true)
            ]
            self?.sizeCollectionView.reloadData()
        }
    }
}
