//
//  T3Cell.swift
//  TicTacToe4x4
//
//  Created by DCS on 08/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class T3Cell: UICollectionViewCell {
    private let myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setupCell(with status:Int){
        
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 2
        contentView.addSubview(myImageView)
        
        myImageView.frame = CGRect(x:0, y:0, width:70, height: 70)
        let name = (status == 0) ? ("circle") : (status == 1 ? "multiply" : "")
        myImageView.image = UIImage(named: name)
    }
}

