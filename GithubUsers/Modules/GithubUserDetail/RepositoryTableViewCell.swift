//
//  RepositoryTableViewCell.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/29/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    func bind(repository: Repository){
        self.nameLabel.text = repository.name
    }
}
