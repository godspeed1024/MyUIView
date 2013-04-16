//
//  AlViewRelativeLayout.cpp
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#include <stdlib.h>
#include "AlViewRelativeLayout.h"

void AlViewRelativeLayout::addLayoutRelation (int leftOperandID, int rightOperandID, int layoutRelation)
{
    LayoutConstraint lc;
    lc.leftOperandID = leftOperandID;
    lc.rightOperandID = rightOperandID;
    lc.relation = layoutRelation;
    interpretLayoutConstraint(lc);
}

void AlViewRelativeLayout::addLayoutRelation (AlViewLayout* leftOperandChild, AlViewLayout* rightOperandChild, int layoutRelation)
{
    map<AlViewLayout*, int>::iterator leftOpr = child2IdMap.find(leftOperandChild);
    if (child2IdMap.end() == leftOpr)
    {
        AlViewLayoutParameter lp;
        addChild(leftOperandChild, lp);
    }
    map<AlViewLayout*, int>::iterator rightOpr = child2IdMap.find(const_cast<AlViewLayout*>(rightOperandChild));
    if (child2IdMap.end() == rightOpr)
    {
        AlViewLayoutParameter lp;
        addChild(rightOperandChild, lp);
    }
    
    LayoutConstraint lc;
    lc.leftOperandID = leftOpr->second;
    lc.rightOperandID = rightOpr->second;
    lc.relation = layoutRelation;
    interpretLayoutConstraint(lc);
}

void AlViewRelativeLayout::interpretLayoutConstraint (LayoutConstraint originalLC)
{
    LayoutConstraint lc = originalLC;
    
    map<int, ChildPair>::iterator leftChildPair = children.find(lc.leftOperandID);
    map<int, ChildPair>::iterator rightChildPair = children.find(lc.rightOperandID);
    
    lc.leftOperandID <<= 3;
    lc.rightOperandID <<= 3;
    lc.constant = 0;

    switch (originalLC.relation)
    {
        case kLayoutRelationAbove:
            // L.Bottom >= R.Top - (L.MarginBottom + R.MarginTop)
            lc.leftOperandID |= VAR_BOTTOM;
            lc.rightOperandID |= VAR_TOP;
            lc.constant = - leftChildPair->second.parameter.marginBottom - rightChildPair->second.parameter.marginTop;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Bottom <= R.Top - (L.MarginBottom + R.MarginTop)
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
            break;
        case kLayoutRelationBelow:
            // R.Bottom <= L.Top - (R.MarginBottom + L.MarginTop)
            lc.rightOperandID |= VAR_BOTTOM;
            lc.leftOperandID |= VAR_TOP;
            lc.constant = leftChildPair->second.parameter.marginTop + rightChildPair->second.parameter.marginBottom;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // R.Bottom >= L.Top - (R.MarginBottom + L.MarginTop)
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
            break;///
        case kLayoutRelationToLeftOf:
            // L.Right >= R.Left - (L.MarginRight + R.MarginLeft)
            lc.leftOperandID |= VAR_RIGHT;
            lc.rightOperandID |= VAR_LEFT;
            lc.constant = - leftChildPair->second.parameter.marginRight - rightChildPair->second.parameter.marginLeft;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Right <= R.Left - (L.MarginRight + R.MarginLeft)
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
            break;
        case kLayoutRelationToRightOf:
            // R.Right <= L.Left - (R.MarginRight + L.MarginLeft)
            lc.rightOperandID |= VAR_RIGHT;
            lc.leftOperandID |= VAR_LEFT;
            lc.constant = leftChildPair->second.parameter.marginLeft + rightChildPair->second.parameter.marginRight;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // R.Right >= L.Left - (R.MarginRight + L.MarginLeft)
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
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
            break;
            
        case kLayoutRelationAlignParentLeft:
        case kLayoutRelationAlignParentRight:
        case kLayoutRelationAlignParentTop:
        case kLayoutRelationAlignParentBottom:
            lc.rightOperandID = NA_VAR;
            suspendingConstraints.push_back(lc);
            
            break;
            
    }
}


