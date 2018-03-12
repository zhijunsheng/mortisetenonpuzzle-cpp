//
//  ArrayBasedQueueTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-05.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
#import "queue.h"

@interface ArrayBasedQueueTests : XCTestCase
@end

@implementation ArrayBasedQueueTests

- (void)testModulusOperator {
    XCTAssertEqual(4, 11 % 7);
    XCTAssertEqual(-4, -11 % 7);
    XCTAssertEqual(-4, (-11) % 7);
}

- (void)testArrayBasedQueue {
    QueueTestsNS::Queue<int>* intQueue = new ArrayBasedQueueTestsNS::AQueue<int>;
    XCTAssertEqual(0, intQueue->length());
    
    intQueue->enqueue(13);
    XCTAssertEqual(1, intQueue->length());
    XCTAssertEqual(13, intQueue->frontValue());
    
    XCTAssertEqual(13, intQueue->dequeue());
    XCTAssertEqual(0, intQueue->length());
    
    intQueue->enqueue(13);
    intQueue->enqueue(12);
    XCTAssertEqual(2, intQueue->length());
    XCTAssertEqual(13, intQueue->dequeue());
    XCTAssertEqual(12, intQueue->dequeue());
    XCTAssertEqual(0, intQueue->length());
    
    delete intQueue;
    intQueue = nullptr;
}

- (void)testQueueFun {
    QueueTestsNS::Queue<int>* intQueue = new ArrayBasedQueueTestsNS::AQueue<int>;
    for (int i = 1; i <= 6; i++) {
        intQueue->enqueue(i);
    }
    XCTAssertEqual(6, intQueue->length());
    
    for (int i = 0; i < intQueue->length(); i++) {
        std::cout << intQueue->dequeue() << " ";
    }
    XCTAssertEqual(3, intQueue->length());
    std::cout << intQueue << " size " << intQueue->length() << std::endl;
    
    delete intQueue;
    intQueue = nullptr;
}

- (void)testStutter {
    ArrayBasedQueueTestsNS::AQueue<int>* intQueue = new ArrayBasedQueueTestsNS::AQueue<int>;
    for (int i = 1; i <= 3; i++) {
        intQueue->enqueue(i);
    }
    XCTAssertEqual(3, intQueue->length());
    
    ArrayBasedQueueTestsNS::stutter(intQueue);
    while (intQueue->length() > 0) {
        std::cout << intQueue->dequeue() << " ";
    }
    std::cout << std::endl;
}


- (void)testStutter2 {
    ArrayBasedQueueTestsNS::AQueue<int>* intQueue = new ArrayBasedQueueTestsNS::AQueue<int>;
    for (int i = 1; i <= 3; i++) {
        intQueue->enqueue(i);
    }
    XCTAssertEqual(3, intQueue->length());
    
    ArrayBasedQueueTestsNS::stutter2(intQueue);
    while (intQueue->length() > 0) {
        std::cout << intQueue->dequeue() << " ";
    }
    std::cout << std::endl;
}

namespace ArrayBasedQueueTestsNS {
    
    void Assert(bool val, std::string s) {
        if (!val) {
            std::cout << "Assertion Failed: " << s << std::endl;
            exit(-1);
        }
    }
    
    // Array-based queue implementation
    template <typename E> class AQueue : public QueueTestsNS::Queue<E> {
    private:
        int maxSize;        // Maximum size of array
        int front;          // Index of front element
        int rear;           // Index of rear element
        E *listArray;       // Array holding queue elements
        
    public:
        AQueue(int size = 100) {    // Constructor
            // Make list array one position larger for empty slot
            maxSize = size + 1;
            rear = 0; front = 1;
            listArray = new E[maxSize];
        }
        
        ~AQueue() { delete[] listArray; }       // Destructor
        
        void clear() { rear = 0; front = 1; }   // Reinitialize
        
        void enqueue(const E& it) {             // Put "it" in queue
            Assert((rear + 2) % maxSize != front, "Queue is full");
            rear = (rear + 1) % maxSize;        // Circular increment
            listArray[rear] = it;
        }
        
        E dequeue() {                           // Take element out
            Assert(length() != 0, "Queue is empty");
            E it = listArray[front];
            front = (front + 1) % maxSize;      // Circular increment
            return it;
        }
        
        const E& frontValue() const {           // Get front value
            Assert(length() != 0, "Queue is empty");
            return listArray[front];
        }
        
        int length() const {                          // Return length
            return ((rear + maxSize) - front + 1) % maxSize;
        }
    };
    
    void stutter(AQueue<int>*& q) {
        AQueue<int>* q2 = new AQueue<int>();
        while (q->length() > 0) {
            int n = q->dequeue();
            q2->enqueue(n);
            q2->enqueue(n);
        }
        q = q2;
    }
    
    void stutter2(AQueue<int>* q) {
        int len = q->length();
        for (int i = 0; i < len; i++) {
            int n = q->dequeue();
            q->enqueue(n);
            q->enqueue(n);
        }
    }
}

@end
