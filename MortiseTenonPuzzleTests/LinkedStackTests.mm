//
//  LinkedStackTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-04.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
#import "stack.h"

@interface LinkedStackTests : XCTestCase
@end

@implementation LinkedStackTests

- (void)testLinkedStack {
    StackTestsNS::Stack<int> *intStack = new LinkedStackTestsNS::LStack<int>;
    intStack->push(13);
    intStack->push(7);
    XCTAssertEqual(2, intStack->length());
    XCTAssertEqual(7, intStack->pop());
    XCTAssertEqual(13, intStack->pop());
    XCTAssertEqual(0, intStack->length());
    
    delete intStack;
    intStack = nullptr;
}

namespace LinkedStackTestsNS {
    
    // Singly linked list node with freelist support
    template <typename E> class Link {
    private:
        static Link<E>* freelist;   // Reference to freelist head
    public:
        E element;      // Value for this node
        Link *next;     // Pointer to next node in list
        
        // Constructors
        
        Link(const E& elemval, Link* nextval = nullptr) {
            element = elemval;
            next = nextval;
        }
        
        Link(Link* nextval = nullptr) {
            next = nextval;
        }
        
        void* operator new(size_t) {                    // Overloaded new operator
            if (freelist == NULL) return ::new Link;    // Create space
            Link<E>* temp = freelist;                   // Can take from freelist
            freelist = freelist->next;
            return temp;                                // Return the link
        }
        
        void operator delete(void* ptr) {               // Overloaded delete operator
            ((Link<E>*)ptr)->next = freelist;           // Put on freelist
            freelist = (Link<E>*)ptr;
        }
    };
    
    // The freelist head pointer is actually created here
    template <typename E>
    Link<E>* Link<E>::freelist = nullptr;
    
    void Assert(bool val, std::string s) {
        if (!val) {
            std::cout << "Assertion Failed: " << s << std::endl;
            exit(-1);
        }
    }
    
    template <typename E> class LStack: public StackTestsNS::Stack<E> {
    private:
        Link<E>* top;                       // Pointer to first element
        int size;                           // Number of elements
        
    public:
        LStack(int size = 100) {            // Constructor
            top = nullptr;
            this->size = 0;
        }
        
        ~LStack() { clear(); }              // Destructor
        
        void clear() {                      // Reinitialize
            while (top != nullptr) {        // Delete link nodes
                Link<E>* temp = top;
                top = top->next;
                delete temp;
            }
            size = 0;
        }
        
        void push(const E& it) {            // Put "it" on stack
            top = new Link<E>(it, top);
            size++;
        }
        
        E pop() {                           // Pop top element
            Assert(top != nullptr, "Stack is empty");
            E it = top->element;
            Link<E>* ltemp = top->next;
            delete top;
            top = ltemp;
            size--;
            return it;
        }
        
        const E& topValue() const {         // Return top element
            Assert(top != nullptr, "Stack is empty");
            return top->element;
        }
        
        int length() const { return size; }  // Return length
    };
}

@end
