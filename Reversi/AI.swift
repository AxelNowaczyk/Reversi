//
//  Player.swift
//  Reversi
//
//  Created by Axel Nowaczyk on 03.05.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import Foundation
import UIKit

class AI {

    private var scores: [[Int]]?
    
    init(){
        scores = importScoresFromFile("weights")
    }
    func getMove(gameEngine ge: GameEngine, depth: Int) -> Point?{
        return minmax(gameEngine: ge, depth: depth)?.1
    }
    
    private func minmax(gameEngine ge: GameEngine, depth: Int) -> (Int, Point)?{
       
        guard depth != 0 && ge.gameover == false else {
            if let score = evaluate(ge.board, player: ge.turn){
                return (score, Point(-1, y: -1))
            }
            return nil
        }
        var bestScore: (Int, Point)?
        let possibleMoves = ge.givePossibleMoves()
        
        for move in possibleMoves {
            let nextGE = GameEngine(gameEngine: ge)
            nextGE.makeMove(move)
            nextGE.nextTurn
            guard let minmax = minmax(gameEngine: nextGE, depth: depth-1) else{
                return nil
            }
            let score = (minmax.0,move)
            
            switch ge.turn {
            case Choice.Player2: // ai, needs to maximize this one
                if bestScore == nil || score.0 > bestScore?.0 {
                    bestScore = score
                }
            case Choice.Player1: // player, needs to be minimize
                if bestScore == nil || score.0 < bestScore?.0 {
                    bestScore = score
                }
            default: break
            }
        }
        return bestScore
    }
    
    private func evaluate(board: Board, player: Choice) -> Int?{
        guard let scores = scores else {
            return nil
        }
        
        var score: Int = 0
        
        for x in 0..<board.board.count{
            for y in 0..<board.board[x].count{
                switch board.board[x][y] {
                case Choice.Nothing:
                    continue
                case player:
                    score += scores[x][y]
                default:
                    score -= scores[x][y]
                }
            }
        }
        return score
    }
    
    private func importScoresFromFile(fileName: String) -> [[Int]]? {
        guard let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt") else {
            return nil
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: NSUTF8StringEncoding)
            let contentInRows = content.componentsSeparatedByString("\n")
            var scores = [[Int]]()
            for r in contentInRows{
                let contentInCol = r.componentsSeparatedByString(",")
                var row = [Int]()
                for c in contentInCol {
                    row.append(Int(c)!)
                }
                scores.append(row)
            }
            return scores
        } catch _ as NSError {
            return nil
        }
    }
}