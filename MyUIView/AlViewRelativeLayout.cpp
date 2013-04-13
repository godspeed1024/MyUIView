//
//  AlViewRelativeLayout.cpp
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#define HALF_CONSTRAINTS

#include <stdlib.h>
#include "AlViewRelativeLayout.h"

void AlViewRelativeLayout::setLayoutRelation (int leftOperandID, int rightOperandID, int layoutRelation)
{
    LayoutConstraint lc;
    lc.leftOperandID = leftOperandID;
    lc.rightOperandID = rightOperandID;
    lc.relation = layoutRelation;
    interpretLayoutConstraint(lc);
}

void AlViewRelativeLayout::interpretLayoutConstraint (LayoutConstraint originalLC)
{
    LayoutConstraint lc = originalLC;
    lc.leftOperandID <<= 3;
    lc.rightOperandID <<= 3;
    lc.constant = 0;

    switch (originalLC.relation)
    {
        case kLayoutRelationAbove:
            // L.Bottom >= R.Top
            lc.leftOperandID |= VAR_BOTTOM;
            lc.rightOperandID |= VAR_TOP;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Bottom <= R.Top
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
#ifndef HALF_CONSTRAINTS
            // R.Top <= L.Bottom
            lc.leftOperandID ^= lc.rightOperandID;
            lc.rightOperandID ^= lc.leftOperandID;
            lc.leftOperandID ^= lc.rightOperandID;
            interpretedConstraints.push_back(lc);
            
            // R.Top >= L.Bottom
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
#endif
            break;
        case kLayoutRelationBelow:
            // R.Bottom <= L.Top
            lc.rightOperandID |= VAR_BOTTOM;
            lc.leftOperandID |= VAR_TOP;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // R.Bottom >= L.Top
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
#ifndef HALF_CONSTRAINTS
            // L.Top >= R.Bottom
            lc.leftOperandID ^= lc.rightOperandID;
            lc.rightOperandID ^= lc.leftOperandID;
            lc.leftOperandID ^= lc.rightOperandID;
            interpretedConstraints.push_back(lc);
            
            // L.Top <= R.Bottom
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
#endif
            break;///
        case kLayoutRelationToLeftOf:
            // L.Right >= R.Left
            lc.leftOperandID |= VAR_RIGHT;
            lc.rightOperandID |= VAR_LEFT;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Right <= R.Left
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
#ifndef HALF_CONSTRAINTS
            // R.Left <= L.Right
            lc.leftOperandID ^= lc.rightOperandID;
            lc.rightOperandID ^= lc.leftOperandID;
            lc.leftOperandID ^= lc.rightOperandID;
            interpretedConstraints.push_back(lc);
            
            // R.Left >= L.Right
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
#endif
            break;
        case kLayoutRelationToRightOf:
            // R.Right <= L.Left
            lc.rightOperandID |= VAR_RIGHT;
            lc.leftOperandID |= VAR_LEFT;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // R.Right >= L.Left
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
#ifndef HALF_CONSTRAINTS
            // L.Left >= R.Right
            lc.leftOperandID ^= lc.rightOperandID;
            lc.rightOperandID ^= lc.leftOperandID;
            lc.leftOperandID ^= lc.rightOperandID;
            interpretedConstraints.push_back(lc);
            
            // L.Left <= R.Right
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
#endif
            break;
        case kLayoutRelationAlignTopWith:
            // L.Top >= R.Top
            lc.leftOperandID |= VAR_TOP;
            lc.rightOperandID |= VAR_TOP;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Top <= R.Top
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
#ifndef HALF_CONSTRAINTS
            // R.Top <= L.Top
            lc.leftOperandID ^= lc.rightOperandID;
            lc.rightOperandID ^= lc.leftOperandID;
            lc.leftOperandID ^= lc.rightOperandID;
            interpretedConstraints.push_back(lc);
            
            // R.Top >= L.Top
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
#endif
            break;
            
        case kLayoutRelationAlignBottomWith:
            // L.Bottom >= R.Bottom
            lc.leftOperandID |= VAR_BOTTOM;
            lc.rightOperandID |= VAR_BOTTOM;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Bottom <= R.Bottom
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
#ifndef HALF_CONSTRAINTS
            // R.Bottom <= L.Bottom
            lc.leftOperandID ^= lc.rightOperandID;
            lc.rightOperandID ^= lc.leftOperandID;
            lc.leftOperandID ^= lc.rightOperandID;
            interpretedConstraints.push_back(lc);
            
            // R.Bottom >= L.Bottom
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
#endif
            break;
        case kLayoutRelationAlignLeftWith:
            // L.Left >= R.Left
            lc.leftOperandID |= VAR_LEFT;
            lc.rightOperandID |= VAR_LEFT;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Left <= R.Left
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
#ifndef HALF_CONSTRAINTS
            // R.Left <= L.Left
            lc.leftOperandID ^= lc.rightOperandID;
            lc.rightOperandID ^= lc.leftOperandID;
            lc.leftOperandID ^= lc.rightOperandID;
            interpretedConstraints.push_back(lc);
            
            // R.Left >= L.Left
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
#endif
            break;
        case kLayoutRelationAlignRightWith:
            // L.Right >= R.Right
            lc.leftOperandID |= VAR_RIGHT;
            lc.rightOperandID |= VAR_RIGHT;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Right <= R.Right
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
#ifndef HALF_CONSTRAINTS
            // R.Right <= L.Right
            lc.leftOperandID ^= lc.rightOperandID;
            lc.rightOperandID ^= lc.leftOperandID;
            lc.leftOperandID ^= lc.rightOperandID;
            interpretedConstraints.push_back(lc);
            
            // R.Right >= L.Right
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
#endif
            break;
            
        case kLayoutRelationAlignParentLeft:
            lc.rightOperandID = NA_VAR;
            lc.leftOperandID |= VAR_LEFT;
            suspendingConstraints.push_back(lc);
            
            break;
        case kLayoutRelationAlignParentRight:
            lc.rightOperandID = NA_VAR;
            lc.leftOperandID |= VAR_RIGHT;
            suspendingConstraints.push_back(lc);
            
            break;
        case kLayoutRelationAlignParentTop:
            lc.rightOperandID = NA_VAR;
            lc.leftOperandID |= VAR_TOP;
            suspendingConstraints.push_back(lc);
            
            break;
        case kLayoutRelationAlignParentBottom:
            lc.rightOperandID = NA_VAR;
            lc.leftOperandID |= VAR_BOTTOM;
            suspendingConstraints.push_back(lc);
            
            break;
            
    }
}


