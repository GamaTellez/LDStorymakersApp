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
       // func failedToAddClass()
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
        self.addRemoveScheduleItemButton.setTitle("Add", for: .normal)
        self.addRemoveScheduleItemButton.setTitle("Remove", for: .selected)
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
                self.createNewPersonalScheduledItemFromSelectedClass(sender: sender)
        } else {
            self.removeClassSelected(sender: sender)
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
        var selected = false
        guard let isCurrentClassInPersonalSchedule = self.classItem?.existsInPersonalSchedule else {
            selected = false
            return
        }
        if (isCurrentClassInPersonalSchedule) {
            selected = true
        } else {
            selected = false
        }
        UIView.transition(with: self.addRemoveScheduleItemButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.addRemoveScheduleItemButton.isSelected = selected
        }, completion: nil)
    }
    
    
    private func createNewPersonalScheduledItemFromSelectedClass(sender:UIButton) {
        guard let possiblePersonalScheduleClass = self.classItem else {
            return
            }
                PersonalScheduleItem.createPersonalScheduleItem(fromo: possiblePersonalScheduleClass) { (saved) in
                    if (saved) {
                        possiblePersonalScheduleClass.existsInPersonalSchedule = true
                        UIView.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve, animations: {
                            sender.isSelected = true
                        }, completion: nil)
                        guard let classDelegate = self.delegate else {
                            return
                        }
                        classDelegate.classAddedToSchedule()
                    } else {
                        print("failed to save new schedule item from cell")
                    }
                }
    }
    
    private func removeClassSelected(sender:UIButton) {
        guard let personalScheduleItemToDelete = PersonalScheduleItem.findPersonalScheduleItem(with: (self.classItem?.presentation?.title)!) else {
            return
        }
        StoreCoordinator().delete(object: personalScheduleItemToDelete)
        self.classItem?.existsInPersonalSchedule = false
        UIView.transition(with: self.addRemoveScheduleItemButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            sender.isSelected = false
        }, completion: nil)
        guard let classDelegate = self.delegate else {
            return
        }
        classDelegate.classRemovedFromSchedule()
    }
    
}




