//
//  BitMatrix.h
//  MyUIView
//
//  Created by Li Kai on 13-4-1.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#ifndef MyUIView_BitMatrix_h
#define MyUIView_BitMatrix_h

typedef unsigned char byte;

typedef struct
{
    byte* bits;
    int rows;
    int cols;
} BitMatrix;

#ifdef __cplusplus
extern "C" {
#endif
    
    extern BitMatrix CreateBitMatrix (int rows, int cols);
    
    extern void ReleaseBitMatrix (BitMatrix* bm);
    
    extern void BitMatrixSetBit (BitMatrix* bm, int row, int col, int value);
    
    extern void BitMatrixSetAllBits (BitMatrix* bm, int value);
    
    extern int BitMatrixGet (BitMatrix* bm, int row, int col);
    
#ifdef __cplusplus
}
#endif

#endif
