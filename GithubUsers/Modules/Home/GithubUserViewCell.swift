//
//  GithubUserViewCell.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/29/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class GithubUserViewCell: UICollectionViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    func bind(user: GithubUser){
        self.avatarImage.af_setImage(withURL: URL(string: user.avatarUrl)!)
        self.usernameLabel.text = user.username
    }
}
