//
//  clearCache.h
//  FDImageCache
//
//  Created by 笑虎 on 13-11-19.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface clearCache : NSObject

+(clearCache *)sharedClearCache;
-(void)cleanCache:(NSArray *)ary;

@end
