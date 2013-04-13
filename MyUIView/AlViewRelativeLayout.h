//
//  AlViewRelativeLayout.h
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#ifndef __MyUIView__AlViewRelativeLayout__
#define __MyUIView__AlViewRelativeLayout__

#define kLayoutRelationAlignTopWith          1
#define kLayoutRelationAlignBottomWith       2
#define kLayoutRelationAlignLeftWith         3
#define kLayoutRelationAlignRightWith        4
#define kLayoutRelationAbove                 5
#define kLayoutRelationBelow                 6
#define kLayoutRelationToLeftOf              7
#define kLayoutRelationToRightOf             8

#define kLayoutRelationCenterHorizontalWith  9
#define kLayoutRelationCenterVerticalWith   10

#define kLayoutRelationAlignParentTop       11
#define kLayoutRelationAlignParentBottom    12
#define kLayoutRelationAlignParentLeft      13
#define kLayoutRelationAlignParentRight     14

#define kLayoutRelationSetSelfBound         15

#define kLayoutRelationCenterParentHorizontal  0x01
#define kLayoutRelationCenterParentVertical    0x02

#define VAR_LEFT    0
#define VAR_TOP     1
#define VAR_RIGHT   2
#define VAR_BOTTOM  3
#define VAR_HCENTER 4
#define VAR_VCENTER 5

#define RANGE_LOW_BOUND  0
#define RANGE_HIGH_BOUND 1

#define NA_VAR     -1

#define NA_RANGE   INT_MIN

#include <list>
#include <map>
#include "BitMatrix.h"
#include "AlViewContainerLayout.h"

using namespace std;


typedef struct
{
    int leftOperandID;
    int rightOperandID;
    int constant;
    int relation;
} LayoutConstraint;


class RelationGraphNode;
typedef struct RelationGraphEdgeStruct
{
    RelationGraphNode* nextNode;
    int weight;
} RelationGraphEdge;


class RelationGraphNode
{
    friend class AlViewRelativeLayout;
    
public:
    
    inline RelationGraphNode (int nodeId)
    {
        id = nodeId;
        rangeBounds[0] = NA_RANGE;
        rangeBounds[1] = NA_RANGE;
    }
    
    // 0: this <= that;  1: this >= that
    list<RelationGraphEdge> edgesFromMe[2];
    int rangeBounds[2];
    int id;
};

// true : Skip
typedef bool (*CallbackInTraversingRelationGraph) (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param);


class AlViewRelativeLayout : public AlViewContainerLayout
{
public:
    
    inline virtual ~AlViewRelativeLayout (void)
    {
        clearRelationGraph(relationGraphs);
    }
    
    void setLayoutRelation (int leftOperandID, int rightOperandID, int layoutRelation);
    
    void onMeasure (AlViewLayoutParameter givenLayoutParam);
    
protected:
    
    list<LayoutConstraint> interpretedConstraints;
    list<LayoutConstraint> suspendingConstraints;
    
private:
    
    void interpretLayoutConstraint (LayoutConstraint originalLC);
    
    void interpretLayoutConstraint (list<LayoutConstraint>* reinterpretedConstraints, LayoutConstraint originalLC, CGSize bound);
    
    //void interpretLayoutConstraint (list<LayoutConstraint>* reinterpretedConstraints, LayoutConstraint originalLC, AlViewLayoutParameter layoutParam);
    
    
    
    map<int, RelationGraphNode*> relationGraphs;
    
    static void clearRelationGraph (map<int, RelationGraphNode*>& graph);
    
    static void createRelationGraphs (map<int, RelationGraphNode*>& graphs, list<LayoutConstraint>* constraints);
    
    static void recursiveTraverseRelationGraph (RelationGraphNode* startNode, int nodeCount,
                                                void* param, CallbackInTraversingRelationGraph callback);
    
    ///static void recursiveUpdateGraphNodes (RelationGraphNode* node, int direction, BitMatrix* stamps);
    
    static void solveRelationGraphs (map<int, RelationGraphNode*>& graphs, int nodeCount);
    
    static void decideRelationGraphs (map<int, RelationGraphNode*>& graphs, int nodeCount);
};

#endif /* defined(__MyUIView__AlViewRelativeLayout__) */