void AlViewRelativeLayout::interpretLayoutConstraint (list<LayoutConstraint>* reinterpretedConstraints, LayoutConstraint originalLC, CGSize bound)
{
    LayoutConstraint lc = originalLC;
    switch (lc.relation)
    {
        case kLayoutRelationAlignParentLeft:
            lc.constant = 0;

            // L.Left <= 0
            lc.relation = 0;
            reinterpretedConstraints->push_back(lc);

            // L.Left >= 0
            lc.relation = 1;
            reinterpretedConstraints->push_back(lc);
            
            break;
        case kLayoutRelationAlignParentRight:
            lc.constant = bound.width;

            // L.Right <= 0
            lc.relation = 0;
            reinterpretedConstraints->push_back(lc);

            // L.Right >= 0
            lc.relation = 1;
            reinterpretedConstraints->push_back(lc);

            break;
        case kLayoutRelationAlignParentTop:
            lc.constant = 0;

            // L.Top <= 0
            lc.relation = 0;
            reinterpretedConstraints->push_back(lc);

            // L.Top >= 0
            lc.relation = 1;
            reinterpretedConstraints->push_back(lc);

            break;
        case kLayoutRelationAlignParentBottom:
            lc.constant = bound.height;
            
            // L.Bottom <= HEIGHT
            lc.relation = 0;
            reinterpretedConstraints->push_back(lc);

            // L.Bottom >= 0
            lc.relation = 1;
            reinterpretedConstraints->push_back(lc);

            break;
            
        case kLayoutRelationSetSelfBound:
            int shiftID = lc.leftOperandID << 3;
            
            // L.Left <= R.Right - Width
            lc.leftOperandID = shiftID | VAR_LEFT;
            lc.rightOperandID = shiftID | VAR_RIGHT;
            lc.constant = -bound.width;
            lc.relation = 0;
            reinterpretedConstraints->push_back(lc);
#ifndef HALF_CONSTRAINTS
            // L.Right >= R.Left + Width
            lc.leftOperandID = shiftID | VAR_RIGHT;
            lc.rightOperandID = shiftID | VAR_LEFT;
            lc.constant = bound.width;
            lc.relation = 1;
            reinterpretedConstraints->push_back(lc);
#endif
            // L.Top <= R.Bottom - Height
            lc.leftOperandID = shiftID | VAR_TOP;
            lc.rightOperandID = shiftID | VAR_BOTTOM;
            lc.constant = -bound.height;
            lc.relation = 0;
            reinterpretedConstraints->push_back(lc);
#ifndef HALF_CONSTRAINTS
            // L.Bottom >= R.Top + Height
            lc.leftOperandID = shiftID | VAR_BOTTOM;
            lc.rightOperandID = shiftID | VAR_TOP;
            lc.constant = bound.height;
            lc.relation = 1;
            reinterpretedConstraints->push_back(lc);
#endif
            break;
    }
}

