//
//  SelectionSortTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-04.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>

@interface SelectionSortTests : XCTestCase
@end

@implementation SelectionSortTests

- (void)testSelectionSort {
    int ints[] = {13, 3, 7, 5, 11};
    SelectionSortTestsNS::selsort<int, SelectionSortTestsNS::minintCompare>(ints, 5);
    int expectation[] = {3, 5, 7, 11, 13};
    XCTAssertTrue(std::equal(std::begin(expectation), std::end(expectation), std::begin(ints)));
}

namespace SelectionSortTestsNS {
    
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
    void selsort(E A[], int n) {            // Selection Sort
        for (int i = 0; i < n - 1; i++) {   // Select i'th record
            int lowindex = i;               // Remember its index
            for (int j = n - 1; j > i; j--) // Find the least value
                if (Comp::prior(A[j], A[lowindex]))
                    lowindex = j;           // Put it in place
            swap(A, i, lowindex);
        }
    }
}

@end

