//
//  uguideTests.swift
//  uguideTests
//
//  Created by Hannibal B. Moulvad on 03/05/2018.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import XCTest
@testable import uguide

class CourseLocationModelTest: XCTestCase {
    
    func InitializeCourseLocationShouldReturnNotNil() {
        let courseLocationDic = [
            "campus" : "Lyngby",
            "building" : "324",
            "room" : "30",
            ]
        let testCourseLocation = CourseLocation(dictionary: courseLocationDic)
        XCTAssertNotNil(testCourseLocation)
    }
    
    func InitializeCourseLocationWithoutCampusShouldReturnNil() {
        let courseLocationDic = [
            "campus" : "",
            "building" : "324",
            "room" : "",
            ]
        
        let testCourseLocation = CourseLocation(dictionary: courseLocationDic)
        
        XCTAssertNil(testCourseLocation)
    }
    
}
