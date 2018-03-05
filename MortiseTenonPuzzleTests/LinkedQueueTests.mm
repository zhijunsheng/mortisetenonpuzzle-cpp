//
//  LinkedQueueTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-05.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
#import "queue.h"

@interface LinkedQueueTests : XCTestCase
@end

@implementation LinkedQueueTests

- (void)testLinkedQueue {
    QueueTestsNS::Queue<int>* intQueue = new LinkedQueueTestsNS::LQueue<int>;
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

namespace LinkedQueueTestsNS {
    
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
    
    // Linked queue implementation
    template <typename E> class LQueue : public QueueTestsNS::Queue<E> {
    private:
        Link<E>* front;     // Pointer to front queue node
        Link<E>* rear;      // Pointer to rear queue node
        int size;           // Number of element in queue
        
    public:
        LQueue(int sz = 100) {    // Constructor
            front = rear = new Link<E>();
            size = 0;
        }
        
        ~LQueue() { clear(); delete front; }    // Destructor
        
        void clear() {                          // Clear queue
            while(front->next != nullptr) {     // Delete each link node
                rear = front;
                delete rear;
            }
            rear = front;
            size = 0;
        }
        
        void enqueue(const E& it) {             // Put element on rear
            rear = rear->next = new Link<E>(it, nullptr);
            size++;
        }
        
        E dequeue() {                           // Remove element from front
            Assert(size != 0, "Queue is empty");
            E it = front->next->element;        // Store dequeued value
            Link<E>* ltemp = front->next;       // Hold dequeued link
            front->next = ltemp->next;          // Advance front
            if (rear == ltemp) rear = front;    // Dequeue last element
            delete ltemp;                       // Delete link
            size--;
            return it;                          // Return element value
        }
        
        const E& frontValue() const {           // Get front element
            Assert(size != 0, "Queue is empty");
            return front->next->element;
        }
        
        int length() const {
            return size;
        }
    };
}

@end
