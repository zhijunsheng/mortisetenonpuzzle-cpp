//
//  templatevector.h
//  MortiseTenonPuzzle
//
//  Created by Donald Sheng on 2018-02-28.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#ifndef templatevector_h
#define templatevector_h


#endif /* templatevector_h */

namespace TemplateTestsNS {
    // TemplateVector - a simple templatized vector class
    template <typename T> class TemplateVector {
    public:
        TemplateVector(int arraySize) {
            // store off the number of elements
            sz = arraySize;
            array = new T[arraySize];
            reset();
        }
        
        int size() { return writeIndex; }
        
        void reset() { writeIndex = 0; readIndex = 0; }
        
        void add(const T& object) {
            if (writeIndex < sz) {
                array[writeIndex++] = object;
            }
        }
        
        T& get() {
            return array[readIndex++];
        }
        
    protected:
        int sz;
        int writeIndex;
        int readIndex;
        T* array;
    };
}
