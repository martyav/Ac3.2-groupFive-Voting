//
//  RepresentativesTableViewCell.swift
//  Vote
//
//  Created by Simone on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class RepresentativesTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - View Hierarchy and Constraints
    
    private func setupViewHierarchy () {
        self.contentView.addSubview(partyIcon)
        self.contentView.addSubview(nameLabel)
    }
    
    private func configureConstraints() {
        partyIcon.snp.makeConstraints { (view) in
            view.top.leading.equalToSuperview().offset(4)
            view.bottom.equalToSuperview().inset(4)
            view.height.width.equalTo(50)
        }
        nameLabel.snp.makeConstraints { (view) in
            view.leading.equalTo(partyIcon.snp.trailing).offset(4)
            view.centerY.equalToSuperview()
            view.trailing.equalToSuperview().inset(4)
        }
    }

    //MARK: Content Managing
    
    func loadOfficial(official: GovernmentOfficial) {
        self.nameLabel.text = official.name
        print(official.photoURL)
    }
    
    //MARK: - Views
    
    var partyIcon: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "republican")
        return view
    }()
    
    var nameLabel: UILabel = {
        let view = UILabel()
        return view
    }()
}
