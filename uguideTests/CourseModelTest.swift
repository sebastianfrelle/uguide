//
//  CourseModelTest.swift
//  uguideTests
//
//  Created by Hannibal B. Moulvad on 03/05/2018.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import XCTest
@testable import uguide

class CourseModelTest: XCTestCase {
    
    func testInitializeCourseShouldReturnNotNil() {
        let courseDic : [String: Any] = [
            "name": "TestCourse",
            "id" : "02323",
            "courseLocation": [
                "campus" : "Lyngby",
                "building" : "324",
                "room" : "30",
            ],
            "placeId" : "30",
            ]
        
        let testCourse = Course(dictionary: courseDic)
        XCTAssertNotNil(testCourse)
    }
    
    func testInitializeCourseWithoutIdShouldReturnNil() {
        let courseDic : [String: Any] = [
            "name": "TestCourse",
            "courseLocation": [
                "campus" : "Lyngby",
                "building" : "324",
                "room" : "30",
            ],
            "placeid" : "30",
            ]
        
        let testCourse = Course(dictionary: courseDic)
        
        XCTAssertNil(testCourse)
    }
    
}
