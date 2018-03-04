//
//  BubbleSortTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-04.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>

@interface BubbleSortTests : XCTestCase
@end

@implementation BubbleSortTests

- (void)testInsertionSort {
    int ints[] = {13, 3, 7, 5, 11};
    BubbleSortTestsNS::bubsort<int, BubbleSortTestsNS::minintCompare>(ints, 5);
    int expectation[] = {3, 5, 7, 11, 13};
    XCTAssertTrue(std::equal(std::begin(expectation), std::end(expectation), std::begin(ints)));
}

namespace BubbleSortTestsNS {
    
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
    
    template <typename E, typename Comp>
    void bubsort(E A[], int n) {    // Bubble Sort
        for (int i = 0; i < n - 1; i++) {   // Bubble up i'th record
            for (int j = n - 1; j > i; j--)
                if (Comp::prior(A[j], A[j - 1]))
                    swap(A, j, j - 1);
        }
    }
}

@end
