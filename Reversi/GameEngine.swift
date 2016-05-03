//
//  GameEngine.swift
//  Reversi
//
//  Created by Axel Nowaczyk on 03.05.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import Foundation

//class GameEngine: CustomStringConvertible {
//    var
//}
class Board: CustomStringConvertible {

    private struct Size{
        static let Width = 8;
        static let Height = 8;
    }
    private var board = [[Choice]]()
    
    init(){
        createBoard()
        createInitialPosition()
    }
    private func createBoard(){
        for _ in 0..<Size.Height {
            var newRaw = [Choice]()
            for _ in 0..<Size.Width {
                newRaw.append(Choice.Nothing)
            }
            board.append(newRaw)
        }
    }
    private func createInitialPosition(){
        board[3][3] = Choice.Player1
        board[4][4] = Choice.Player1
        
        board[3][4] = Choice.Player2
        board[4][3] = Choice.Player2
    }
    func givePossibleMoves(player: Choice) -> [(Int,Int)]{//change to sets
        return givePossibleMoves_Horizontal(player) +
        givePossibleMoves_Vertical(player) + givePossibleMoves_Diagonal(player)
        
    }
    private func givePossibleMoves_Horizontal(player: Choice) -> [(Int,Int)]{
        return givePossibleMoves_Horizontal_LR(player) + givePossibleMoves_Horizontal_RL(player)
    }
    private func getPlayers(player: Choice) -> (Choice,Choice){
        var thisPlayer: Choice, otherPlayer: Choice
        switch player {
        case .Player1:
            thisPlayer = Choice.Player1
            otherPlayer = Choice.Player2
        case .Player2:
            thisPlayer = Choice.Player2
            otherPlayer = Choice.Player1
        case .Nothing://inpossible case
            thisPlayer = Choice.Nothing
            otherPlayer = Choice.Nothing
        }
        return (thisPlayer, otherPlayer)
    }
    private func givePossibleMoves_Horizontal_LR(player: Choice) -> [(Int,Int)]{
        var possibleMoves = [(Int,Int)]()
        let (thisPlayer, otherPlayer) = getPlayers(player)

        for rowIndex in 0..<Size.Height {
            for colIndex in 0..<Size.Width {
                guard colIndex != Size.Width-1 else {
                    continue
                }
                guard board[colIndex][rowIndex] == thisPlayer else {
                    continue
                }
                guard board[colIndex+1][rowIndex] == otherPlayer else {
                    continue
                }
                
                for colIndex2 in colIndex+2..<Size.Width {
                    if board[colIndex2][rowIndex] == otherPlayer {
                        continue
                    } else if board[colIndex2][rowIndex] == Choice.Nothing{
                        possibleMoves.append((colIndex2,rowIndex))
                        break
                    }
                }

            }
        }
        return possibleMoves
    }
    private func givePossibleMoves_Horizontal_RL(player: Choice) -> [(Int,Int)]{
        var possibleMoves = [(Int,Int)]()
        let (thisPlayer, otherPlayer) = getPlayers(player)
        
        for rowIndex in 0..<Size.Height {
            var colIndex = Size.Width-1
            while colIndex >= 0{
                defer{
                    colIndex -= 1
                }
                guard colIndex != 0 else {
                    continue
                }
                guard board[colIndex][rowIndex] == thisPlayer else {
                    continue
                }
                guard board[colIndex-1][rowIndex] == otherPlayer else {
                    continue
                }
                var colIndex2 = colIndex-2
                while colIndex2 >= 0 {
                    defer{
                        colIndex2 -= 1
                    }
                    if board[colIndex2][rowIndex] == otherPlayer {
                        continue
                    } else if board[colIndex2][rowIndex] == Choice.Nothing{
                        possibleMoves.append((colIndex2,rowIndex))
                        break
                    }
                }
            }
        }
        return possibleMoves
    }
    private func givePossibleMoves_Vertical(player: Choice) -> [(Int,Int)]{
        return givePossibleMoves_Vertical_TB(player)+givePossibleMoves_Vertical_BT(player)
    }
    private func givePossibleMoves_Vertical_TB(player: Choice) -> [(Int,Int)]{
        var possibleMoves = [(Int,Int)]()
        let (thisPlayer, otherPlayer) = getPlayers(player)
        
        for colIndex in 0..<Size.Width {
            for rowIndex in 0..<Size.Height {
                guard rowIndex != Size.Height-1 else {
                    continue
                }
                guard board[colIndex][rowIndex] == thisPlayer else {
                    continue
                }
                guard board[colIndex][rowIndex+1] == otherPlayer else {
                    continue
                }
                for rowIndex2 in rowIndex+2..<Size.Width {
                    if board[colIndex][rowIndex2] == otherPlayer {
                        continue
                    } else if board[colIndex][rowIndex2] == Choice.Nothing{
                        possibleMoves.append((colIndex,rowIndex2))
                        break
                    }
                }
            }
        }
        return possibleMoves
    }
    private func givePossibleMoves_Vertical_BT(player: Choice) -> [(Int,Int)]{
        var possibleMoves = [(Int,Int)]()
        let (thisPlayer, otherPlayer) = getPlayers(player)
        
        for colIndex in 0..<Size.Width {
            var rowIndex = Size.Height-1
            while rowIndex >= 0{
                defer{
                    rowIndex -= 1
                }
                guard rowIndex != 0 else {
                    continue
                }
                guard board[colIndex][rowIndex] == thisPlayer else {
                    continue
                }
                guard board[colIndex][rowIndex-1] == otherPlayer else {
                    continue
                }
                var rowIndex2 = rowIndex-2
                while rowIndex2 >= 0 {
                    defer{
                        rowIndex2 -= 1
                    }
                    if board[colIndex][rowIndex2] == otherPlayer {
                        continue
                    } else if board[colIndex][rowIndex2] == Choice.Nothing{
                        possibleMoves.append((colIndex,rowIndex2))
                        break
                    }
                }
            }
        }
        return possibleMoves
    }
    private func givePossibleMoves_Diagonal(player: Choice) -> [(Int,Int)]{
        var possibleMoves = [(Int,Int)]()
        return possibleMoves
    }
    var description: String{
        var returnString = "Board:\n"
        
        for raw in board {
            var wholeRaw = ""
            for col in raw {
                wholeRaw += "\(col), "
            }
            returnString += wholeRaw + "\n"
        }
        return returnString
    }
}

enum Choice {
    case Nothing, Player1, Player2
}