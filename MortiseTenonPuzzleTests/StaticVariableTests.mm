//
//  StaticVariableTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-02-28.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface StaticVariableTests : XCTestCase

@end

@implementation StaticVariableTests

class StaticVariableTestsStaticVariable {
public:
    int count() {
        static int staticVar = 1;
        return staticVar++;
    }
};

- (void)testStaticVariable {
   
    StaticVariableTestsStaticVariable sVar;
    XCTAssertEqual(1, sVar.count());
    XCTAssertEqual(2, sVar.count());
    XCTAssertEqual(3, sVar.count());
}

@end