void AlViewRelativeLayout::onMeasure (AlViewLayoutParameter givenLayoutParam)
{
    CGSize myBound = givenLayoutParam.givenSize;
    
    list<LayoutConstraint> constraints;
    constraints.splice(constraints.end(), interpretedConstraints);
    
    LayoutConstraint lc;
    lc.relation = kLayoutRelationSetSelfBound;
    
    for (map<int, ChildPair>::iterator iter = children.begin(); iter != children.end(); iter++)
    {
        ChildPair cp = iter->second;
        cp.child->onMeasure(cp.parameter);
        lc.leftOperandID = iter->first;
        interpretLayoutConstraint(&constraints, lc, cp.child->getMinimalMeasuredSize());
    }
    
    for (list<LayoutConstraint>::iterator iter = suspendingConstraints.begin(); iter != suspendingConstraints.end(); iter++)
    {
        interpretLayoutConstraint(&constraints, *iter, myBound);
    }
    
    createRelationGraphs(relationGraphs, &constraints);
    solveRelationGraphs(relationGraphs, currentUsableID + 1);
    
    for (map<int, RelationGraphNode*>::iterator iter = relationGraphs.begin(); iter != relationGraphs.end(); iter++)
    {
        RelationGraphNode* curNode = iter->second;
        printf("Node#%d : [%d, %d]\n", iter->first, curNode->rangeBounds[0], curNode->rangeBounds[1]);
    }
    
    decideRelationGraphs(relationGraphs, currentUsableID + 1);
    
    for (map<int, RelationGraphNode*>::iterator iter = relationGraphs.begin(); iter != relationGraphs.end(); iter++)
    {
        RelationGraphNode* curNode = iter->second;
        printf("Node#%d : [%d, %d]\n", iter->first, curNode->rangeBounds[0], curNode->rangeBounds[1]);
    }
    
    for (map<int, ChildPair>::iterator iter = children.begin(); iter != children.end(); iter++)
    {
        ChildPair cp = iter->second;
        int id = iter->first << 3;
        int left = relationGraphs[id | VAR_LEFT]->rangeBounds[0];
        int top = relationGraphs[id | VAR_TOP]->rangeBounds[0];
        int right = relationGraphs[id | VAR_RIGHT]->rangeBounds[0];
        int bottom = relationGraphs[id | VAR_BOTTOM]->rangeBounds[0];
        cp.child->_layoutedRect = CGRectMake(left, top, right - left, bottom - top);
        cp.child->applyLayout();///!!!
    }
    
    setMinimalMeasuredSize(givenLayoutParam.givenSize.width, givenLayoutParam.givenSize.height);
    setDesiredMeasuredSize(givenLayoutParam.givenSize.width, givenLayoutParam.givenSize.height);
    _layoutedRect = CGRectMake(0, 0, _minimalMeasuredSize.width, _minimalMeasuredSize.height);
}

