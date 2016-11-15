//
//  HomeView.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 11/14/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class HomeView: UIViewController {
    lazy var urlSession = URLSession.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        URLSession().getAllSpreadSheetkeys { (succeded) in
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
