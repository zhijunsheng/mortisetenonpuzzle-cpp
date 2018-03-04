//
//  InsertionSortTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-04.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>

@interface InsertionSortTests : XCTestCase
@end

@implementation InsertionSortTests

- (void)testInsertionSort {
    int ints[] = {13, 3, 7, 5, 11};
    InsertionSortTestsNS::inssort<int, InsertionSortTestsNS::minintCompare>(ints, 5);
    int expectation[] = {3, 5, 7, 11, 13};
    XCTAssertTrue(std::equal(std::begin(expectation), std::end(expectation), std::begin(ints)));
}

namespace InsertionSortTestsNS {
    
    // Swap two elements in a generic array
    template <typename E>
    inline void swap(E A[], int i, int j) {
        E temp = A[i];
        A[i] = A[j];
        A[j] = temp;
    }
    
    class minintCompare {
    public:
        static bool prior(int x, int y) { return x < y; }
    };
    
    // Insertion sort implementation
    template <typename E, typename Comp>
    void inssort(E A[], int n) {    // Insertion Sort
        for (int i = 1; i < n; i++) {   // Insert i'th record
            for (int j = i; j > 0 && Comp::prior(A[j], A[j - 1]); j--)
                swap(A, j, j - 1);
        }
    }
}

@end