void AlViewRelativeLayout::interpretLayoutConstraint (list<LayoutConstraint>* reinterpretedConstraints, LayoutConstraint originalLC, CGSize bound)
{
    LayoutConstraint lc = originalLC;
    map<int, ChildPair>::iterator leftChildPair = children.find(lc.leftOperandID >> 3);
    
    switch (lc.relation)
    {
        case kLayoutRelationAlignParentLeft:
            lc.leftOperandID |= VAR_LEFT;
            lc.constant = leftChildPair->second.parameter.marginLeft;

            // L.Left <= L.MarginLeft
            lc.relation = 0;
            reinterpretedConstraints->push_back(lc);

            // L.Left >= L.MarginLeft
            lc.relation = 1;
            reinterpretedConstraints->push_back(lc);
            
            break;
        case kLayoutRelationAlignParentRight:
            lc.leftOperandID |= VAR_RIGHT;
            lc.constant = bound.width - leftChildPair->second.parameter.marginRight;

            // L.Right <= Width - L.MarginRight
            lc.relation = 0;
            reinterpretedConstraints->push_back(lc);

            // L.Right >= Width - L.MarginRight
            lc.relation = 1;
            reinterpretedConstraints->push_back(lc);

            break;
        case kLayoutRelationAlignParentTop:
            lc.leftOperandID |= VAR_TOP;
            lc.constant = leftChildPair->second.parameter.marginTop;

            // L.Top <= L.MarginTop
            lc.relation = 0;
            reinterpretedConstraints->push_back(lc);

            // L.Top >= L.MarginTop
            lc.relation = 1;
            reinterpretedConstraints->push_back(lc);

            break;
        case kLayoutRelationAlignParentBottom:
            lc.leftOperandID |= VAR_BOTTOM;
            lc.constant = bound.height - leftChildPair->second.parameter.marginBottom;
            
            // L.Bottom <= HEIGHT - L.MarginBottom
            lc.relation = 0;
            reinterpretedConstraints->push_back(lc);

            // L.Bottom >= HEIGHT - L.MarginBottom
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
            
            // L.Top <= R.Bottom - Height
            lc.leftOperandID = shiftID | VAR_TOP;
            lc.rightOperandID = shiftID | VAR_BOTTOM;
            lc.constant = -bound.height;
            lc.relation = 0;
            reinterpretedConstraints->push_back(lc);
            
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
    
    updateRelationGraphs(relationGraphs, &constraints);
    
    solveRelationGraphs(relationGraphs, currentUsableID + 1);
    
    for (map<int, RelationGraphNode*>::iterator iter = relationGraphs.begin(); iter != relationGraphs.end(); iter++)
    {
        RelationGraphNode* curNode = iter->second;
        printf("Node#%d : [%d, %d]\n", iter->first, curNode->rangeBounds[0], curNode->rangeBounds[1]);
    }
    
    decideRelationGraphs(relationGraphs, currentUsableID + 1, myBound);
    
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
    int* minAndMax = (int*) param;
    
    if (NULL == fromNode)
    {
        if (node->rangeBounds[1] == node->rangeBounds[0])
        {
            return true;
        }
        else if (node->rangeBounds[0] != NA_RANGE)
        {
            node->rangeBounds[1] = node->rangeBounds[0];
            
            if (node->rangeBounds[0] < minAndMax[0])
            {
                minAndMax[0] = node->rangeBounds[0];
            }
            if (node->rangeBounds[0] > minAndMax[1])
            {
                minAndMax[1] = node->rangeBounds[0];
            }
            
            return false;
        }
        else if (node->rangeBounds[1] != NA_RANGE)
        {
            node->rangeBounds[0] = node->rangeBounds[1];
            
            if (node->rangeBounds[1] < minAndMax[0])
            {
                minAndMax[0] = node->rangeBounds[1];
            }
            if (node->rangeBounds[1] > minAndMax[1])
            {
                minAndMax[1] = node->rangeBounds[1];
            }
            
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
            
            if (newBoundValue < minAndMax[0])
            {
                minAndMax[0] = newBoundValue;
            }
            if (newBoundValue > minAndMax[1])
            {
                minAndMax[1] = newBoundValue;
            }
            
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

bool offsetRangeBounds (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param)
{
    int offset = *((int*) param);
    
    if (NA_RANGE == node->rangeBounds[1] && NA_RANGE == node->rangeBounds[0])
    {
        return true;
    }
    else
    {
        node->rangeBounds[0] += offset;
        node->rangeBounds[1] += offset;
        return false;
    }
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

void AlViewRelativeLayout::decideRelationGraphs (map<int, RelationGraphNode*>& graphs, int nodeCount, CGSize& parentBound)
{
    for (map<int, RelationGraphNode*>::iterator iter = graphs.begin(); iter != graphs.end(); iter++)
    {
        // Find one node, at least one of which ranges can be confirmed :
        RelationGraphNode* node = iter->second;
        
        int minAndMax[2];
        if (NA_RANGE == node->rangeBounds[0] && NA_RANGE == node->rangeBounds[1])
        {
            node->rangeBounds[0] = 0;
            minAndMax[0] = 0;
            minAndMax[1] = 0;
        }
        else
        {
            minAndMax[0] = INT_MAX;
            minAndMax[1] = INT_MIN;
        }
        recursiveTraverseRelationGraph(node, nodeCount, minAndMax, decideRangeBounds);
        
        int offset = 0;
        if (minAndMax[0] < 0)
        {
            offset = -minAndMax[0];
        }
        else
        {
            switch (node->id & 0x7)
            {
                case VAR_LEFT:
                case VAR_RIGHT:
                case VAR_HCENTER:
                    if (minAndMax[1] >= parentBound.width)
                    {
                        offset = parentBound.width - minAndMax[1];
                    }
                    
                    break;
                case VAR_TOP:
                case VAR_BOTTOM:
                case VAR_VCENTER:
                    if (minAndMax[1] >= parentBound.height)
                    {
                        offset = parentBound.height - minAndMax[1];
                    }
                    break;
            }
        }
        
        if (0 != offset)
        {
            recursiveTraverseRelationGraph(node, nodeCount, &offset, offsetRangeBounds);
        }
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

void AlViewRelativeLayout::updateRelationGraphs (map<int, RelationGraphNode*>& graphs, list<LayoutConstraint>* constraints)
{
    clearRelationGraph(graphs);
    
    int maxVars = 6 * (currentUsableID + 1); /// 2 * constraints->size(); ///
    RelationGraphNode** nodes = new RelationGraphNode*[maxVars];
    for (int i=maxVars-1; i>=0; i--)
    {
        nodes[i] = NULL;
    }
    
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

