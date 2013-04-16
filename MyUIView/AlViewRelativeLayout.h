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

#define kLayoutRelationCenterParentHorizontal  16
#define kLayoutRelationCenterParentVertical    17

#define VAR_LEFT    0
#define VAR_TOP     1
#define VAR_RIGHT   2
#define VAR_BOTTOM  3

#define RELATION_LESS_EQUAL      0
#define RELATION_GREATER_EQUAL   1
#define RELATION_LESS_EQUAL_N    2
#define RELATION_GREATER_EQUAL_N 3

#define RANGE_LOW_BOUND  0
#define RANGE_HIGH_BOUND 1

#define NA_VAR     -1

#define NA_RANGE   (-32768.0f)

#include <list>
#include <map>
#include "BitMatrix.h"
#include "AlViewContainerLayout.h"

using namespace std;


typedef struct
{
    int leftOperandID;
    int rightOperandID;
    float constant;
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
    
    // 0: this <= that + k;
    // 1: this >= that + k;
    // 2: this <= k - that;
    // 3: this >= k - that;
    list<RelationGraphEdge> edgesFromMe[4];
    float rangeBounds[2];
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
    
    void addLayoutRelation (int leftOperandID, int rightOperandID, int layoutRelation);
    
    void addLayoutRelation (AlViewLayout* leftOperandChild, AlViewLayout* rightOperandChild, int layoutRelation);
    
    void onMeasure (AlViewLayoutParameter givenLayoutParam);
    
protected:
    
    list<LayoutConstraint> interpretedConstraints;
    list<LayoutConstraint> suspendingConstraints;
    
private:
    
    bool needsUpdateRelationGraph;
    
    void interpretLayoutConstraint (LayoutConstraint originalLC);
    
    void interpretLayoutConstraint (list<LayoutConstraint>* reinterpretedConstraints, LayoutConstraint originalLC, CGSize bound);
    
    //void interpretLayoutConstraint (list<LayoutConstraint>* reinterpretedConstraints, LayoutConstraint originalLC, AlViewLayoutParameter layoutParam);
    
    void updateRelationGraphs (map<int, RelationGraphNode*>& graphs, list<LayoutConstraint>* constraints);
    
    map<int, RelationGraphNode*> relationGraphs;
    
    static void clearRelationGraph (map<int, RelationGraphNode*>& graph);
    
    static void recursiveTraverseRelationGraph (RelationGraphNode* startNode, int nodeCount,
                                                void* param, CallbackInTraversingRelationGraph callback);
    
    ///static void recursiveUpdateGraphNodes (RelationGraphNode* node, int direction, BitMatrix* stamps);
    
    static void solveRelationGraphs (map<int, RelationGraphNode*>& graphs, int nodeCount);
    
    static void decideRelationGraphs (map<int, RelationGraphNode*>& graphs, int nodeCount, CGSize& parentBound);
};

#endif /* defined(__MyUIView__AlViewRelativeLayout__) */
