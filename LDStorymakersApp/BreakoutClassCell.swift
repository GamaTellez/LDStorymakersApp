//
//  BreakoutClassCell.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/18/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

protocol PersonalScheduleModifiedDelegate {
        func classAddedToSchedule()
        func classRemovedFromSchedule()
}

class BreakoutClassCell: UITableViewCell {
    
    var delegate:PersonalScheduleModifiedDelegate?
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
            guard let possiblePersonalScheduleClass = self.classItem else {
                return
            }
            PersonalScheduleItem.createPersonalScheduleItem(fromo: possiblePersonalScheduleClass) { (saved) in
                if (saved) {
                    possiblePersonalScheduleClass.existsInPersonalSchedule = true
                    sender.isSelected = true
                    sender.backgroundColor = self.selectedColor
                    guard let classDelegate = self.delegate else {
                        return
                    }
                    classDelegate.classAddedToSchedule()
                } else {
                print("failed to save new schedule item from cell")
                }
            }
        } else {
            guard let personalScheduleItemToDelete = PersonalScheduleItem.findPersonalScheduleItem(with: (self.classItem?.presentation?.title)!) else {
                return
            }
            StoreCoordinator().context.delete(personalScheduleItemToDelete)
            self.classItem?.existsInPersonalSchedule = false
            sender.isSelected = false
            sender.backgroundColor = self.notSelectedColor
            guard let classDelegate = self.delegate else {
                return
            }
            classDelegate.classRemovedFromSchedule()
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.checkIfClassExistInPersonalSchedule()
    }

    internal func loadInfoInCellViews() {
        self.checkIfClassExistInPersonalSchedule()
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
    
    private func checkIfClassExistInPersonalSchedule() {
        guard let isCurrentClassInPersonalSchedule = self.classItem?.existsInPersonalSchedule else {
            self.addRemoveScheduleItemButton.isSelected = false
            self.addRemoveScheduleItemButton.backgroundColor = self.notSelectedColor
            return
        }
        if (isCurrentClassInPersonalSchedule) {
            self.addRemoveScheduleItemButton.isSelected = true
            self.addRemoveScheduleItemButton.backgroundColor = self.selectedColor
        } else {
            self.addRemoveScheduleItemButton.isSelected = false
            self.addRemoveScheduleItemButton.backgroundColor = self.notSelectedColor
        }
    }
    
}
