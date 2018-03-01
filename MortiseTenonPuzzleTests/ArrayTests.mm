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
}

- (void)testIntArrayWithNew {
    int* fiveInts = new int[5];
    for(int i = 0; i < 5; i++) {
        fiveInts[i] = i + 3;
    }
    XCTAssertEqual(3, fiveInts[0]);
    XCTAssertEqual(7, fiveInts[4]);
    
    delete[] fiveInts;
    fiveInts = nullptr;
    
    int* sixInts = new int[6];
    for(int i = 0; i < 6; i++) {
        *(sixInts + i) = i;
    }
    XCTAssertEqual(0, sixInts[0]);
    XCTAssertEqual(5, sixInts[5]);
    
    delete[] sixInts;
    sixInts = nullptr;
}

- (void)testPointerVsArray {
    char charArr[128];  // allocate storage for 128 characters
    char* arrPointer;   // allocate space for a pointer
    XCTAssertEqual(128, sizeof(charArr));
    XCTAssertEqual(8, sizeof(arrPointer));
    
    charArr[10] = 'B';
    XCTAssertEqual('B', charArr[10]);
    
//    arrPointer[10] = 'E'; // crash
    
    // range-based for loop
    
    for(char& c: charArr) c = '\0';
    
    arrPointer = charArr;
//    for(char& c: arrPointer) c = '\0'; // not legal
    
    // charArr is a constant
    
    *charArr = '\0';
//    charArr++; // not allowed
    
    // array and pointer work together
    char zeros[8];
    char* zerosPointer = zeros;
    for(int i = 0; i < 7; i++) {
        *zerosPointer++ = 'W';
    }
    *zerosPointer = '\0';
    XCTAssertEqual('W', zeros[6]);
    
    zerosPointer -=7; // or zerosPointer = zeros;
    XCTAssertEqual('W', zerosPointer[6]);
    std::cout << zerosPointer << std::endl; // WWWWWWW
    std::cout << zeros << std::endl;        // WWWWWWW
    XCTAssertEqual(0, strcmp(zeros, zerosPointer));
}

@end

