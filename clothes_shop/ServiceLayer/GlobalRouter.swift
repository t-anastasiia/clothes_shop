//
//  GlobalRouter.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-05.
//

import UIKit

final class GlobalRouter {
    
    static let instance = GlobalRouter()
    
    weak var window: UIWindow?
    
    private init() {}
    
    /// Точка входа при старте приложения
    func presentLoading() {
        let isAuthorized = checkAuthorization()
        
        if isAuthorized {
            setMain()
        } else {
            setAuth()
        }
    }
    
    /// Переход на экран авторизации
    func setAuth() {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemRed
        vc.title = "Заглушка авторизации"
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    /// Переход на главный экран
    func setMain() {
        let mainVC = MainConfigurator().configure()
        
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
    
    // TODO: сделать проверку авторизации
    private func checkAuthorization() -> Bool {
        return true
    }
}
