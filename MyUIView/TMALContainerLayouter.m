//
//  TMALContainerLayouter.m
//  WeiBo_iPad
//
//  Created by DomQiu on 13-4-24.
//
//

#import "TMALContainerLayouter.h"

@implementation TMALContainerLayouter

- (id) init;
{
    self = [super init];
    if (nil != self)
    {
        _name2SubLayouterMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) dealloc
{
    [_name2SubLayouterMap removeAllObjects];
}

- (void) addSubLayouter : (TMALLayouter*) subLayouter
               withName : (NSString*) name
        layoutParameter : (TMALLayoutParameter) layoutParameter
{
    //NSValue *value = [NSValue valueWithBytes:&myTestStruct objCType:@encode(MyTestStruct)];
    if (nil != subLayouter.parent && subLayouter.parent != self)
    {
        NSException* ex = [NSException exceptionWithName:@"TMALContainerLayouter"
                                                  reason:@"A layouter which already has a parent was about to added to another parent"
                                                userInfo:nil];
        @throw ex;
    }
    
    subLayouter.parent = self;
    subLayouter.layoutParameter = layoutParameter;
    
    [_name2SubLayouterMap setObject:subLayouter forKey:name];
}


- (TMALLayouter*) subLayouterOfName : (NSString*) name
{
    return [_name2SubLayouterMap objectForKey:name];
}

- (void) layout : (CGSize) givenSize
{
    ///!!!if (_isLayoutInvalid)
    {
        for (TMALLayouter* subLayouter in [_name2SubLayouterMap allValues])
        {
            [subLayouter layout:CGSizeZero];
        }
        [self onLayout:givenSize];
    }
    _isLayoutInvalid = NO;
}


@end
