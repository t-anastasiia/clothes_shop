//
//  ProductViewController.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import UIKit
import SnapKit
import SkeletonView

class ProductViewController: UIViewController {

    // TODO: создать фабрики для передачи зависимостей
    private let imageLoader = UIImageLoader()
    var presenter: ProductPresenterProtocol!

    private var sizes: [SizeDetailed] = []
    private var selectedSizeIndex: Int?
    private var recommendedProducts: [Product] = []

    private var bottomBarHeightConstraint: Constraint?
    private var recommendationsBottomConstraint: Constraint?

    private var isLoading: Bool = true
    
    var product: Product?

    // MARK: - Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isSkeletonable = true
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        return view
    }()

    private let markLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW"
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = .white
        label.backgroundColor = UIColor(named: "BrownLight")
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.textAlignment = .center
        label.isSkeletonable = true
        return label
    }()

    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isSkeletonable = true
        return imageView
    }()

    private let productName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor(named: "Text/Primary")
        label.isSkeletonable = true
        return label
    }()

    private let infoButton: UIButton = {
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
        label.isSkeletonable = true
        return label
    }()

    private let recommendationsTitle: UILabel = {
        let label = UILabel()
        label.text = "You may also neeed"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "Text/Primary")
        label.isSkeletonable = true
        return label
    }()

    private lazy var recommendationsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: 160, height: 200)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(RecommendedProductCell.self, forCellWithReuseIdentifier: RecommendedProductCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cv.isSkeletonable = true
        return cv
    }()

    private let bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isSkeletonable = true
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
        cv.isSkeletonable = true
        return cv
    }()

    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Divider") ?? UIColor.lightGray.withAlphaComponent(0.3)
        view.isSkeletonable = true
        return view
    }()

    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину · 0 $", for: .normal)
        button.backgroundColor = UIColor(named: "BrownLight")
        button.tintColor = UIColor(named: "Text/White")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.titleLabel?.numberOfLines = 1
        button.isSkeletonable = true
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sutupUI()
        
        if let product = self.product {
            displayProduct(product)
            presenter.loadRecommendations(for: product)
        } else {
            showShimmer()
            presenter.viewDidLoad()
        }
        
        navigationController?.navigationBar.tintColor = UIColor(named: "BrownDark")
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = nil
        sizeCollectionView.isHidden = true
        divider.isHidden = true
        bottomBarHeightConstraint?.update(offset: 48)
        setupAddToCartView()
        
        if let gesture = navigationController?.interactivePopGestureRecognizer {
            gesture.delegate = self
            gesture.addTarget(self, action: #selector(handlePopGesture))
        }
    }
    
    @objc private func handlePopGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        let translation = gesture.translation(in: view).x
        let progress = translation / view.bounds.width
        
        switch gesture.state {
        case .began:
            NotificationCenter.default.post(name: .showMainTabBar, object: nil)
        case .changed:
            if progress > 0.5 {
                NotificationCenter.default.post(name: .showMainTabBar, object: nil)
            } else {
                NotificationCenter.default.post(name: .hideMainTabBar, object: nil)
            }
        case .cancelled, .failed, .ended:
            if progress < 0.5 {
                NotificationCenter.default.post(name: .hideMainTabBar, object: nil)
            }
        default:
            break
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: - UI Setup
    private func sutupUI() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(markLabel)
        contentView.addSubview(productImage)
        contentView.addSubview(productName)
        contentView.addSubview(infoButton)
        contentView.addSubview(productDescription)
        contentView.addSubview(recommendationsTitle)
        contentView.addSubview(recommendationsCollection)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        markLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(markLabel.intrinsicContentSize.width + 12)
        }

        productImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
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

        recommendationsTitle.snp.makeConstraints { make in
            make.top.equalTo(productDescription.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
        }

        recommendationsCollection.snp.makeConstraints { make in
            make.top.equalTo(recommendationsTitle.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
            self.recommendationsBottomConstraint = make.bottom.equalToSuperview().offset(-80).constraint
        }
    }

    private func setupAddToCartView() {
        let shadowContainer = UIView()
        shadowContainer.backgroundColor = .white
        shadowContainer.layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        shadowContainer.layer.shadowOpacity = 1
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: -2)
        shadowContainer.layer.shadowRadius = 15
        shadowContainer.clipsToBounds = false
        shadowContainer.isSkeletonable = true

        view.addSubview(shadowContainer)
        shadowContainer.addSubview(bottomBar)
        bottomBar.addSubview(sizeCollectionView)
        bottomBar.addSubview(divider)
        bottomBar.addSubview(addToCartButton)

        sizeCollectionView.isHidden = true
        divider.isHidden = true
        bottomBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(32)
            bottomBarHeightConstraint = make.height.equalTo(48).constraint
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
            make.height.equalTo(0)
        }

        divider.snp.makeConstraints { make in
            make.top.equalTo(sizeCollectionView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(0)
        }

        addToCartButton.snp.remakeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(0)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateRecommendationsBottomInset()
    }

    private func updateRecommendationsBottomInset() {
        let bottomBarFrame = bottomBar.superview?.convert(bottomBar.frame, to: view) ?? .zero
        let safeAreaBottom = view.safeAreaInsets.bottom
        let bottomInset = view.bounds.height - bottomBarFrame.origin.y + 8
        recommendationsBottomConstraint?.update(offset: -bottomInset)
    }

    private func showShimmer() {
        isLoading = true
        view.showAnimatedGradientSkeleton()
    }

    private func hideShimmer() {
        isLoading = false
        view.hideSkeleton()
    }
}