void doRecursiveTraverse (RelationGraphNode* curNode, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge,
                          void* params, CallbackInTraversingRelationGraph callback)
{
    BitMatrix* pBitmap = (BitMatrix*) ((void**) params)[0];
    void* callbackParam = ((void**) params)[1];
    
    BitMatrixSetBit(pBitmap, 0, curNode->id, 1);
    if (NULL != callback)
    {
        bool skip = (*callback)(curNode, direction, fromNode, edge, callbackParam);
        if (skip)
        {
            return;
        }
        
        for (list<RelationGraphEdge>::iterator iter = curNode->edgesFromMe[direction].begin();
             iter != curNode->edgesFromMe[direction].end(); iter++)
        {
            RelationGraphNode* nextNode = iter->nextNode;
            if (NULL == nextNode) continue;
            if (1 == BitMatrixGet(pBitmap, 0, nextNode->id)) continue;
            
            doRecursiveTraverse(nextNode, direction, curNode, (RelationGraphEdge*) &*iter, params, callback);
        }
    }
    BitMatrixSetBit(pBitmap, 0, curNode->id, 0);
}

void AlViewRelativeLayout::recursiveTraverseRelationGraph (RelationGraphNode* startNode, int nodeCount,
                                     void* param, CallbackInTraversingRelationGraph callback)
{
    BitMatrix bm = CreateBitMatrix(1, nodeCount);
    
    void* params[2];
    params[0] = &bm;
    params[1] = param;
    
    for (int direction = 0; direction < 2; direction++)
    {
        BitMatrixSetAllBits(&bm, 0);
        doRecursiveTraverse(startNode, direction, NULL, NULL, params, callback);
    }
    
    ReleaseBitMatrix(&bm);
}

bool updateRangeBounds (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param)
{
    if (NULL == fromNode)
    {
        if (NA_RANGE == node->rangeBounds[direction])
            return true;
        else
            return false;
    }
    
    int newBoundValue = fromNode->rangeBounds[direction] - edge->weight;
    if (NA_RANGE == node->rangeBounds[direction] ||
        (0 == direction && newBoundValue > node->rangeBounds[0]) ||
        (1 == direction && newBoundValue < node->rangeBounds[1]))
    {
        node->rangeBounds[direction] = newBoundValue;
        return false;///!!!
    }
    else
    {
        return true;
    }
}

bool decideRangeBounds (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param)
{
    if (NULL == fromNode)
    {
        if (node->rangeBounds[1] == node->rangeBounds[0])
        {
            return true;
        }
        else if (node->rangeBounds[0] != NA_RANGE)
        {
            node->rangeBounds[1] = node->rangeBounds[0];
            return false;
        }
        else if (node->rangeBounds[1] != NA_RANGE)
        {
            node->rangeBounds[0] = node->rangeBounds[1];
            return false;
        }
    }
    ///else
    ///{
        int newBoundValue = fromNode->rangeBounds[direction] - edge->weight;
        if (NA_RANGE == node->rangeBounds[direction] ||
            (0 == direction && newBoundValue > node->rangeBounds[0]) ||
            (1 == direction && newBoundValue < node->rangeBounds[1]))
        {
            node->rangeBounds[direction] = newBoundValue;
            return false;///!!!
        }
        else
        {
            return true;
        }
    ///}
    /*
    if (node->rangeBounds[1] == node->rangeBounds[0])
    {
        return true;
    }
    else if (node->rangeBounds[0] != NA_RANGE)
    {
        node->rangeBounds[1] = node->rangeBounds[0];
    }
    else if (node->rangeBounds[1] != NA_RANGE)
    {
        node->rangeBounds[0] = node->rangeBounds[1];
    }
    
    int direction = *(int*)param;
    RelationGraphNode* nextNode = edge->nextNode;
    
    int newBoundValue = node->rangeBounds[0] - edge->weight;
    if (NA_RANGE == nextNode->rangeBounds[direction] ||
        (0 == direction && newBoundValue > nextNode->rangeBounds[0]) ||
        (1 == direction && newBoundValue < nextNode->rangeBounds[1]))
    {
        nextNode->rangeBounds[direction] = newBoundValue;
        return false;
    }
    else
    {
        return true;
    }
     /*/
    return true;
    ///!!!*/
}

