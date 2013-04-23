
#import <objc/runtime.h>
#import "NSObject_KVContainer.h"

@implementation NSObject (KVContainer)

- (id) valueOfKVPair : (NSString*) key
{
    return objc_getAssociatedObject(self, (__bridge void*)key);
}

- (void) setKVPair : (id) value
               key : (NSString*) key
{
    objc_setAssociatedObject(self, (__bridge void*)key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end