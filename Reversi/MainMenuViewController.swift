//
//  MainMenuViewController.swift
//  Reversi
//
//  Created by Axel Nowaczyk on 26.04.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    let board = Board()
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.hidden = true
        print(board.description)
        print(board.givePossibleMoves(Choice.Player1))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private struct Seques{
        static let AIGame = "AIGame"
        static let PlayerGame = "PlayerGame"
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier{
                
            case Seques.AIGame: break
//                if let gvc = segue.destinationViewController as? GameViewController{
//                    gvc.
//                }
            case Seques.PlayerGame: break
//                if let gvc = segue.destinationViewController as? GameViewController{
//                
//                }
            default: break
            }
        }
    }
}
