//
//  UIView+AlViewLayout.m
//  MyUIView
//
//  Created by DomQiu on 13-4-17.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "UIView+AlViewLayout.h"
#import "UIAlLayouter.h"
#import <objc/runtime.h>

static NSString* kClassNamePrefix = @"ALVIEW";
static const char* const kAlViewLayoutKey = "domqiu.AlViewLayout";

@implementation UIView (AlViewLayout)

- (void) setAlLayouter : (UIAlLayouter*) alLayouter
{
    [alLayouter retain];
    id layouter = objc_getAssociatedObject(self, kAlViewLayoutKey);
    if (nil != layouter)
    {
        [layouter release];
    }
    objc_setAssociatedObject(self, kAlViewLayoutKey, alLayouter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [alLayouter release];
}

- (UIAlLayouter*) alLayouter
{
    //*
    Class viewClass = [self class];
    if (![NSStringFromClass(viewClass) hasPrefix:kClassNamePrefix])
    {
        NSString *subclassName = [NSString stringWithFormat:@"%@_%@_", kClassNamePrefix, NSStringFromClass(viewClass)];
        Class subclass = NSClassFromString(subclassName);
        if (subclass == nil)
        {
            subclass = objc_allocateClassPair(viewClass, [subclassName UTF8String], 0);
            Method mtdDealloc = class_getInstanceMethod(viewClass, @selector(dealloc));
            class_addMethod(subclass, @selector(dealloc), (IMP)alview_dealloc, method_getTypeEncoding(mtdDealloc));
            objc_registerClassPair(subclass);
        }
        
        object_setClass(self, subclass);
    }
    //*/
    UIAlLayouter* layouter = (UIAlLayouter*)objc_getAssociatedObject(self, kAlViewLayoutKey);
    if (nil == layouter)
    {
        layouter = [[UIAlLayouter alloc] initWithUIView:self layouter:NULL];
        objc_setAssociatedObject(self, kAlViewLayoutKey, layouter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [layouter release];
    }
    return layouter;
}

static void alview_dealloc(UIView *self, SEL _cmd)
{
	Class superclass = class_getSuperclass([self class]);
	IMP superDealloc = class_getMethodImplementation(superclass, _cmd);
    
    id layouter = objc_getAssociatedObject(self, kAlViewLayoutKey);
    if (nil != layouter)
    {
        [layouter release];
    }
    
    superDealloc(self, _cmd);
}

@end
