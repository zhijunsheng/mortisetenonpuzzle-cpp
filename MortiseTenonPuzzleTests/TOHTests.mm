//
//  TOHTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-04.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
#import "stack.h"

@interface TOHTests : XCTestCase
@end

@implementation TOHTests

- (void)testRecursiveTOH {
    TOHTestsNS::TOH(6, 1, 3, 2);
    std::cout << std::endl;
}

- (void)testStackBasedTOH {
    int n = 6;
    // An array-based stack is used because we know that the stack will need to store exactly 2n+1 elements.
    TOHTestsNS::AStack<TOHTestsNS::TOHobj*> S(2 * n + 1);   // Make a stack with just enough room
    TOHTestsNS::TOH(n, 1, 3, 2, S);
    std::cout << std::endl;
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
    
    // Operation choices: DOMOVE will move a disk
    // DOTOH corresponds to a recursive call
    enum TOHop { DOMOVE, DOTOH };
    
    class TOHobj {  // An operation object
    public:
        TOHop op;               // This operation type
        int num;                // How many disks
        Pole start, goal, tmp;  // Define pole order
        
        // DOTOH operation constructor
        TOHobj(int n, Pole s, Pole g, Pole t) {
            op = DOTOH; num = n;
            start = s; goal = g; tmp = t;
        }
        
        // DOMOVE operation constructor
        TOHobj(Pole s, Pole g) {
            op = DOMOVE; start = s; goal = g;
        }
    };
    
    void TOH(int n, Pole start, Pole goal, Pole tmp, StackTestsNS::Stack<TOHobj*>& S) {
        S.push(new TOHobj(n, start, goal, tmp));    // Initial
        TOHobj* t;
        while (S.length() > 0) {    // Grab next task
            t = S.pop();
            if (t->op == DOMOVE)    // Do a move
                move(t->start, t->goal);
            else if (t->num > 0) {
                // Store (in reverse) 3 recursive statements
                int num = t->num;
                Pole tmp = t->tmp;
                Pole goal = t->goal;
                Pole start = t->start;
                S.push(new TOHobj(num - 1, tmp, goal, start));
                S.push(new TOHobj(start, goal));
                S.push(new TOHobj(num - 1, start, tmp, goal));
            }
            delete t;   // Must delete the TOHobj we made
        }
    }
    
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

