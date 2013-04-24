//
//  TMALContainerLayouter.h
//  WeiBo_iPad
//
//  Created by DomQiu on 13-4-24.
//
//

#import "TMALLayouter.h"
#import "TMALLayoutParameter.h"


@interface TMALContainerLayouter : TMALLayouter
{
    NSMutableDictionary* _name2SubLayouterMap;
}

- (id) init;

- (void) addSubLayouter : (TMALLayouter*) subLayouter
               withName : (NSString*) name
        layoutParameter : (TMALLayoutParameter) layoutParameter;


- (TMALLayouter*) subLayouterOfName : (NSString*) name;

@end
