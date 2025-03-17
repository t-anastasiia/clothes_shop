//
//  ProductViewController.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import UIKit
import SnapKit

class ProductViewController: UIViewController {
    
    var presenter: ProductPresenterProtocol!
    
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
        // TODO: заменть на иконку из макета
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "info.circle")
        config.baseForegroundColor = UIColor(named: "BrownLight")
        config.background.backgroundColor = UIColor(named: "Beige")

        let button = UIButton(configuration: config)
        
        return button
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
    
    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину · 4950 ₽", for: .normal)
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
    
    // MARK: - Methods
    
    private func sutupUI() {
        view.backgroundColor = .white
        
        view.addSubview(markLabel)
        view.addSubview(productImage)
        view.addSubview(productName)
        view.addSubview(infoButton)
        view.addSubview(productDescription)
        
        // MARK: - Constraints
        
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
        bottomBar.addSubview(addToCartButton)

        bottomBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(80)
        }

        addToCartButton.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        shadowContainer.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension ProductViewController: ProductViewProtocol {
    func displayProduct(_ product: ProductDetails) {
        if let urlString = product.images.first?.url {
            let fullImageURL = urlString.hasPrefix("http") ? urlString : "https://" + urlString
            if let url = URL(string: fullImageURL) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, let image = UIImage(data: data), error == nil else {
                        DispatchQueue.main.async {
                            self.productImage.image = UIImage(systemName: "photo")
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self.productName.text = product.name
                        self.productDescription.text = product.description
                        self.productImage.image = image
                    }
                }
                task.resume()
            } else {
                productImage.image = UIImage(systemName: "photo")
            }
        } else {
            productImage.image = UIImage(systemName: "photo")
        }
    }
}
