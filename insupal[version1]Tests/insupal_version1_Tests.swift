//
//  insupal_version1_Tests.swift
//  insupal[version1]Tests
//
//  Created by cherrycat on 2018-06-30.
//  Copyright © 2018 cherrycat. All rights reserved.
//

import XCTest
@testable import insupal_version1_

//tempGoalClass
class insupal_version1_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetDescription()
    {
        let testDescription = "Description1"
        let goal = Goal(goalDescription : testDescription, specifics : "This is a goal specific", due : "04/07/2018")
        XCTAssertEqual(goal?.getDescription(),testDescription, "Returned description is wrong: in getDescription")
        
        //(goalDescription : String, specifics:String, due:String)
        
    }
    
    func testSetDescription()
    {
        let testDescription = "Description1"
        let newDescription = "Description2"
        let goal = Goal(goalDescription: testDescription, specifics:"This is a goal specific", due:"04/07/2018")
        
        goal?.setDescription(goal : newDescription)
        
        XCTAssertEqual(goal?.getDescription(),newDescription, "Returned description is wrong: In setDescription")
        
    }
    
    
    func testGetSpecifics()
    {
        let testSpecifics = "Specifics1"
        let goal = Goal(goalDescription: "Description1", specifics: testSpecifics, due:"04/07/2018")
        XCTAssertEqual(goal?.getSpecifics(),testSpecifics, "Returned specifics is wrong: in getSpecifics")
    }
    
    func testSetSpecifics()
    {
        let testSpecifics = "Specifics1"
        let newSpecifics = "Specifics2"
        let goal = Goal(goalDescription: "Description1", specifics: testSpecifics, due:"04/07/2018")
        goal?.setSpecifics(specifics: newSpecifics)
        XCTAssertEqual(goal?.getSpecifics(),newSpecifics, "Returned specifics is wrong: in setSpecifics")
    }
    
    
    func testGetDue()
    {
        let testDue = "04/07/2018"
        let goal = Goal(goalDescription: "Description1", specifics: "specifics1", due: testDue)
        XCTAssertEqual(goal?.getDue(),testDue, "Returned Due is wrong: in getDue")
    }
    
    
    func testSetDue()
    {
        let testDue = "04/07/2018"
        let newDue = "23/05/2019"
        let goal = Goal(goalDescription: "Description1", specifics: "specifics1", due: testDue)
        goal?.setDue(dueDate: newDue)
        XCTAssertEqual(goal?.getDue(),newDue, "Returned Due is wrong: in setDue")
    }
    
    func testAlertType()
    {
        let testAlertType = 1
        let goal = Goal(goalDescription: "Description1", specifics: "specifics1", due: "04/07/2018")
        goal?.setAlertType(alertType:testAlertType)
        
        XCTAssertEqual(goal?.getalertType(),testAlertType, "Returned alertType is wrong: in testAlertType")
    }
}
