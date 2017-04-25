//
//  ClassDetailView.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/23/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class ClassDetailView: AppViewController {

    var classSelected:PossiblePersonalScheduleItem?
    
    
    @IBOutlet var classSelectedTimeLabel: UILabel!
    @IBOutlet var classTitleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var viewAuthorButton: UIButton!
    @IBOutlet var classFeedBackButton: UIButton!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setUpClassTitleLabel()
//        self.setClassTimeLabel()
//        self.setUpLocationLabel()
//        self.setUpDescriptionTextView()
//        self.setupSpeakerButton()
//        self.setUpFeedBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpClassTitleLabel()
        //self.setClassTimeLabel()
        self.setUpLocationLabel()
        self.setUpDescriptionTextView()
        self.setupSpeakerButton()
        self.setUpFeedBackButton()
    }
        
    private func setUpClassTitleLabel() {
        self.classTitleLabel.font = UIFont(name: AppFonts.titlesFont, size: 25)
        self.classTitleLabel.numberOfLines = 2
        self.classTitleLabel.adjustsFontSizeToFitWidth = true
        self.classTitleLabel.backgroundColor = UIColor.clear
        guard let classTitle = self.classSelected?.presentation?.title else {
            self.classTitleLabel.text = "Not Available"
            return
        }
        self.classTitleLabel.text = classTitle
    }
    
//    private func setClassTimeLabel() {
//        self.classSelectedTimeLabel.font = UIFont(name: AppFonts.classCellTitleFont, size: 18)
//        self.classSelectedTimeLabel.backgroundColor = UIColor.clear
//        if let classTime = self.classSelected?.breakout?.breakoutShortFormatTimes() {
//            if let classDay = self.classSelected?.breakout?.getBreakoutDay() {
//                self.classSelectedTimeLabel.text = String(format:"%@ %@ - %@", classDay, classTime)
//            }
//        }
//    }
    
    private func setUpLocationLabel() {
        self.locationLabel.font = UIFont(name: AppFonts.classCellTitleFont, size: 20)
        self.locationLabel.backgroundColor = UIColor.clear
        guard let location = self.classSelected?.scheduleItem?.location else {
            self.locationLabel.text = "Not Available"
            return
        }
        self.locationLabel.text = location
    }
    
    private func setUpDescriptionTextView() {
        self.descriptionTextView.backgroundColor = UIColor.clear
        self.descriptionTextView.isEditable = false
        self.descriptionTextView.font = UIFont(name: AppFonts.classCellTitleFont, size: 20)
        self.descriptionTextView.textAlignment = .center
        guard let classDescriptionString = self.classSelected?.presentation?.presentationDescription else {
            self.descriptionTextView.text = "Not Available"
            return
        }
        self.descriptionTextView.text = classDescriptionString
    }

    private func setupSpeakerButton() {
        self.viewAuthorButton.backgroundColor = UIColor(red: 0.388, green: 0.392, blue: 0.400, alpha: 1.00)
        self.viewAuthorButton.tintColor = UIColor.white
        self.viewAuthorButton.layer.cornerRadius = 5
        guard let authorName =  self.classSelected?.speaker?.speakerName else {
            self.viewAuthorButton.isEnabled = false
            self.viewAuthorButton.isHidden = true
            return
        }
        self.viewAuthorButton.setTitle(authorName, for: .normal)
    }
    
    private func setUpFeedBackButton() {
        self.classFeedBackButton.backgroundColor = UIColor(red: 0.388, green: 0.392, blue: 0.400, alpha: 1.00)
        self.classFeedBackButton.tintColor = UIColor.white
        self.classFeedBackButton.layer.cornerRadius = 5
        self.classFeedBackButton.titleLabel?.text = "Feedback"
        
    }
    
    
    @IBAction func feedBackButtonTapped(_ sender: UIButton) {
        guard let classTitle = self.classSelected?.presentation?.title else {
            return
        }
        URLSession.openCourseFeedBack(classTitle: classTitle)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueID = segue.identifier,
        let presentationSpeaker = self.classSelected?.speaker
            else {
                return
        }
        if (segueID == "speakerDetail") {
            let speakerDetailView = segue.destination as! SpeakerDetailVC
            speakerDetailView.presentationSpeaker = presentationSpeaker
        }
    
    }
    
    
}

































