//
//  BSTTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-03.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "binnode.h"

@interface BSTTests : XCTestCase
@end

@implementation BSTTests

- (void)testBST {
    
    
    
}

namespace BSTTestsNS {
    
    // Simple binary tree node implementation
    template <typename Key, typename E>
    class BSTNode : public BinaryTreeTestsNS::BinNode<E> {
    private:
        Key k;          // The node's key
        E it;           // The node's value
        BSTNode* lc;    // Pointer to left child
        BSTNode* rc;    // Pointer to right child
        
    public:
        // Two constructors - with and without initial values
        BSTNode() { lc = rc = nullptr; }
        BSTNode(Key K, E e, BSTNode* l = nullptr, BSTNode* r = nullptr) {
            k = K;
            it = e;
            lc = l;
            rc = r;
        }
        ~BSTNode() {}   // Destructor
        
        // Functions to set and return the value and key
        E& element() { return it; }
        void setElement(const E& e) { it = e; }
        Key& key() { return k; }
        void setKey(const Key& K) { k = K; }
        
        // Functions to set and return the children
        inline BSTNode* left() const { return lc; }
        void setLeft(BinaryTreeTestsNS::BinNode<E>* b) { lc = (BSTNode*)b; }
        inline BSTNode* right() const { return rc; }
        void setRight(BinaryTreeTestsNS::BinNode<E>* b) { rc = (BSTNode*)b; }
        
        // Return true if it is a leaf, false otherwise
        bool isLeaf() { return lc == nullptr && rc == nullptr; }
    };
    
    
}

@end


