//
//  SinglyLinkedListTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-02-28.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
#import "list.h"

@interface SinglyLinkedListTests : XCTestCase

@end

@implementation SinglyLinkedListTests

- (void)testLList {
    ListTestsNS::List<int> *intList = new SinglyLinkedListTestsNS::LList<int>;
    intList->append(13);
    intList->append(12);
    intList->append(20);
    intList->append(8);
    intList->append(3);
    
    XCTAssertEqual(5, intList->length());
    
    XCTAssertTrue(SinglyLinkedListTestsNS::find(*intList, 20));
    XCTAssertEqual(2, intList->currPos());
    XCTAssertTrue(SinglyLinkedListTestsNS::find(*intList, 12));
    XCTAssertEqual(1, intList->currPos());
    XCTAssertTrue(SinglyLinkedListTestsNS::find(*intList, 8));
    XCTAssertEqual(3, intList->currPos());
    
    XCTAssertFalse(SinglyLinkedListTestsNS::find(*intList, 7));
    XCTAssertEqual(5, intList->currPos()); // curr was moved to end since 7 doesn't exist
    
    intList->prev();
    XCTAssertEqual(4, intList->currPos());
    
    delete intList;
    intList = nullptr;
}

namespace SinglyLinkedListTestsNS {

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

// Linked list implementation
template <typename E> class LList: public ListTestsNS::List<E> {
private:
    Link<E>* head;      // Pointer to list header
    Link<E>* tail;      // Pointer to last element
    Link<E>* curr;      // Access to current element
    int cnt;            // Size of list
    
    void init() {       // Intialization helper method
        curr = tail = head = new Link<E>;
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
    LList(int size = 100) { init(); }       // Constructor
    ~LList() { removeAll(); }               // Destructor
    void print() const;                     // Print list contents
    void clear() { removeAll(); init(); }   // Clear list
    
    // Insert "it" at current position
    void insert(const E& it) {
        curr->next = new Link<E>(it, curr->next);
        if (tail == curr) tail = curr->next;        // New tail
        cnt++;
    }
    
    void append(const E& it) {      // Append "it" to list
        tail = tail->next = new Link<E>(it, nullptr);
        cnt++;
    }
    
    // Remove and return current element
    E remove() {
        Assert(curr->next != nullptr, "No element");
        E it = curr->next->element;             // Remember value
        Link<E>* ltemp = curr->next;            // Rememmber link node
        if (tail == curr->next) tail = curr;    // Reset tail
        curr->next = curr->next->next;          // Remove from list
        delete ltemp;                           // Reclaim space
        cnt--;                                  // Decrement the count
        return it;
    }
    
    void moveToStart() { curr = head; }         // Place curr at list start
    void moveToEnd() { curr = tail; }           // Place curr at list end
    
    // Move curr one step left; no change if already at front
    void prev() {
        if (curr == head) return;               // No previous element
        Link<E>* temp = head;
        // March down list until we find the previous element
        while (temp->next != curr) temp = temp->next;
        curr = temp;
    }
    
    // Move curr one step right; no change if already at end
    void next() {
        if (curr != tail) curr = curr->next;
    }
    
    int length() const { return cnt; }          // Return length
    
    // Return the position of the current element
    int currPos() const {
        Link<E>* temp = head;
        int i;
        for (i = 0; curr != temp; i++)
            temp = temp->next;
        return i;
    }
    
    // Move down list to "pos" position
    void moveToPos(int pos) {
        Assert((pos >= 0) && (pos <= cnt), "Position out of range");
        curr = head;
        for(int i = 0; i < pos; i++) curr = curr->next;
    }
    
    const E& getValue() const {                 // Return current element
        Assert(curr->next != nullptr, "No value");
        return curr->next->element;
    }
};
}
    
@end

