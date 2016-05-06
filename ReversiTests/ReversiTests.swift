//
//  ReversiTests.swift
//  ReversiTests
//
//  Created by Axel Nowaczyk on 26.04.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import XCTest
@testable import Reversi

class ReversiTests: XCTestCase {
    
    let board = Board()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
//    func testPointEQ() {
//        let point1 = Point(2,y: 4)
//        let point2 = Point(2,y: 4)
//        XCTAssert(point1 == point2)
//    }
//    func testPointEQx() {
//        let point1 = Point(2,y: 5)
//        let point2 = Point(2,y: 4)
//        XCTAssert(point1 > point2)
//    }
//    func testPointEQy() {
//        let point1 = Point(2,y: 4)
//        let point2 = Point(1,y: 4)
//        XCTAssert(point1 > point2)
//    }
//    func testPointDiff() {
//        let point1 = Point(3,y: 5)
//        let point2 = Point(2,y: 4)
//        XCTAssert(point1 > point2)
//    }
//    func testPointSort() {
//        let sorted = [Point(5,y: 3),Point(3,y: 5),Point(2,y: 4),Point(4,y: 2)].sort()
//        let ok = [Point(2,y: 4),Point(3,y: 5),Point(4,y: 2),Point(5,y: 3)]
//        XCTAssert(sorted == ok)
//    }
//    
//    func testGivePossInitialP1() {
//        let poss = [Point(5,y: 3),Point(3,y: 5),Point(2,y: 4),Point(4,y: 2)].sort()
//        let res = board.givePossibleMoves(Choice.Player1).sort()
//        XCTAssert(poss == res)
//    }
//    func testGivePossInitialP2() {
//        let poss = [Point(2,y: 3),Point(3,y: 2),Point(5,y: 4),Point(4,y: 5)].sort()
//        let res = board.givePossibleMoves(Choice.Player2).sort()
//        XCTAssert(poss == res)
//    }
    //        board[3][4] = Choice.Player1
    //        board[3][5] = Choice.Player1
}
