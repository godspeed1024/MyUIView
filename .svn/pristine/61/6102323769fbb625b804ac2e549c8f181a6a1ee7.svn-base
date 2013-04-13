//
//  AlViewContainerLayout.h
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#ifndef __MyUIView__AlViewContainerLayout__
#define __MyUIView__AlViewContainerLayout__

#include <map>
#include <pthread.h>

#include "AlViewLayout.h"

using namespace std;

typedef struct
{
    AlViewLayout* child;
    AlViewLayoutParameter parameter;
} ChildPair;


class AlViewContainerLayout : public AlViewLayout
{
public:
    
    inline AlViewContainerLayout (void)
    {
        currentUsableID = 0;
        pthread_mutex_init(&mutexForID, NULL);
    }
    
    inline virtual ~AlViewContainerLayout (void)
    {
        
    }
    
    ///!!! Not thread-safe method !!!
    virtual void addChild_nts (AlViewLayout* child, AlViewLayoutParameter layoutParam);
    
    virtual void addChild (AlViewLayout* child, AlViewLayoutParameter layoutParam);
    
    virtual void removeChild (AlViewLayout* child);
    
    //virtual void onMeasure (AlViewLayoutParameter givenLayoutParam);

protected:
    
    map<int, ChildPair> children;
    
    map<AlViewLayout*, int> child2IdMap;
    
    pthread_mutex_t mutexForID;
    int currentUsableID;
    
    static pthread_mutex_t* pMutexForChild;
    static pthread_mutex_t  mutexForChild;
};

#endif /* defined(__MyUIView__AlViewContainerLayout__) */
