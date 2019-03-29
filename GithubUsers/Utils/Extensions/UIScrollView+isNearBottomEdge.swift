//
//  UIScrollView+isNearBottomEdge.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/29/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    func isNearTheBottomEdge(offset: CGFloat = 100) -> Bool {
        return self.contentOffset.y + self.frame.size.height + offset >= self.contentSize.height
    }
}
