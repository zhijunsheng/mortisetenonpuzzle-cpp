//
//  ArrayBasedListTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-02.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
#import "list.h"

@interface ArrayBasedListTests : XCTestCase

@end

@implementation ArrayBasedListTests

- (void)testAList {
    ListTestsNS::List<int> *intList = new ArrayBasedListTestsNS::AList<int>;
    intList->append(13);
    intList->append(12);
    XCTAssertEqual(2, intList->length());
    XCTAssertEqual(0, intList->currPos());
    
    intList->append(20);
    intList->append(8);
    intList->append(3);
    
    XCTAssertEqual(5, intList->length());
    
    XCTAssertTrue(ArrayBasedListTestsNS::find(*intList, 20));
    XCTAssertEqual(2, intList->currPos());
    XCTAssertTrue(ArrayBasedListTestsNS::find(*intList, 12));
    XCTAssertEqual(1, intList->currPos());
    XCTAssertTrue(ArrayBasedListTestsNS::find(*intList, 8));
    XCTAssertEqual(3, intList->currPos());
    
    XCTAssertFalse(ArrayBasedListTestsNS::find(*intList, 7));
    XCTAssertEqual(5, intList->currPos()); // curr was moved to end since 7 doesn't exist
    
    intList->prev();
    XCTAssertEqual(4, intList->currPos());
    
    intList->moveToStart();
    XCTAssertEqual(0, intList->currPos());
    intList->next();
    XCTAssertEqual(1, intList->currPos());
    XCTAssertEqual(12, intList->getValue());
    
    delete intList;
    intList = nullptr;
}

namespace ArrayBasedListTestsNS {
    
    void Assert(bool val, std::string s) {
        if (!val) {
            std::cout << "Assertion Failed: " << s << std::endl;
            exit(-1);
        }
    }
    
    bool find(ListTestsNS::List<int>& L, int K) {
        int it;
        for (L.moveToStart(); L.currPos() < L.length(); L.next()) {
            it = L.getValue();
            if (K == it) return true;
        }
        return false;
    }
    
    template <typename E> class AList : public ListTestsNS::List<E> {
    private:
        int maxSize;    // Maximum size of list
        int listSize;   // Number of list items now
        int curr;       // Position of current element
        E* listArray;   // Array holding list elements
        
    public:
        AList(int size = 100) {             // Constructor
            maxSize = size;
            listSize = curr = 0;
            listArray = new E[maxSize];
        }
        
        ~AList() { delete [] listArray; }   // Destructor
        
        void clear() {                      // Reinitialize the list
            delete [] listArray;            // Remove the array
            listSize = curr = 0;            // Reset the size
            listArray = new E[maxSize];     // Recreate array
        }
        
        // Insert "it" at current position
        void insert(const E& it) {
            Assert(listSize < maxSize, "List capacity exceeded");
            for(int i = listSize; i > curr; i--)    // Shift elements up to make room
                listArray[i] = listArray[i - 1];
            listArray[curr] = it;
            listSize++;                             // Increment list size
        }
        
        void append(const E& it) {                  // Append "it"
            Assert(listSize < maxSize, "List capacity exceeded");
            listArray[listSize++] = it;
        }
        
        // Remove and return the current element.
        E remove() {
            Assert((curr >= 0) && (curr < listSize), "No element");
            E it = listArray[curr];                     // Copy the element
            for(int i = curr; i < listSize - 1; i++)    // Shift them down
                listArray[i] = listArray[i + 1];
            listSize--;
            return it;
        }
        
        void moveToStart() { curr = 0; }            // Reset position
        void moveToEnd() { curr = listSize; }       // Set at end
        void prev() { if(curr != 0) curr--; }       // Back up
        void next() { if(curr < listSize) curr++; } // Next
        
        // Return list size
        int length() const { return listSize; }
        
        // Return current position
        int currPos() const { return curr; }
        
        // Set current list position to "pos"
        void moveToPos(int pos) {
            Assert((pos >= 0) && (pos <= listSize), "Pos out of range");
            curr = pos;
        }
        
        const E& getValue() const { // Return current element
            return listArray[curr];
        }
    };
}

@end
