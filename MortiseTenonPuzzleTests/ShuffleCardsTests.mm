//
//  ShuffleCardsTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-05.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>

@interface ShuffleCardsTests : XCTestCase
@end

@implementation ShuffleCardsTests

- (void)testShuffleCards {
    int* cards = new int[52];
    for(int i = 0; i < 52; i++) cards[i] = i;
    XCTAssertTrue(cards[51] == 51);
    
    for(int i = 0; i < 52; i++) std::cout << cards[i] << " ";
    std::cout << std::endl;
    ShuffleCardsTestsNS::permute(cards, 52);
    for(int i = 0; i < 52; i++) std::cout << cards[i] << " ";
    std::cout << std::endl;
    XCTAssertFalse(cards[51] == 51);
}

namespace ShuffleCardsTestsNS {
    
    template <typename E>
    void swap(E A[], int i, int j) {
        E tmp = A[i];
        A[i] = A[j];
        A[j] = tmp;
    }
    
    int Random(int n) {
        return rand() % n;
    }
    
    template <typename E>
    void permute(E A[], int n) {
        for (int i = n; i > 0; i--) {
            swap(A, i - 1, Random(i));
        }
    }
}

@end
