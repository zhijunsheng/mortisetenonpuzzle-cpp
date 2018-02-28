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

- (void)testVariableSize {
    bool b;
    char c;
    int n;
    long l;
    long long ll;
    float f;
    double d;
    long double ld;
    
    XCTAssertEqual(1, sizeof b);
    XCTAssertEqual(1, sizeof c);
    XCTAssertEqual(4, sizeof n);
    XCTAssertEqual(8, sizeof l);
    XCTAssertEqual(8, sizeof ll);
    XCTAssertEqual(4, sizeof f);
    XCTAssertEqual(8, sizeof d);
    XCTAssertEqual(16, sizeof ld);
    
    XCTAssertEqual(1, (char*)&b - (char*)&c);
    XCTAssertEqual(8, (char*)&l - (char*)&ll);
}

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
