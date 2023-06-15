//
//  ArrayTest.swift
//  MovieQuizTests
//
//  Created by Алексей Налимов on 16.06.2023.
//

import XCTest
@testable import MovieQuiz

class ArrayTest: XCTestCase {
    
    func testGetValueInRange() throws {
        
        //Given
        let array = [1, 2, 3, 4, 5]
        
        //When
        let value = array[safe: 2]

        //Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 3)
    }
    
    func testGetValueOutOfRange() {
        
        //Given
        let array = [1, 2, 3, 4, 5]
        
        //When
        let value = array[safe: 20]
        
        //Then
        XCTAssertNil(value)
        
    }
    
}
