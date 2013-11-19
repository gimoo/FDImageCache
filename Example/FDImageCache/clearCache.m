//
//  clearCache.m
//  FDImageCache
//  用于测试用的对象-清理缓存
//
//  Created by 笑虎 on 13-11-19.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import "clearCache.h"
#import "FDImageCache.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import <CommonCrypto/CommonHMAC.h>

static clearCache *sharedClearCache;

@implementation clearCache
//静态初始化
+(clearCache *)sharedClearCache
{
    if (!sharedClearCache) {
        @synchronized(self){
            if (!sharedClearCache) {
                sharedClearCache = [[clearCache alloc] init];
            }
        }
    }
    return sharedClearCache;
}

//初始化
-(id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

//清理缓存
-(void)cleanCache:(NSArray *)ary
{
    NSLog(@"path:%@",[[NSBundle mainBundle] resourcePath]);

    //开始清理
    for (int i=0; i<[ary count]; i++) {
        NSString *url = [[ary objectAtIndex:i] objectForKey:@"url"];
        NSLog(@"url:%@",url);
        [[FDImageCache sharedImageCache] removeObjectForKey:[self cachePathForKey:url]];
        [[ASIDownloadCache sharedCache] removeCachedDataForURL:[NSURL URLWithString:url]];
    }
    NSLog(@"clean Cache[%d].",[ary count]);
}

//生成MD5的key
- (NSString *)cachePathForKey:(NSString *)key
{
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
}

@end
