//
//  NSObject_KVContainer.h
//  MyUIView
//
//  Created by DomQiu on 13-4-23.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVContainer)

- (id) valueOfKVPair : (id) key;

- (void) setKVPair : (id) value
               key : (id) key;

@end
