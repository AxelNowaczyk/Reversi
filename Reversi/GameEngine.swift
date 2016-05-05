//
//  GameEngine.swift
//  Reversi
//
//  Created by Axel Nowaczyk on 03.05.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import Foundation

class GameEngine: CustomStringConvertible {
    var board = Board()
    private(set) var turn: Choice = Choice.Player1
    var nextTurn: Choice{
        get{
            defer{
                updateTurn()
                var posMoves = board.givePossibleMoves(turn)
                if posMoves.count == 0 {
                    updateTurn()
                    posMoves = board.givePossibleMoves(turn)
                    if posMoves.count == 0 {
                        print("no moves")
                    }
                }
            }
            return turn
        }
    }
    func givePossibleMoves() -> [Point] {
        return board.givePossibleMoves(turn)
    }
    private func updateTurn() {
        switch turn {
        case .Player1:
            turn = Choice.Player2
        case .Player2:
            turn = Choice.Player1
        default: break
        }
    }
    
    var description: String{
        return board.description
    }
}
class Board: CustomStringConvertible {

    private struct Size{
        static let Width = 8;
        static let Height = 8;
    }
    private(set) var board = [[Choice]]()
    
    init(){
        createBoard()
        createInitialPosition()
    }
    private func createBoard(){
        for _ in 0..<Size.Width {
            var newRaw = [Choice]()
            for _ in 0..<Size.Height {
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
        
//        board[3][4] = Choice.Player1
//        board[3][5] = Choice.Player1
    }

    func makeMove(player: Choice,position: Point) {
        guard board[position.x][position.y] == Choice.Nothing else {
            return
        }
        makeMove_Vertical_T(player,position: position)
        makeMove_Vertical_B(player,position: position)
        
        makeMove_Horizontal_L(player,position: position)
        makeMove_Horizontal_R(player,position: position)
        
        makeMove_Diagonal_BL(player,position: position)
        makeMove_Diagonal_BR(player,position: position)
        makeMove_Diagonal_TL(player,position: position)
        makeMove_Diagonal_TR(player,position: position)
    }
    private func makeMove_Vertical_T(player: Choice,position: Point) {

        let (thisPlayer, otherPlayer) = getPlayers(player)
        var x = position.x - 1
        while x >= 0 {
            defer{
                x -= 1
            }
            if board[x][position.y] == otherPlayer {
                continue
            }
            if board[x][position.y] == thisPlayer {
                for x_index in x...position.x {
                    board[x_index][position.y] = player
                }
            } else {
                return
            }
        }
    }
    private func makeMove_Vertical_B(player: Choice,position: Point) {
        let (thisPlayer, otherPlayer) = getPlayers(player)
        var x = position.x + 1
        while x < Size.Height {
            defer{
                x += 1
            }
            if board[x][position.y] == otherPlayer {
                continue
            }
            if board[x][position.y] == thisPlayer {
                for x_index in position.x...x {
                    board[x_index][position.y] = player
                }
            } else {
                return
            }
        }

    }
    private func makeMove_Horizontal_L(player: Choice,position: Point) {
        
        let (thisPlayer, otherPlayer) = getPlayers(player)
        var y = position.y - 1
        while y >= 0 {
            defer{
                y -= 1
            }
            if board[position.x][y] == otherPlayer {
                continue
            }
            if board[position.x][y] == thisPlayer {
                for y_index in y...position.y {
                    board[position.x][y_index] = player
                }
            } else {
                return
            }
        }
    }
    private func makeMove_Horizontal_R(player: Choice,position: Point) {
        let (thisPlayer, otherPlayer) = getPlayers(player)
        var y = position.y + 1
        while y < Size.Width {
            defer{
                y += 1
            }
            if board[position.x][y] == otherPlayer {
                continue
            }
            if board[position.x][y] == thisPlayer {
                for y_index in position.y...y {
                    board[position.x][y_index] = player
                }
            } else {
                return
            }
        }
    }
    private func makeMove_Diagonal_BL(player: Choice,position: Point) {
        
    }
    private func makeMove_Diagonal_BR(player: Choice,position: Point) {
        
    }
    private func makeMove_Diagonal_TL(player: Choice,position: Point) {
        
    }
    private func makeMove_Diagonal_TR(player: Choice,position: Point) {
        
    }
    func givePossibleMoves(player: Choice) -> [Point]{
        var possMoves = givePossibleMoves_Horizontal(player) +
        givePossibleMoves_Vertical(player) + givePossibleMoves_Diagonal(player)
        possMoves.uniqInPlace()
        return possMoves
        
    }
    private func givePossibleMoves_Horizontal(player: Choice) -> [Point]{
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
        case .Nothing:
            thisPlayer = Choice.Nothing
            otherPlayer = Choice.Nothing
        }
        return (thisPlayer, otherPlayer)
    }
    private func givePossibleMoves_Horizontal_LR(player: Choice) -> [Point]{
        var possibleMoves = [Point]()
        let (thisPlayer, otherPlayer) = getPlayers(player)

        for rowIndex in 0..<Size.Height {
            for colIndex in 0..<(Size.Width-1) {
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
                        possibleMoves.append(Point(colIndex2,y: rowIndex))
                    }
                    break
                }
            }
        }
        return possibleMoves
    }
    private func givePossibleMoves_Horizontal_RL(player: Choice) -> [Point]{
        var possibleMoves = [Point]()
        let (thisPlayer, otherPlayer) = getPlayers(player)
        
        for rowIndex in 0..<Size.Height {
            var colIndex = Size.Width-1
            while colIndex >= 1{
                defer{
                    colIndex -= 1
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
                        possibleMoves.append(Point(colIndex2,y: rowIndex))
                    }
                    break
                }
            }
        }
        return possibleMoves
    }
    private func givePossibleMoves_Vertical(player: Choice) -> [Point]{
        return givePossibleMoves_Vertical_TB(player)+givePossibleMoves_Vertical_BT(player)
    }
    private func givePossibleMoves_Vertical_TB(player: Choice) -> [Point]{
        var possibleMoves = [Point]()
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
                        possibleMoves.append(Point(colIndex,y: rowIndex2))
                    }
                    break
                }
            }
        }
        return possibleMoves
    }
    private func givePossibleMoves_Vertical_BT(player: Choice) -> [Point]{
        var possibleMoves = [Point]()
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
                        possibleMoves.append(Point(colIndex,y: rowIndex2))
                    }
                    break
                }
            }
        }
        return possibleMoves
    }
    private func givePossibleMoves_Diagonal(player: Choice) -> [Point]{
        return givePossibleMoves_Diagonal_LBRT(player) +
        givePossibleMoves_Diagonal_RTLB(player) +
        givePossibleMoves_Diagonal_RBLT(player) +
        givePossibleMoves_Diagonal_LTRB(player)
    }
    private func givePossibleMoves_Diagonal_LBRT(player: Choice) -> [Point]{
        
        let (thisPlayer, otherPlayer) = getPlayers(player)
        var possibleMoves = [Point]()
        for index in 0..<Size.Height{
            var y = index
            var x = 0
            while y >= 1 && x < (Size.Width - 1){
                defer{
                    y -= 1
                    x += 1
                }
                guard x != Size.Width-1 && y != 0 else {
                    continue
                }
                guard board[x][y] == thisPlayer else {
                    continue
                }
                guard board[x+1][y-1] == otherPlayer else {
                    continue
                }
                var x2 = x+2
                var y2 = y-2
                while y2 >= 0 && x2 < Size.Width{
                    defer{
                        y2 -= 1
                        x2 += 1
                    }
                    if board[x2][y2] == otherPlayer {
                        continue
                    } else if board[x2][y2] == Choice.Nothing{
                        possibleMoves.append(Point(x2,y: y2))
                        break
                    }
                }
            }
        }
        for index in 0..<Size.Width{
            var y = Size.Height-1
            var x = index
            while y >= 1 && x < (Size.Width-1){
                defer{
                    y -= 1
                    x += 1
                }
                guard board[x][y] == thisPlayer else {
                    continue
                }
                guard board[x+1][y-1] == otherPlayer else {
                    continue
                }
                var x2 = x+2
                var y2 = y-2
                while y2 >= 0 && x2 < Size.Width {
                    defer{
                        y2 -= 1
                        x2 += 1
                    }
                    if board[x2][y2] == otherPlayer {
                        continue
                    } else if board[x2][y2] == Choice.Nothing{
                        possibleMoves.append(Point(x2,y: y2))
                        break
                    }
                }
            }
        }
        return possibleMoves
    }
    private func givePossibleMoves_Diagonal_RTLB(player: Choice) -> [Point]{
        var possibleMoves = [Point]()
        let (thisPlayer, otherPlayer) = getPlayers(player)
        for index in 0..<Size.Width{
            var y = 0
            var x = index
            while x >= 1 && y < (Size.Height - 1){
                defer{
                    y += 1
                    x -= 1
                }
                guard board[x][y] == thisPlayer else {
                    continue
                }
                guard board[x-1][y+1] == otherPlayer else {
                    continue
                }
                var x2 = x-2
                var y2 = y+2
                while x2 >= 0 && y2 < Size.Height {
                    defer{
                        y2 += 1
                        x2 -= 1
                    }
                    if board[x2][y2] == otherPlayer {
                        continue
                    } else if board[x2][y2] == Choice.Nothing{
                        possibleMoves.append(Point(x2,y: y2))
                        break
                    }
                }
            }
        }
        for index in 0..<Size.Width{
            var y = index
            var x = Size.Width-1
            while y < (Size.Height - 1) && x >= 1 {
                defer{
                    y += 1
                    x -= 1
                }
                guard board[x][y] == thisPlayer else {
                    continue
                }
                guard board[x-1][y+1] == otherPlayer else {
                    continue
                }
                var x2 = x-2
                var y2 = y+2
                while y2 < Size.Height && x2 < Size.Width {
                    defer{
                        y2 += 1
                        x2 -= 1
                    }
                    if board[x2][y2] == otherPlayer {
                        continue
                    } else if board[x2][y2] == Choice.Nothing{
                        possibleMoves.append(Point(x2,y: y2))
                        break
                    }
                }
            }
        }
        
        return possibleMoves
    }
    private func givePossibleMoves_Diagonal_RBLT(player: Choice) -> [Point]{
        
        let (thisPlayer, otherPlayer) = getPlayers(player)
        var possibleMoves = [Point]()
        var index = Size.Width-1
        while index >= 0{
            defer{
                index -= 1
            }
            var y = Size.Height-1
            var x = index
            while x >= 1 && y >= 1{
                defer{
                    y -= 1
                    x -= 1
                }
                guard board[x][y] == thisPlayer else {
                    continue
                }
                guard board[x-1][y-1] == otherPlayer else {
                    continue
                }
                var x2 = x-2
                var y2 = y-2
                while x2 >= 0 && y2 >= 0 {
                    defer{
                        y2 -= 1
                        x2 -= 1
                    }
                    if board[x2][y2] == otherPlayer {
                        continue
                    } else if board[x2][y2] == Choice.Nothing{
                        possibleMoves.append(Point(x2,y: y2))
                        break
                    }
                }
            }
        }
        
        index = Size.Height-1
        while index >= 0{
            defer{
                index -= 1
            }
            var y = index
            var x = Size.Width-1
            while y >= 1 && x >= 1{
                defer{
                    y -= 1
                    x -= 1
                }
                guard board[x][y] == thisPlayer else {
                    continue
                }
                guard board[x-1][y-1] == otherPlayer else {
                    continue
                }
                var x2 = x-2
                var y2 = y-2
                while y2 >= 0 && x2 >= 0 {
                    defer{
                        y2 -= 1
                        x2 -= 1
                    }
                    if board[x2][y2] == otherPlayer {
                        continue
                    } else if board[x2][y2] == Choice.Nothing{
                        possibleMoves.append(Point(x2,y: y2))
                        break
                    }
                }
            }
        }
        
        return possibleMoves
    }
    private func givePossibleMoves_Diagonal_LTRB(player: Choice) -> [Point]{
        
        let (thisPlayer, otherPlayer) = getPlayers(player)
        var possibleMoves = [Point]()
        var index = 0
        while index < Size.Height{
            defer{
                index += 1
            }
            var y = index
            var x = 0
            while y < (Size.Height - 1) && x < (Size.Width - 1){
                defer{
                    y += 1
                    x += 1
                }
                guard board[x][y] == thisPlayer else {
                    continue
                }
                guard board[x+1][y+1] == otherPlayer else {
                    continue
                }
                var x2 = x+2
                var y2 = y+2
                while y2 < Size.Height && x2 < Size.Width {
                    defer{
                        y2 += 1
                        x2 += 1
                    }
                    if board[x2][y2] == otherPlayer {
                        continue
                    } else if board[x2][y2] == Choice.Nothing{
                        possibleMoves.append(Point(x2,y: y2))
                        break
                    }
                }
            }
        }
        
        index = 0
        while index < Size.Width{
            defer{
                index += 1
            }
            var y = 0
            var x = index
            while y < (Size.Height - 1) && x < (Size.Width - 1) {
                defer{
                    y += 1
                    x += 1
                }
                guard board[x][y] == thisPlayer else {
                    continue
                }
                guard board[x+1][y+1] == otherPlayer else {
                    continue
                }
                var x2 = x+2
                var y2 = y+2
                while y2 < Size.Height && x2 < Size.Height {
                    defer{
                        y2 += 1
                        x2 += 1
                    }
                    if board[x2][y2] == otherPlayer {
                        continue
                    } else if board[x2][y2] == Choice.Nothing{
                        possibleMoves.append(Point(x2,y: y2))
                        break
                    }
                }
            }
        }
        
        return possibleMoves
    }
    func getScore(of player: Choice) -> Int {
        var score = 0
        for y in 0..<Size.Height {
            for x in 0..<Size.Width {
                if player == board[x][y]{
                    score += 1
                }
            }
        }
        return score
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
private extension Array where Element: Equatable {
    
    mutating func uniqInPlace() {
        var seen = [Element]()
        var index = 0
        for element in self {
            if seen.contains(element) {
                removeAtIndex(index)
            } else {
                seen.append(element)
                index += 1
            }
        }
    }
}
struct Point: Comparable, Hashable {
    let x: Int
    let y: Int
    init(_ x:Int, y: Int){
        self.x = x
        self.y = y
    }
    var hashValue: Int{
        return x*10+y
    }
}
func ==(lhs: Point, rhs: Point) -> Bool{
    return lhs.hashValue == rhs.hashValue
}
func <(lhs: Point, rhs: Point) -> Bool{
    return lhs.hashValue < rhs.hashValue
}

enum Choice {
    case Nothing, Player1, Player2
}