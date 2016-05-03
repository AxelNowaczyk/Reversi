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
    
    @IBOutlet var bigView: UIView!
    private struct Board{
        static let height   = 8
        static let width    = 8
    }
    
    var cells = [UIView]()
//    var gameViewHeight: CGFloat{
//        return gameView.bounds.size.height - (self.navigationController?.size preferredContentSize.height)!
//    }
    

    
    var cellSize: CGSize{
        let width   = gameView.bounds.size.width / CGFloat(Board.width)
        let height  = gameView.bounds.size.height / CGFloat(Board.height)
        return CGSize(width: width, height: height)
    }
    var horizontalLineSize: CGSize{
        let width   = CGFloat(2)
        let height  = gameView.bounds.size.height
        return CGSize(width: width, height: height)
    }
    var verticalLineSize: CGSize{
        let width   = gameView.bounds.size.width
        let height  = CGFloat(2)
        return CGSize(width: width, height: height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.hidden = false
    }

    override func viewDidLayoutSubviews() {
        createCells()
        drawLines()
    }
    
    private func createCells(){
        var counter = 0
        for width in 0..<Board.width{
            for height in 0..<Board.height{
                defer{
                    counter+=1
                }
                let origin = CGPoint(x: CGFloat(width)*cellSize.width, y: CGFloat(height)*cellSize.height)
                let frame = CGRect(origin: origin,size: cellSize)
                let cellView = UIView(frame: frame)
                cellView.backgroundColor = UIColor.whiteColor()
                cellView.tag = counter
                cellView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GameViewController.viewTapped(_:))))
                gameView.addSubview(cellView)
                cells.append(cellView)
            }
        }
    }
    func viewTapped(sender: UIView){
        print("tap \(sender.tag)")
    }
    private func drawLines(){
        for width in 0...Board.width{
            let horizontalLine = CGRect(origin: CGPoint(x: CGFloat(width)*cellSize.width-1, y: CGFloat(0)),size: horizontalLineSize)
            let cellView = UIView(frame: horizontalLine)
            cellView.backgroundColor = UIColor.blackColor()
            gameView.addSubview(cellView)
        }
        for height in 0...Board.height{
            let verticalLine = CGRect(origin: CGPoint(x: CGFloat(0), y: CGFloat(height)*cellSize.height-1),size: verticalLineSize)
            let cellView = UIView(frame: verticalLine)
            cellView.backgroundColor = UIColor.blackColor()
            gameView.addSubview(cellView)
        }
    }
}