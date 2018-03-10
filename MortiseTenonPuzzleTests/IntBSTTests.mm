//
//  IntBSTTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-09.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>

@interface IntBSTTests : XCTestCase
@end

@implementation IntBSTTests

- (void)testIntBST {
    
    /*
            42
           /  \
          59  27
                \
                86
     
     */
    IntBSTTestsNS::TreeNode* node = new IntBSTTestsNS::TreeNode(42);
    node->left = new IntBSTTestsNS::TreeNode(59);
    node->right = new IntBSTTestsNS::TreeNode(27);
    node->right->right = new IntBSTTestsNS::TreeNode(86);
    
    IntBSTTestsNS::TreeSet tree(node);
    
    tree.print();
}

namespace IntBSTTestsNS {
    
    struct TreeNode {
        int data;
        TreeNode* left;
        TreeNode* right;
        
        TreeNode(int data, TreeNode* left = NULL, TreeNode* right = NULL) {
            this->data = data;
            this->left = left;
            this->right = right;
        }
        
        bool ifLeaf() {
            return left == NULL && right == NULL;
        }
    };
    
    class TreeSet {
    public:
        bool contains(int);
        void printSideways();
        
        TreeSet(TreeNode* initialRoot) {
            root = initialRoot;
        }
        
        void print() {
            printHelper(root);
        }
        
    private:
        TreeNode* root;
        
        void printHelper(TreeNode* node) {
            if (node != NULL) {
                std::cout << node->data << std::endl;
                printHelper(node->left);
                printHelper(node->right);
            }
        }
    };
}

@end
