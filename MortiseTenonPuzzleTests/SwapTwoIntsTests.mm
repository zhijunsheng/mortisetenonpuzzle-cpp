//
//  SwapTwoIntsTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-04.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SwapTwoIntsTests : XCTestCase
@end

@implementation SwapTwoIntsTests

- (void)testSwapTwoInts {
    int a = 3;
    int b = 7;
    XCTAssertEqual(3, a);
    XCTAssertEqual(7, b);
    
    a = a + b;
    b = a - b;
    a = a - b;
    
    XCTAssertEqual(3, b);
    XCTAssertEqual(7, a);
}

- (void)testSwapTwoIntsWithXor {
    int a = 3;
    int b = 7;
    XCTAssertEqual(3, a);
    XCTAssertEqual(7, b);
    
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
    
    XCTAssertEqual(3, b);
    XCTAssertEqual(7, a);
}

@end
