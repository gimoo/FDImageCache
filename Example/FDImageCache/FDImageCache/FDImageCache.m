//
//  FDImageCache.m
//  FDImageCache
//
//  Created by 笑虎 on 13-11-19.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import "FDImageCache.h"
#import <CommonCrypto/CommonHMAC.h>

//静态变量存储单例
static FDImageCache *sharedImageCache;

@implementation FDImageCache
//静态初始化
+(FDImageCache *)sharedImageCache
{
    if (!sharedImageCache) {
        @synchronized(self){
            if (!sharedImageCache) {
                sharedImageCache = [[FDImageCache alloc] init];
            }
        }
    }
    return sharedImageCache;
}

//获取图像
-(UIImage *)getCache:(NSURL *)url
{
    NSString *fmd5 = [self cachePathForKey:[url absoluteString]];
    return [self objectForKey:fmd5];
}

//保存到缓存
-(void)setCache:(NSURL *)url image:(UIImage *)image
{
    NSString *fmd5 = [self cachePathForKey:[url absoluteString]];
    [self setObject:image forKey:fmd5 cost:image.size.height * image.size.width * image.scale];
}

//生成MD5的key
-(NSString *)cachePathForKey:(NSString *)key
{
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
}
@end
