//
//  GameViewController.swift
//  Reversi
//
//  Created by Axel Nowaczyk on 26.04.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameView: UIView!
    
    private struct Board{
        static let height   = 8
        static let width    = 8
    }
    
    var cells = [UIView]()
    
    var cellSize: CGSize{
        let width   = gameView.bounds.size.width / CGFloat(Board.width)
        let height  = gameView.bounds.size.height / CGFloat(Board.height)
        return CGSize(width: width, height: height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         createCells()
        self.navigationController!.navigationBar.hidden = false
    }

    private func createCells(){
        for width in 0..<Board.width{
            for height in 0..<Board.height{
                let frame = CGRect(origin: CGPoint(x: CGFloat(width)*cellSize.width, y: CGFloat(height)*cellSize.height),size: cellSize)
                
                let cellView = UIView(frame: frame)
                cellView.backgroundColor = UIColor.randomColor
                
                gameView.addSubview(cellView)
                cells.append(cellView)
            }
        }
    }
}
private extension UIColor{
    class var randomColor: UIColor{
        switch arc4random()%7{
        case 0: return UIColor.redColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.brownColor()
        case 3: return UIColor.grayColor()
        case 4: return UIColor.greenColor()
        case 5: return UIColor.purpleColor()
        default: return UIColor.yellowColor()
            
        }
    }
}