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

- (void)testAdd {
    
    /*
     *
     *    42
     *   /  \
     * 27    59
     *        \
     *         86
     *
     */
    
    TreeSetTestsNS::TreeSet tree;
    tree.add(42);
    tree.add(59);
    tree.add(27);
    tree.add(86);
    
    tree.print();
}

- (void)testCoolAdd {
    
    /*
     *
     *    42
     *   /  \
     * 27    59
     *        \
     *         86
     *
     */
    
    TreeSetTestsNS::TreeSet tree;
    tree.coolAdd(42);
    tree.coolAdd(59);
    tree.coolAdd(27);
    tree.coolAdd(86);
    
    XCTAssertTrue(tree.contains(42));
    XCTAssertTrue(tree.contains(59));
    XCTAssertTrue(tree.contains(27));
    XCTAssertTrue(tree.contains(86));
    XCTAssertFalse(tree.contains(87));
}

- (void)testCoolContains {
    
    TreeSetTestsNS::TreeSet tree;
    tree.coolAdd(42);
    tree.coolAdd(59);
    tree.coolAdd(27);
    tree.coolAdd(86);
    
    /*
     *
     *    42
     *   /  \
     * 27    59
     *        \
     *         86
     *
     */
    
    XCTAssertTrue(tree.contains(86));
    std::cout << "==================================" << std::endl;
    XCTAssertTrue(tree.coolContains(86));
}

- (void)testGetMin {
    TreeSetTestsNS::TreeSet tree;
    tree.coolAdd(42);
    tree.coolAdd(59);
    tree.coolAdd(27);
    tree.coolAdd(86);
    
    /*
     *
     *    42
     *   /  \
     * 27    59
     *        \
     *         86
     *
     */
    XCTAssertEqual(27, tree.getMin());
}

- (void)testRemove {
    TreeSetTestsNS::TreeSet tree;
    tree.coolAdd(4);
    tree.coolAdd(2);
    tree.coolAdd(5);
    tree.coolAdd(1);
    tree.coolAdd(7);
    tree.coolAdd(6);
    tree.coolAdd(3);
    
    /*
     *
     *      4
     *    /   \
     *   2     5
     *  / \   / \
     * 1   3 6   7
     *
     */
    XCTAssertTrue(tree.contains(5));
    tree.remove(5);
    XCTAssertFalse(tree.contains(5));
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
        
        bool isLeaf() {
            return left == NULL && right == NULL;
        }
    };
    
    class TreeSet {
    public:
        void printSideways();
        
        TreeSet() {
            root = NULL;
        }
        
        void add(int value) {
            add(root, value);
        }
        
        void coolAdd(int value) {
            coolAdd(root, value);
        }
        
        void print() const {
            print(root);
        }
        
        bool contains(int value) const {
            return contains(root, value);
        }
        
        bool coolContains(int value) const {
            return coolContains(root, value);
        }
        
        int getMin() const {
            return getMin(root);
        }
        
        void remove(int value) {
            remove(root, value);
        }
        
    private:
        TreeNode* root;
        
        void add(TreeNode* node, int value) {
            if (root == NULL) {
                root = new TreeNode(value);
            } else if (value < node->data) {
                if (node->left == NULL) {
                    node->left = new TreeNode(value);
                } else {
                    add(node->left, value);
                }
            } else if (value > node->data) {
                if (node->right == NULL) {
                    node->right = new TreeNode(value);
                } else {
                    add(node->right, value);
                }
            }
        }
        
        void coolAdd(TreeNode*& node, int value) {
            if (node == NULL) {
                node = new TreeNode(value);
            } else if (value < node->data) {
                coolAdd(node->left, value);
            } else if (value > node->data) {
                coolAdd(node->right, value);
            }
        }
        
        void print(TreeNode* node) const {
            if (node != NULL) {
                print(node->left);
                std::cout << node->data << std::endl;
                print(node->right);
            }
        }
        
        bool coolContains(TreeNode* node, int value) const {
            if (node == NULL) {
                std::cout << "_______________ NULL _______________" << std::endl;
            } else {
                std::cout << node->data << std::endl;
            }
            
            if (node == NULL) {
                return false;
            } else if (value == node->data) {
                return true;
            } else if (value < node->data) {
                return coolContains(node->left, value);
            } else {
                return coolContains(node->right, value);
            }
        }
        
        bool contains(TreeNode* node, int value) const {
            if (node == NULL) {
                std::cout << "_______________ NULL _______________" << std::endl;
            } else {
                std::cout << node->data << std::endl;
            }
            
            if (node == NULL) {
                return false;
            } else if (value == node->data) {
                return true;
            } else {
                return contains(node->left, value) || contains(node->right, value);
            }
        }
        
        int getMin(TreeNode* node) const {
            if (node == NULL) {
                throw "node is NULL";
            } else if (node->left == NULL) {
                return node->data;
            } else {
                return getMin(node->left);
            }
        }
        
        void remove(TreeNode*& node, int value) {
            if (node == NULL) {
                return;
            }
            
            if (value == node->data) {
                TreeNode* trash = NULL;
                if (node->isLeaf()) {
                    trash = node;
                    node = NULL;
                } else if (node->left == NULL) {
                    trash = node;
                    node = node->right;
                } else if (node->right == NULL) {
                    trash = node;
                    node = node->left;
                } else {
                    node->data = getMin(node->right);
                    remove(node->right, node->data);
                }
                if (trash != NULL) {
                    delete trash;
                    trash = NULL;
                }
            } else if (value < node->data) {
                remove(node->left, value);
            } else {
                remove(node->right, value);
            }
        }
    };
}

@end

