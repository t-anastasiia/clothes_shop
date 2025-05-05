//
//  MenuPresenterProtocol.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-05-05.
//

import Foundation

protocol MenuPresenterProtocol: AnyObject {
    func didLoadView()
    func didSelectSegment(index: Int)
}
