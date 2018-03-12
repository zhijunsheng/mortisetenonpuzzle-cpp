//
//  LvalueRvalueTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-12.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface LvalueRvalueTests : XCTestCase
@end

// https://eli.thegreenplace.net/2011/12/15/understanding-lvalues-and-rvalues-in-c-and-c
@implementation LvalueRvalueTests

- (void)testLvalueRvalue {
    XCTAssertEqual(20, LvalueRvalueTestsNS::globalvar);
    LvalueRvalueTestsNS::foo() = 10;
    XCTAssertEqual(10, LvalueRvalueTestsNS::globalvar);
}

namespace LvalueRvalueTestsNS {
    
    int globalvar = 20;
    
    int& foo() {
        return globalvar;
    }
}

@end
