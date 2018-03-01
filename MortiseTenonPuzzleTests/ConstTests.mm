//
//  ConstTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-01.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>

@interface ConstTests : XCTestCase
@end

@implementation ConstTests

- (void)testConstInt {
    const int five = 5;
//    five = 6; not allowed
    XCTAssertEqual(5, five);
}

- (void)testConstIntPointer {
    int seven;
    const int *sevenPointer; // declare a pointer to a const int
    sevenPointer = &seven;
//    *sevenPointer = 7; // not allowed
    seven = 7;
    XCTAssertEqual(7, *sevenPointer);
    sevenPointer++; // allowed
    
    int three;
    int *const threePointer = &three; // declare a constant pointer
    *threePointer = 3;
    XCTAssertEqual(3, three);
//    threePointer++; // not allowed
    
    int ten = 10;
    int *tenPointer = &ten;
    const int *pointerToConstTen = tenPointer;  // allowed to add const-ness restriction
    XCTAssertEqual(10, *pointerToConstTen);
//    int *anotherTenPointer = pointerToConstTen; // not allowed to remove const-ness restriction
}

// const can be used as a discriminator between functions fo the same name:

void fn_ConstTests(const int& param) {              // func0
    std::cout << "with const" << std::endl;
}

void fn_ConstTests(int& param) {                    // func1
    std::cout << "without const" << std::endl;
}

- (void)testConstParamInFunction {
    int n;
    fn_ConstTests(10);                              // matches func0 only
    fn_ConstTests(n);                               // matches both func0 and func1
}

@end
