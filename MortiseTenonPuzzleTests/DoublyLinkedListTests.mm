//
//  DoublyLinkedListTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-02.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
#import "list.h"

@interface DoublyLinkedListTests : XCTestCase

@end

@implementation DoublyLinkedListTests

- (void)testDoublyLinkedListInsert {
    ListTestsNS::List<int> *intList = new DoublyLinkedListTestsNS::DoublyLinkedList<int>;
    XCTAssertEqual(0, intList->length());
    
    intList->insert(13);
    intList->insert(12);
    XCTAssertEqual(2, intList->length());
    XCTAssertEqual(0, intList->currPos());
    
    intList->insert(20);
    intList->insert(8);
    intList->insert(3);
    
    XCTAssertEqual(5, intList->length());
    XCTAssertEqual(0, intList->currPos());
    
    intList->moveToStart();
    XCTAssertEqual(0, intList->currPos());
    XCTAssertEqual(3, intList->getValue());
    intList->next();
    XCTAssertEqual(1, intList->currPos());
    XCTAssertEqual(8, intList->getValue());
    
    XCTAssertTrue(DoublyLinkedListTestsNS::find(*intList, 20));
    XCTAssertEqual(2, intList->currPos());
    XCTAssertTrue(DoublyLinkedListTestsNS::find(*intList, 12));
    XCTAssertEqual(3, intList->currPos());
    XCTAssertTrue(DoublyLinkedListTestsNS::find(*intList, 8));
    XCTAssertEqual(1, intList->currPos());
    
    XCTAssertFalse(DoublyLinkedListTestsNS::find(*intList, 7));
    XCTAssertEqual(5, intList->currPos()); // curr was moved to end since 7 doesn't exist
    
    intList->prev();
    XCTAssertEqual(4, intList->currPos());
    
    delete intList;
    intList = nullptr;
}

- (void)testDoublyLinkedListAppend {
    ListTestsNS::List<int> *intList = new DoublyLinkedListTestsNS::DoublyLinkedList<int>;
    XCTAssertEqual(0, intList->length());
    
    intList->append(13);
    XCTAssertEqual(1, intList->length());
    XCTAssertEqual(0, intList->currPos());
    XCTAssertEqual(13, intList->getValue());
    
    intList->append(12);
    XCTAssertEqual(2, intList->length());
    XCTAssertEqual(0, intList->currPos());
    XCTAssertEqual(13, intList->getValue());

    intList->append(20);
    intList->append(8);
    intList->append(3);

    XCTAssertEqual(5, intList->length());
    XCTAssertEqual(0, intList->currPos());

    intList->moveToStart();
    XCTAssertEqual(0, intList->currPos());
    XCTAssertEqual(13, intList->getValue());
    intList->next();
    XCTAssertEqual(1, intList->currPos());
    XCTAssertEqual(12, intList->getValue());

    XCTAssertTrue(DoublyLinkedListTestsNS::find(*intList, 20));
    XCTAssertEqual(2, intList->currPos());
    XCTAssertTrue(DoublyLinkedListTestsNS::find(*intList, 12));
    XCTAssertEqual(1, intList->currPos());
    XCTAssertTrue(DoublyLinkedListTestsNS::find(*intList, 8));
    XCTAssertEqual(3, intList->currPos());

    XCTAssertFalse(DoublyLinkedListTestsNS::find(*intList, 7));
    XCTAssertEqual(5, intList->currPos()); // curr was moved to end since 7 doesn't exist

    intList->prev();
    XCTAssertEqual(4, intList->currPos());
    
    delete intList;
    intList = nullptr;
}

- (void)testDoublyLinkedListRemove {
    ListTestsNS::List<int> *intList = new DoublyLinkedListTestsNS::DoublyLinkedList<int>;
    XCTAssertEqual(0, intList->length());
    
    intList->append(13);
    XCTAssertEqual(1, intList->length());
    XCTAssertEqual(0, intList->currPos());
    
    XCTAssertEqual(13, intList->remove());
    XCTAssertEqual(0, intList->length());

    intList->next();
    XCTAssertEqual(NULL, intList->remove());
    XCTAssertEqual(0, intList->length());
    
    intList->append(13);
    intList->append(12);
    XCTAssertEqual(2, intList->length());
    XCTAssertEqual(0, intList->currPos());
    intList->next();
    XCTAssertEqual(12, intList->remove());
    XCTAssertEqual(1, intList->length());
    intList->prev();
    XCTAssertEqual(13, intList->remove());
    XCTAssertEqual(0, intList->length());
    
    intList->append(13);
    intList->append(12);
    XCTAssertEqual(2, intList->length());
    XCTAssertEqual(0, intList->currPos());
    XCTAssertEqual(13, intList->remove());
    XCTAssertEqual(1, intList->length());
    XCTAssertEqual(12, intList->remove());
    XCTAssertEqual(0, intList->length());
    
    delete intList;
    intList = nullptr;
}

