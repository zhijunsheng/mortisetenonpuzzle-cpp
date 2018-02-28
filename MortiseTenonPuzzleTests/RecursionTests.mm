//
//  RecursionTests.cpp
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-02-28.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
using namespace std;

@interface RecursionTests : XCTestCase

@end

@implementation RecursionTests

- (void)testFactorial {
    XCTAssertEqual(120, RecursionTestsUtils::factorial(5));
}

class RecursionTestsUtils {
public:
    
    static int factorial(int x) {
        if (x == 1) {
            return 1;
        }
        return x * factorial(x - 1);
    }
    
};

@end
