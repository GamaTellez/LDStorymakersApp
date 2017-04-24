//
//  BreakoutClassCell.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/18/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class BreakoutClassCell: UITableViewCell {

    static let identifier = "brakoutClassCell"
    
    @IBOutlet var detailDisclosureImage: UIImageView!
    @IBOutlet var scheduleItemTitle: UILabel!
    @IBOutlet var addRemoveScheduleItemButton: UIButton!
    @IBOutlet var scheduleItemSpeaker: UILabel!
    var classItem:PossiblePersonalScheduleItem?
    let selectedColor = UIColor(red: 0.988, green: 0.051, blue: 0.106, alpha: 1.00)
    let notSelectedColor = UIColor(red: 0.090, green: 0.647, blue: 0.333, alpha: 1.00)
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpViews()
    }
    
    private func setUpViews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        //self.addRemoveScheduleItemButton.isSelected = false
        self.addRemoveScheduleItemButton.setBackgroundImage(UIImage(named:"add")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.addRemoveScheduleItemButton.backgroundColor = self.notSelectedColor
        self.addRemoveScheduleItemButton.setBackgroundImage(UIImage(named:"remove")?.withRenderingMode(.alwaysTemplate), for: .selected)
        self.addRemoveScheduleItemButton.tintColor = UIColor.white
        self.addRemoveScheduleItemButton.layer.cornerRadius = self.addRemoveScheduleItemButton.frame.width / 2
        self.addRemoveScheduleItemButton.clipsToBounds = true
        
        self.scheduleItemTitle.numberOfLines = 0
        self.scheduleItemTitle.lineBreakMode = .byWordWrapping
        self.scheduleItemTitle.font = UIFont(name: AppFonts.classCellTitleFont, size: 20)
        self.scheduleItemTitle.backgroundColor = UIColor(red: 0.388, green: 0.392, blue: 0.400, alpha: 1.00)
        self.scheduleItemTitle.textColor = UIColor.white
        
        self.scheduleItemSpeaker.numberOfLines = 0
        self.scheduleItemSpeaker.lineBreakMode = .byWordWrapping
        self.scheduleItemSpeaker.font = UIFont(name: AppFonts.titlesFont, size: 17)
        self.scheduleItemSpeaker.backgroundColor = UIColor.white
        
        self.detailDisclosureImage.image = UIImage(named:"detailDisclosure")?.withRenderingMode(.alwaysTemplate)
    }
    
    @IBAction func addRemoveScheduleItemButtonTapped(_ sender: UIButton) {
        if (!sender.isSelected) {
            sender.isSelected = true
            sender.backgroundColor = self.selectedColor
        } else if (sender.isSelected) {
            sender.isSelected = false
            sender.backgroundColor = self.notSelectedColor
        }
        
        
        //        guard let classToSave = self.classItem else {
//            return
//        }
//        
//        StoreCoordinator().save { (saved) in
//            if (saved) {
//                
//            } else {
//                
//            }
//        }
    }
    
    override func prepareForReuse() {
        
    }
    
    
    internal func loadInfoInCellViews() {
        guard let classTitle = self.classItem?.scheduleItem?.presentationTitle else {
            self.scheduleItemTitle.text = "Not Available"
            return
        }
        self.scheduleItemTitle.text = classTitle
    
        guard let classSpeaker = self.classItem?.speaker?.speakerName else {
            self.scheduleItemSpeaker.text = "Not Available"
            return
        }
        self.scheduleItemSpeaker.text = classSpeaker
    }
}
