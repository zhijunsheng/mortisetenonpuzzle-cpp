//
//  ArrayTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-02-28.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <array>
#import <iostream>

@interface ArrayTests : XCTestCase

@end

@implementation ArrayTests

- (void)testCharArray {
    char firstName[] = {'D', 'o', 'n', 'a', 'l', 'd'};
    for(char c: firstName) {
        std::cout << c;
    }
    
    char lastName[] = {'S', 'h', 'e', 'n', 'g', '\0'};
    for(int i = 0; lastName[i]; i++) { // lastName[i] != '\0'
        std::cout << lastName[i];
    }
    
    std::cout << std::endl;
    
    char alsoLastName[] = "Sheng";
    XCTAssertEqual(0, strcmp(lastName, alsoLastName)); // 0 means equal
}

- (void)testMatrix {
    int intMatrix[2][3] = {{1, 2, 3}, {4, 5, 6}};
    XCTAssertEqual(1, intMatrix[0][0]);
    XCTAssertEqual(6, intMatrix[1][2]);
}

- (void)testArrayEquality {
    std::array<int, 2> ints0 {3, 5};
    std::array<int, 2> ints1 {3, 5};
    XCTAssertEqual(ints0, ints1);
    
    int ints2[] = {7, 13, 11};
    int ints3[] = {7, 13, 11, 23};
    XCTAssertTrue(std::equal(std::begin(ints2), std::end(ints2), std::begin(ints3)));
}

- (void)testArray {
    int ints[128] = {};
    XCTAssertEqual(0, ints[127]);
    for(int i = 0; i < 128; i++) ints[i] = i;
    XCTAssertEqual(127, ints[127]);
    
    for(int &n: ints) n = 13;
    XCTAssertEqual(13, ints[23]);
    
    float floats[] = {0.1, 0.2, 0.31, 0.4};
    XCTAssertTrue(floats[2] > 0.3);
    
    int* fivePrimes = new int[5];
    for(int i = 0; i < 5; i++) {
//        *fivePrimes = i + 3;
        fivePrimes[i] = i + 3;
        fivePrimes++;
    }
    XCTAssertEqual(3, fivePrimes[0]);
    XCTAssertEqual(7, fivePrimes[4]);
}

@end