namespace DoublyLinkedListTestsNS {
    
    // Doubly linked list link node with freelist support
    template <typename E> class Link {
    private:
        static Link<E>* freelist;       // Referance to freelist head

    public:
        E element;                      // Value for this node
        Link* prev;                     // Pointer to previous node
        Link* next;                     // Pointer to next node in list
        
        // Constructors
        
        Link(const E& it, Link* prevp, Link* nextp) {
            element = it;
            prev = prevp;
            next = nextp;
        }
        
        Link(Link* prevp = nullptr, Link* nextp = nullptr) {
            prev = prevp;
            next = nextp;
        }
        
        void* operator new(size_t) {    // Overloaded new operator
            if (freelist == nullptr) return ::new Link;    // Create space
            Link<E>* temp = freelist;   // Can take from freelist
            freelist = freelist->next;
            return temp;                // Return the link
        }
        
        void operator delete(void* ptr) {   // Overloaded delete oprator
            ((Link<E>*)ptr)->next = freelist;   // Put on freelist
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
    
    bool find(ListTestsNS::List<int>& L, int K) {
        int it;
        for (L.moveToStart(); L.currPos() < L.length(); L.next()) {
            it = L.getValue();
            if (K == it) return true;
        }
        return false;
    }
    
    template <typename E> class DoublyLinkedList : public ListTestsNS::List<E> {
    private:
        Link<E>* head;  // Pointer to list header
        Link<E>* tail;  // Pointer to last element
        Link<E>* curr;  // Access to current element
        int cnt;        // Size of list
        
        void init() {
            head = curr = new Link<E>(NULL, nullptr, nullptr);
            tail = new Link<E>(NULL, curr, nullptr);
            curr->next = tail;
            cnt = 0;
        }
        
        void removeAll() {  // Return link nodes to free store
            while(head != nullptr) {
                curr = head;
                head = head->next;
                delete curr;
            }
        }
        
    public:
        DoublyLinkedList(int size = 100) { init(); }        // Constructor
        ~DoublyLinkedList() { removeAll(); }                // Destructor
        void clear() { removeAll(); init(); }
        
        // Insert "it" at current position
        void insert(const E& it) {
            curr->next = curr->next->prev = new Link<E>(it, curr, curr->next);
            cnt++;
        }
        
        // Append "it" to the end of the list
        void append(const E& it) {
            tail->prev = tail->prev->next = new Link<E>(it, tail->prev, tail);
            cnt++;
        }
        
        // Remove and return current element
        E remove() {
            if (curr->next == tail) return NULL;        // Nothing to remove
            E it = curr->next->element;                 // Remember value
            Link<E>* ltemp = curr->next;                // Remember link node
            curr->next->next->prev = curr;
            curr->next = curr->next->next;              // Remove from list
            delete ltemp;                               // Reclaim space
            cnt--;                                      // Decrement cnt
            return it;
        }
        
        void moveToStart() { curr = head; }
        void moveToEnd() { curr = tail; }
        
        // Move fence one step left; no change if left is empty
        void prev() {
            if (curr != head) curr = curr->prev;        // Can't back up from list head
        }
        
        void next() {
            if (curr->next != tail) curr = curr->next;
        }
        
        int length() const { return cnt; }
        
        int currPos() const {
            Link<E>* temp = head;
            int i;
            for (i = 0; curr != temp; i++)
                temp = temp->next;
            return i;
        }
        
        void moveToPos(int pos) {
            Assert((pos >= 0) && (pos <= cnt), "Position out of range");
            curr = head;
            for(int i = 0; i < pos; i++) curr = curr->next;
        }
        
        const E& getValue() const {
            Assert(curr->next != NULL, "No value");
            return curr->next->element;
        }
    };
}

@end
