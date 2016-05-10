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
                    GameViewController.PlayerName.Player2 = "AI"
                    gvc.ai = AI()
                }
//            case Seques.PlayerGame: break
//                if let gvc = segue.destinationViewController as? GameViewController{
//                
//                }
            default: break
            }
        }
    }
}
