//
//  Extensions.swift
//  NewsApp
//
//  Created by Shailesh Aher on 27/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import UIKit

extension UIView {
    class func construct<T: UIView>(customize: ((T) -> Void)? = nil) -> T {
        let view = T(frame: .zero)
        customize?(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
