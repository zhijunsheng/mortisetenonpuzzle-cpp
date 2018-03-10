//
//  TreeSetTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-03-10.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>

@interface TreeSetTests : XCTestCase
@end

@implementation TreeSetTests

- (void)testIntBST {
    
    /*
     42
     /  \
     59  27
     \
     86
     
     */
    TreeSetTestsNS::TreeNode* node = new TreeSetTestsNS::TreeNode(42);
    node->left = new TreeSetTestsNS::TreeNode(59);
    node->right = new TreeSetTestsNS::TreeNode(27);
    node->right->right = new TreeSetTestsNS::TreeNode(86);
    
    TreeSetTestsNS::TreeSet tree(node);
    
    tree.print();
}

namespace TreeSetTestsNS {
    
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

