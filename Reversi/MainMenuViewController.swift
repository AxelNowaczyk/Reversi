//
//  MainMenuViewController.swift
//  Reversi
//
//  Created by Axel Nowaczyk on 26.04.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.hidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private struct Seques{
        static let AIGame = "AIGame"
        static let PlayerGame = "PlayerGame"
    }
    private var whoStarts = Choice.Player1
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier{
                
            case Seques.AIGame:
                if let gvc = segue.destinationViewController as? GameViewController{
                    switch whoStarts{
                    case Choice.Player1: break
                    case Choice.Player2:
                        gvc.reversi.nextTurn
                    default: break
                    }
                    gvc.player2name = "AI"
                    gvc.ai = AI()
                }
            case Seques.PlayerGame: break
//                if let gvc = segue.destinationViewController as? GameViewController{
//                
//                }
            default: break
            }
        }
    }
//    @IBAction func AIPopupWhoStarts(sender: UIButton) {
//        let alert = UIAlertController(title: "Do you want to start", message: ""
//            , preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Yes",
//            style: UIAlertActionStyle.Default,handler: { _ in
//        }))
//        alert.addAction(UIAlertAction(title: "No",
//            style: UIAlertActionStyle.Default,handler: { _ in
//                self.whoStarts = Choice.Player2
//        }))
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
}
