//
//  DictionaryTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-03.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
#import "dictionary.h"
#import "list.h"

@interface DictionaryTests : XCTestCase
@end

@implementation DictionaryTests

- (void)testDictionary {
    // IDdict organizes Payroll records by ID
    DictionaryTestsNS::UALdict<int, DictionaryTestsNS::Payroll*> IDdict;
    // namedict organizes Payroll records by name
    DictionaryTestsNS::UALdict<std::string, DictionaryTestsNS::Payroll*> namedict;
    
    DictionaryTestsNS::Payroll *foo1, *foo2, *findfoo1, *findfoo2;
    
    foo1 = new DictionaryTestsNS::Payroll(5, "Joe", "Anytown");
    foo2 = new DictionaryTestsNS::Payroll(10, "John", "Mytown");
    
    IDdict.insert(foo1->getID(), foo1);
    IDdict.insert(foo2->getID(), foo2);
    namedict.insert(foo1->getname(), foo1);
    namedict.insert(foo2->getname(), foo2);
    
    findfoo1 = IDdict.find(5);
    XCTAssertEqual("Anytown", findfoo1->getaddr());
    
    findfoo2 = namedict.find("John");
    XCTAssertEqual("Mytown", findfoo2->getaddr());
}

namespace DictionaryTestsNS {
    
    void Assert(bool val, std::string s) {
        if (!val) {
            std::cout << "Assertion Failed: " << s << std::endl;
            exit(-1);
        }
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
    
    // Dictionary implemented with an unsorted array-based list
    template <typename Key, typename E>
    class UALdict : public Dictionary<Key, E> {
    private:
        AList<KVpair<Key, E>>* list;
        
    public:
        UALdict(int size = 100) {       // Constructor
            list = new AList<KVpair<Key, E>>(size);
        }
        ~UALdict() { delete list; }     // Destructor
        void clear() { list->clear(); } // Reinitialize
        
        // Insert an element: append to list
        void insert(const Key& k, const E& e) {
            KVpair<Key, E> temp(k, e);
            list->append(temp);
        }
        
        // Use sequential search to find the element to remove
        E remove(const Key& k) {
            E temp = find(k);       // "find" will set list position
            if (temp != NULL) list->remove();
            return temp;
        }
        
        E removeAny() { // Remove the last element
            Assert(size() != 0, "Dictionary is empty");
            list->moveToEnd();
            list->prev();
            KVpair<Key, E> e = list->remove();
            return e.value();
        }
        
        // Find "k" using sequential search
        E find(const Key& k) const {
            for(list->moveToStart(); list->currPos() < list->length(); list->next()) {
                KVpair<Key, E> temp = list->getValue();
                if (k == temp.key()) return temp.value();
            }
            return NULL;    // "k" does not appear in dictionary
        }
        
        int size() {    // Return list size
            return list->length();
        }
    };
    
    // A simple payroll entry with ID, name, address fields
    class Payroll {
    private:
        int ID;
        std::string name;
        std::string address;
        
    public:
        // Constructor
        Payroll(int inID, std::string inname, std::string inaddr) {
            ID = inID;
            name = inname;
            address = inaddr;
        }
        
        ~Payroll() {}   // Destructor
        
        // Local data member access functions
        int getID() { return ID; }
        std::string getname() { return name; }
        std::string getaddr() { return address; }
    };
}

@end
