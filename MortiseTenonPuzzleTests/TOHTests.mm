//
//  TOHTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-04.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>

@interface TOHTests : XCTestCase
@end

@implementation TOHTests

- (void)testTOH {

    TOHTestsNS::TOH(6, 1, 3, 2);
    
}

namespace TOHTestsNS {
    
    typedef int Pole;   // A simple definition for a pole type
    
    // What to do when we "move" a disk: Print it out
    #define move(X, Y) std::cout << "Move " << (X) << " to " << (Y) << std::endl
    
    // A simple recursive function that generates the solution steps
    void TOH(int n, Pole start, Pole goal, Pole temp) {
        if (n == 0) return;             // base case
        TOH(n - 1, start, temp, goal);  // Recursive call: n-1 rings
        move(start, goal);              // Move bottom disk to goal
        TOH(n - 1, temp, goal, start);  // Recursive call: n-1 rings
    }
}

@end

