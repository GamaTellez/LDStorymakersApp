//
//  SpeakerDetailVC.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/23/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class SpeakerDetailVC: AppViewController {

    @IBOutlet var titleBarLabel: AppTitleLabel!
    @IBOutlet var speakerImageView: UIImageView!
    @IBOutlet var speakerBioTextView: UITextView!
    var presentationSpeaker:Speaker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSpeakerBioTextView()
        self.setTitleLabel()
        self.setUpSpeakerImageView()
    }

    private func setupSpeakerBioTextView() {
        self.speakerBioTextView.backgroundColor = UIColor.clear
        self.speakerBioTextView.font = UIFont(name: AppFonts.classCellTitleFont, size: 20)
        self.speakerBioTextView.textAlignment = .center
        guard let speakerBio = self.presentationSpeaker?.speakerBio else {
            self.speakerBioTextView.text = "Not Available"
            return
        }
        self.speakerBioTextView.text = speakerBio
    }
    
    private func setTitleLabel() {
        guard let speakerNameTitle = self.presentationSpeaker?.speakerName else {
            self.titleBarLabel.text = ""
            return
        }
        self.titleBarLabel.text = speakerNameTitle
    }
    
    private func setUpSpeakerImageView() {
        guard let speakerImage = self.presentationSpeaker?.getImage() else {
            return
        }
        let size = CGSize(width: speakerImage.size.width, height: speakerImage.size.height)
        self.speakerImageView.frame.size = size
        self.speakerImageView.image = speakerImage
    }

}
