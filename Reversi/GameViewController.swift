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
    var reversi = GameEngine()
    
    @IBOutlet var bigView: UIView!
    
    private struct Board{
        static let height   = 8
        static let width    = 8
    }
    private struct PlayerColor{
        static let Player1  = UIColor.redColor()
        static let Player2  = UIColor.blueColor()
        static let NoOne    = UIColor.whiteColor()
    }
    var cells = [[UIView]]()
    
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
        updateBoard()
    }
    func updateBoard() {
        for y in 0..<Board.height {
            for x in 0..<Board.width {
                
                switch reversi.board.board[x][y] {
                case .Player1:
                    cells[x][y].backgroundColor = PlayerColor.Player1
                case .Player2:
                    cells[x][y].backgroundColor = PlayerColor.Player2
                case .Nothing:
                    cells[x][y].backgroundColor = PlayerColor.NoOne
                }
            }
        }
    }
    private func createCells(){
        for height in 0..<Board.height{
            var row = [UIView]()
            for width in 0..<Board.width{
                let origin = CGPoint(x: CGFloat(width)*cellSize.width, y: CGFloat(height)*cellSize.height)
                let frame = CGRect(origin: origin,size: cellSize)
                let cellView = UIView(frame: frame)
                cellView.tag = height*10+width // consists of 2 ints 1st height, 2nd width
                cellView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GameViewController.viewTapped(_:))))
                gameView.addSubview(cellView)
                row.append(cellView)
            }
            cells.append(row)
            
        }
    }
    func viewTapped(sender: AnyObject){
        let tap = sender as! UITapGestureRecognizer
        if let view = tap.view{
            view.backgroundColor = UIColor.yellowColor()
            print(view.tag)
        }
        updateBoard()
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