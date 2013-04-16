#include "AlViewContainerLayout.h"


pthread_mutex_t* AlViewContainerLayout::pMutexForChild = NULL;

//static pthread_mutex_t globalMutexForChild;
pthread_mutex_t AlViewContainerLayout::mutexForChild;// = globalMutexForChild;

void AlViewContainerLayout::addChild_nts (AlViewLayout* child, AlViewLayoutParameter layoutParam)
{
    if (NULL != child->_parent && this != child->_parent)
    {
        throw "Cannot add a layout child to other parent.";
    }
    if (this == child->_parent) return;
    
    child->_parent = this;
    
    ChildPair cp;
    cp.child = child;
    cp.parameter = layoutParam;
    
    children.insert(make_pair(currentUsableID, cp));
    child2IdMap.insert(make_pair(child, currentUsableID));
    currentUsableID++;
}

void AlViewContainerLayout::addChild (AlViewLayout* child, AlViewLayoutParameter layoutParam)
{
    if (NULL == pMutexForChild)
    {
        pMutexForChild = &mutexForChild;
        pthread_mutex_init(pMutexForChild, NULL);
    }
    
    pthread_mutex_lock(pMutexForChild);
    {
        if (NULL != child->_parent && this != child->_parent)
        {
            throw "Cannot add a layout child to other parent.";
        }
        
        if (this == child->_parent)
        {
            map<AlViewLayout*, int>::iterator foundCID = child2IdMap.find(child);
            children.erase(foundCID->second);
            
            ChildPair cp;
            cp.child = child;
            cp.parameter = layoutParam;
            children.insert(make_pair(foundCID->second, cp));
            return;
        }
        
        child->_parent = this;
    }
    pthread_mutex_unlock(pMutexForChild);
    
    ChildPair cp;
    cp.child = child;
    cp.parameter = layoutParam;
    
    pthread_mutex_lock(&mutexForID);
    {
        children.insert(make_pair(currentUsableID, cp));
        child2IdMap.insert(make_pair(child, currentUsableID));
        currentUsableID++;
    }
    pthread_mutex_unlock(&mutexForID);
}

void AlViewContainerLayout::removeChild (AlViewLayout* child)
{
    
    map<AlViewLayout*, int>::iterator found = child2IdMap.find(child);
    if (child2IdMap.end() != found)
    {
        child->_parent = NULL;
        children.erase(found->second);
    }
}
