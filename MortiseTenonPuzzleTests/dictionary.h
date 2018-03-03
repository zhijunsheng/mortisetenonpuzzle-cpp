//
//  dictionary.h
//  MortiseTenonPuzzle
//
//  Created by Donald Sheng on 2018-03-03.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#ifndef dictionary_h
#define dictionary_h

namespace DictionaryTestsNS {
    
    // The Dictionary abstract class.
    template <typename Key, typename E>
    class Dictionary {
    private:
        void operator =(const Dictionary&) {}   // Protect assignment
        Dictionary(const Dictionary&) {}        // Protect copy constructor
        
    public:
        Dictionary() {}                         // Default constructor
        virtual ~Dictionary() {}                // Base destructor
        
        // Reinitialize dictionary
        virtual void clear() = 0;
        
        // Insert a record
        // k: The key for the record being inserted.
        // e: The record being inserted.
        virtual void insert(const Key& k, const E& e) = 0;
        
        // Remove and return a record.
        // k: The key of the record to be removed.
        // Return: A maching record. If multiple records match "k", remove an arbitrary one. Return NULL if no record with key "k" exists.
        virtual E remove(const Key& k) = 0;
        
        // Remove and return an arbitrary record from dictionary.
        // Return: The record removed, or NULL if none exists.
        virtual E removeAny() = 0;
        
        // Return the number of records in the dictionary.
        virtual int size() = 0;
    };
    
    // Container for a key-value pair
    template <typename Key, typename E>
    class KVpair {
    private:
        Key k;
        E e;
        
    public:
        // Constructor
        KVpair() {}
        KVpair(Key kval, E eval) {
            k = kval;
            e = eval;
        }
        KVpair(const KVpair& o) {   // Copy consructor
            k = o.k;
            e = o.e;
        }
        
        // Data member access functions
        Key key() { return k; }
        void setKey(Key ink) { k = ink; }
        E value() { return e; }
    };
}

#endif /* dictionary_h */
