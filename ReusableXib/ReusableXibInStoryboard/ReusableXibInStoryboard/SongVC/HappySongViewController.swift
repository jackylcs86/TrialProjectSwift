//
//  HappySongViewController.swift
//  ReusableXibInStoryboard
//
//  Created by Jackylcs on 08/03/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import UIKit

class HappySongViewController: SongViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        for songLabel in songLabels {
            songLabel.text = "Happy Song \(songLabels.index(of: songLabel) ?? 99)";
        }
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
