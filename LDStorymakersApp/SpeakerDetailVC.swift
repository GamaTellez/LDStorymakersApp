//
//  SpeakerDetailVC.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/23/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class SpeakerDetailVC: AppViewController {

    @IBOutlet var closeButton: UIButton!
    @IBOutlet var titleBarLabel: AppTitleLabel!
    @IBOutlet var speakerImageView: UIImageView!
    @IBOutlet var speakerBioTextView: UITextView!
    var presentationSpeaker:Speaker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSpeakerBioTextView()
        self.setTitleLabel()
        self.setUpSpeakerImageView()
        self.setupCloseButton()
    }

    private func setupSpeakerBioTextView() {
        self.speakerBioTextView.backgroundColor = UIColor.clear
        self.speakerBioTextView.isEditable = false
        self.speakerBioTextView.font = UIFont(name: AppFonts.classCellTitleFont, size: 20)
        self.speakerBioTextView.textAlignment = .center
        guard let speakerBio = self.presentationSpeaker?.speakerBio else {
            self.speakerBioTextView.text = "Not Available"
            return
        }
        self.speakerBioTextView.text = speakerBio
    }
    
    private func setTitleLabel() {
        self.titleBarLabel.numberOfLines = 2
        guard let speakerNameTitle = self.presentationSpeaker?.speakerName else {
            self.titleBarLabel.text = ""
            return
        }
        self.titleBarLabel.text = "\n" + speakerNameTitle
    }
    
    private func setUpSpeakerImageView() {
        self.speakerImageView.sizeToFit()
        guard let speakerImage = self.presentationSpeaker?.getImage() else {
            self.speakerImageView.image = UIImage(named: "speakerImage")?.withRenderingMode(.alwaysTemplate)
            self.speakerImageView.tintColor = UIColor.white
            return
        }
        self.speakerImageView.image = speakerImage
    }

    private func setupCloseButton() {
    
        self.closeButton.setImage(UIImage(named:"close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.closeButton.tintColor = UIColor.white
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
