//
//  RecursionTests.mm
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
    XCTAssertEqual(120, RecursionTestsNS::factorial(5));
}

- (void)testPrintStars {
    RecursionTestsNS::printStars(5);
    std::cout << std::endl;
}

- (void)testMystery {
    XCTAssertEqual(9, RecursionTestsNS::mystery(648));
}

- (void)testPower {
    XCTAssertEqual(64, RecursionTestsNS::power(2, 6));
    XCTAssertEqual(125, RecursionTestsNS::power(5, 3));
    XCTAssertEqual(1, RecursionTestsNS::power(1, 8));
    XCTAssertEqual(1, RecursionTestsNS::power(11, 0));
}

- (void)testIsParlingdrome {
    XCTAssertTrue(RecursionTestsNS::isParlingdrome("madam"));
    XCTAssertTrue(RecursionTestsNS::isParlingdrome("racecar"));
    XCTAssertTrue(RecursionTestsNS::isParlingdrome("step on no pets"));
    XCTAssertTrue(RecursionTestsNS::isParlingdrome("able was I ere I saw elba"));
    XCTAssertTrue(RecursionTestsNS::isParlingdrome("Q"));
    XCTAssertFalse(RecursionTestsNS::isParlingdrome("Java"));
    XCTAssertFalse(RecursionTestsNS::isParlingdrome("bytebye"));
    XCTAssertFalse(RecursionTestsNS::isParlingdrome("notion"));
}

namespace RecursionTestsNS {
    
    bool isParlingdrome(string str) {
        if (str.length() < 2) {
            return true;
        }
        char first = str[0];
        char last = str[str.length() - 1];
        string rest = str.substr(1, str.length() - 2);
        return first == last && isParlingdrome(rest);
    }
    
    int factorial(int x) {
        if (x == 1) {
            return 1;
        }
        return x * factorial(x - 1);
    }
    
    void printStars(int n) {
        if (n > 0) {
            std::cout << "*";
            printStars(n - 1);
        }
    }
    
    int mystery(int n) {
        if (n < 10) {
            return n;
        } else {
            int a = n / 10;
            int b = n % 10;
            return mystery(a + b);
        }
    }
    
    int power(int base, int exp) {
        if (exp < 0) {
            throw exp;
        }
        if (exp == 0) {
            return 1;
        }
        return base * power(base, exp - 1);
    }
}

@end
