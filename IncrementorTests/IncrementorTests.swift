//
//  IncrementorTests.swift
//  IncrementorTests
//
//  Created by Anton Trofimenko on 11/03/2019.
//  Copyright © 2019 Anton Trofimenko. All rights reserved.
//

import XCTest
@testable import Incrementor

class IncrementorTests: XCTestCase {

    /// Тестирование Incrementor на отрицательное максимальное значение
    func testIncrementorMaxValueNegative() {
        var isErrorExists = false
        let negativeValue = -10
        let incrementor = Incrementor()
        do {
            try incrementor.setMaximumValue(negativeValue)
        } catch let error as NSError {
            isErrorExists = true
            XCTAssert(error.code == IncrementorErrorCode.MaxLessThanZero.rawValue, "Error should have MaxLessThanZero error code")
        }
        XCTAssert(isErrorExists, "Error should exists with negative maxValue")
    }
    
    /// Тестирование Incrementor на работу шага
    func testIncrementorCheckForIncrementStep() {
        let incrementor = Incrementor()
        incrementor.incrementNumber()
        let incrementSteps = 100
        for _ in 1..<incrementSteps {
            incrementor.incrementNumber()
        }
        XCTAssert(incrementor.getNumber() == incrementSteps, "Error with increment step")
    }
    
    // Тестирование Incrementor на правильное обнуление при достижении заданной границы
    func testIncrementorForValueReset() {
        let incrementor = Incrementor()
        let incrementSteps = 5
        do {
            try incrementor.setMaximumValue(incrementSteps)
            for _ in 0..<incrementSteps {
                incrementor.incrementNumber()
            }
            XCTAssert(incrementor.getNumber() == 0, "Error with incrementor overflow")
        } catch {
            XCTFail("Incrementor can't throw there in normal conditions")
        }
    }
    
    // Тестирование Incrementor на обнуление после смены maxValue
    func testIncrementorForResetValueAfterChangingMaxValue() {
        let incrementor = Incrementor()
        let incrementSteps = 10
        let newMaxValue = 5
        for _ in 1...incrementSteps {
            incrementor.incrementNumber()
        }
        do {
            try incrementor.setMaximumValue(newMaxValue)
            XCTAssert(incrementor.getNumber() == 0, "Error with incrementor reset after change max value")
        } catch {
            XCTFail("Incrementor can't throw there in normal conditions")
        }
    }

}
