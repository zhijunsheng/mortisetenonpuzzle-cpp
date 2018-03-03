//
//  binnode.h
//  MortiseTenonPuzzle
//
//  Created by Donald Sheng on 2018-03-03.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#ifndef binnode_h
#define binnode_h

namespace BinaryTreeTestsNS {
    // Binary tree node abstract class
    template <typename E> class BinNode {
    public:
        virtual ~BinNode() {}      // Base destructor
        
        // Return the node's value
        virtual E& element() = 0;
        
        // Set the node's value
        virtual void setElement(const E&) = 0;
        
        // Return the node's left child
        virtual BinNode* left() const = 0;
        
        // Set the node's left child
        virtual void setLeft(BinNode*) = 0;
        
        // Return the node's right child
        virtual BinNode* right() const = 0;
        
        // Set the node's right child
        virtual void setRight(BinNode*) = 0;
        
        // Return true if the node is a leaf, false otherwise
        virtual bool isLeaf() = 0;
    };
}

#endif /* binnode_h */
