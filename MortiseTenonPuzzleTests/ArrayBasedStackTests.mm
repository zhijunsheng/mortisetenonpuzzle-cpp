//
//  ArrayBasedStackTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-02.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
#import "stack.h"

@interface ArrayBasedStackTests : XCTestCase
@end

@implementation ArrayBasedStackTests
    
- (void)testStack {
    StackTestsNS::Stack<int> *intStack = new ArrayBasedStackTestsNS::AStack<int>;
    intStack->push(13);
    intStack->push(7);
    XCTAssertEqual(2, intStack->length());
    XCTAssertEqual(7, intStack->pop());
    XCTAssertEqual(13, intStack->pop());
    XCTAssertEqual(0, intStack->length());
    
    delete intStack;
    intStack = nullptr;
}

namespace ArrayBasedStackTestsNS {
    
    void Assert(bool val, std::string s) {
        if (!val) {
            std::cout << "Assertion Failed: " << s << std::endl;
            exit(-1);
        }
    }
    
    template <typename E> class AStack: public StackTestsNS::Stack<E> {
    private:
        int maxSize;        // Maximum size of stack
        int top;            // Index for top element
        E *listArray;       // Array holding stack elements
        
    public:
        AStack(int size = 100) {            // Constructor
            maxSize = size;
            top = 0;
            listArray = new E[size];
        }
        
        ~AStack() { delete[] listArray; }   // Destructor
        
        void clear() { top = 0; }           // Reinitialize
        
        void push(const E& it) {            // Put "it" on stack
            Assert(top != maxSize, "Stack is full");
            listArray[top++] = it;
        }
        
        E pop() {                           // Pop top element
            Assert(top != 0, "Stack is empty");
            return listArray[--top];
        }
        
        const E& topValue() const {         // Return top element
            Assert(top != 0, "Stack is empty");
            return listArray[top - 1];
        }
        
        int length() const { return top; }  // Return length
    };
}

@end
