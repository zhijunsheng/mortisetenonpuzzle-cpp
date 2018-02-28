//
//  SimpleLoopTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-02-28.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
using namespace std;

@interface SimpleLoopTests : XCTestCase

@end

@implementation SimpleLoopTests

- (void)testAdd {
    XCTAssertEqual(8, SimpleLoopTestsUtils::add(3, 5));
    
    cout << "hello .mm" << endl;
}

- (void)testFindMax {
    int arr[5] = {3, 7, 2, 13, 5};
    XCTAssertEqual(13, SimpleLoopTestsUtils::findMaxUsingForLoop(arr, 5));
    XCTAssertEqual(13, SimpleLoopTestsUtils::findMaxUsingWhileLoop(arr, 5));
}

- (void)testFactorial {
    XCTAssertEqual(120, SimpleLoopTestsUtils::factorial(5));
}

class SimpleLoopTestsUtils {
public:
    static int factorial(int n) {
        int total = 1;
        for (int i = 1; i <= n; i++) {
            total *= i;
        }
        return total;
    }
    
    static int add(int x, int y) {
        return x + y;
    }
    
    static int findMaxUsingWhileLoop(int ints[], int numInts) {
        int i = 1, max = ints[0] ;
        while (i < numInts) {
            if (max < ints[i]) {
                max = ints[i];
            }
            i++;
        }
        return max;
    }
    
    static int findMaxUsingForLoop(int ints[], int numInts) {
        int max = ints[0];
        for(int i = 1; i < numInts; i++) {
            if(max < ints[i]) {
                max = ints[i];
            }
        }
        return max;
    }
};

@end