void AlViewRelativeLayout::solveRelationGraphs (map<int, RelationGraphNode*>& graphs, int nodeCount)
{
    for (map<int, RelationGraphNode*>::iterator iter = graphs.begin(); iter != graphs.end(); iter++)
    {
        // Find one node, at least one of which ranges can be confirmed :
        RelationGraphNode* node = iter->second;
        recursiveTraverseRelationGraph(node, nodeCount, &graphs, updateRangeBounds);
    }
}

void AlViewRelativeLayout::decideRelationGraphs (map<int, RelationGraphNode*>& graphs, int nodeCount)
{
    for (map<int, RelationGraphNode*>::iterator iter = graphs.begin(); iter != graphs.end(); iter++)
    {
        // Find one node, at least one of which ranges can be confirmed :
        RelationGraphNode* node = iter->second;
        recursiveTraverseRelationGraph(node, nodeCount, &graphs, decideRangeBounds);
    }
}

void AlViewRelativeLayout::clearRelationGraph (map<int, RelationGraphNode*>& graph)
{
    for (map<int, RelationGraphNode*>::iterator iter = graph.begin(); iter != graph.end(); iter++)
    {
        if (NULL != iter->second)
        {
            delete iter->second;
        }
    }
    graph.clear();
}

void AlViewRelativeLayout::createRelationGraphs (map<int, RelationGraphNode*>& graphs, list<LayoutConstraint>* constraints)
{
    clearRelationGraph(graphs);
    
    int maxVars = 2 * constraints->size();
    RelationGraphNode** nodes = new RelationGraphNode*[maxVars];
    
    for (list<LayoutConstraint>::iterator iter = constraints->begin(); iter != constraints->end(); iter++)
    {
        RelationGraphNode* pLeftNode;
        if (NULL == nodes[iter->leftOperandID])
        {
            pLeftNode = new RelationGraphNode(iter->leftOperandID);
            nodes[iter->leftOperandID] = pLeftNode;
            
            graphs.insert(make_pair(iter->leftOperandID, pLeftNode));
        }
        else
        {
            pLeftNode = nodes[iter->leftOperandID];
        }
        
        RelationGraphNode* pRightNode = NULL;
        if (NA_VAR != iter->rightOperandID)
        {
            if (NULL == nodes[iter->rightOperandID])
            {
                pRightNode = new RelationGraphNode(iter->rightOperandID);
                nodes[iter->rightOperandID] = pRightNode;
                
                graphs.insert(make_pair(iter->rightOperandID, pRightNode));
            }
            else
            {
                pRightNode = nodes[iter->rightOperandID];
            }
            
            RelationGraphEdge edge;
            edge.nextNode = pRightNode;
            edge.weight = iter->constant;
            pLeftNode->edgesFromMe[iter->relation].push_back(edge);
            
            edge.nextNode = pLeftNode;
            edge.weight = -iter->constant;
            pRightNode->edgesFromMe[1 - iter->relation].push_back(edge);
        }
        else
        {
            if (NA_RANGE == pLeftNode->rangeBounds[1 - iter->relation] ||
                (0 == iter->relation && pLeftNode->rangeBounds[1] > iter->constant) ||
                (1 == iter->relation && pLeftNode->rangeBounds[0] < iter->constant))
            {
                pLeftNode->rangeBounds[1 - iter->relation] = iter->constant;
            }
        }
    }
    
    delete[] nodes;
}

