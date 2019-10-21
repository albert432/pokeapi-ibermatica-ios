//
//  PokemonCell.swift
//  Ibermatica-iOS
//
//  Copyright © 2019 Albert. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    // MARK: - OUTLETS
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = Color.text
        }
    }
    
    @IBOutlet weak var disclosureImageView: UIImageView! {
        didSet {
            disclosureImageView.tintColor = Color.primaryDark
        }
    }
    
    // MARK: - PROPERTIES
    var pokemonID: Int?
    
    // MARK: - ACTIONS
    // MARK: - FUNCTIONS

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