// MARK: - UICollectionView
extension ProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, SkeletonCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sizeCollectionView {
            return sizes.count
        } else {
            return isLoading ? 3 : recommendedProducts.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sizeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCell.identifier, for: indexPath) as! ChipCell
            if isLoading {
                cell.showShimmer()
            } else {
                let size = sizes[indexPath.item]
                let isSelected = indexPath.item == selectedSizeIndex
                cell.configure(text: size.brandSize, isSelected: isSelected)
                cell.hideShimmer()
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedProductCell.identifier, for: indexPath) as! RecommendedProductCell
            if isLoading {
                cell.showShimmer()
            } else {
                let product = recommendedProducts[indexPath.item]
                cell.configure(with: product)
                cell.hideShimmer()
            }
            return cell
        }
    }

    // SkeletonView
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isLoading ? 3 : recommendedProducts.count
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return RecommendedProductCell.identifier
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sizeCollectionView {
            let text = sizes[indexPath.item].brandSize
            let width = (text as NSString)
                .size(withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
                .width + 36
            return CGSize(width: width, height: collectionView.bounds.height)
        } else {
            return CGSize(width: 160, height: 200)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !isLoading else { return }
        if collectionView == sizeCollectionView {
            selectedSizeIndex = indexPath.item
            collectionView.reloadData()
        } else {
            let selectedProduct = recommendedProducts[indexPath.item]
            if let nav = self.navigationController {
                presenter.didSelectRecommendedProduct(selectedProduct)
            }
        }
    }
}

// MARK: - ProductViewProtocol
extension ProductViewController: ProductViewProtocol {
    func displayProduct(_ product: Product) {
        productName.text = product.title
        productDescription.text = product.description
        addToCartButton.setTitle("Add to cart · \(product.price) $", for: .normal)

        imageLoader.loadImage(from: product.image) { [weak self] image in
            DispatchQueue.main.async {
                self?.productImage.image = image

                let isClothes = product.category.contains("clothing")
                if isClothes {
                    self?.sizes = [
                        SizeDetailed(brandSize: "S", isAvailable: true),
                        SizeDetailed(brandSize: "M", isAvailable: true),
                        SizeDetailed(brandSize: "L", isAvailable: true),
                        SizeDetailed(brandSize: "XL", isAvailable: true)
                    ]
                    self?.selectedSizeIndex = 0
                } else {
                    self?.sizes = []
                    self?.selectedSizeIndex = nil
                }

                let shouldShowSizes = !(self?.sizes.isEmpty ?? true)
                self?.bottomBarHeightConstraint?.update(offset: shouldShowSizes ? 80 : 48)
                self?.sizeCollectionView.isHidden = !shouldShowSizes
                self?.divider.isHidden = !shouldShowSizes
                self?.sizeCollectionView.snp.updateConstraints { make in
                    make.height.equalTo(shouldShowSizes ? 34 : 0)
                }
                self?.divider.snp.updateConstraints { make in
                    make.height.equalTo(shouldShowSizes ? 1 : 0)
                }
                self?.addToCartButton.snp.updateConstraints { make in
                    make.top.equalTo(self?.divider.snp.bottom ?? 0).offset(shouldShowSizes ? 12 : 0)
                }
                self?.sizeCollectionView.reloadData()
                self?.hideShimmer()
            }
        }
    }

    func displayRecommendedProducts(_ products: [Product]) {
        self.recommendedProducts = products
        recommendationsCollection.reloadData()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ProductViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
