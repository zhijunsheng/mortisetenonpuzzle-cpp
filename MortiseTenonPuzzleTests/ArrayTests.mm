//
//  ArrayTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-02-28.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ArrayTests : XCTestCase

@end

@implementation ArrayTests

- (void)testArray {
    int ints[128] = {};
    XCTAssertEqual(0, ints[127]);
    for(int i = 0; i < 128; i++) ints[i] = i;
    XCTAssertEqual(127, ints[127]);
    
    for(int &n: ints) n = 13;
    XCTAssertEqual(13, ints[23]);
    
    float floats[] = {0.1, 0.2, 0.31, 0.4};
    XCTAssertTrue(floats[2] > 0.3);
}

@end

