//
//  FDImageCache.h
//  FDImageCache
//
//  Created by 笑虎 on 13-11-19.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDImageCache : NSCache
//静态初始化
+(FDImageCache *)sharedImageCache;

//获取图像
-(UIImage *)getCache:(NSURL *)url;

//保存到缓存
-(void)setCache:(NSURL *)url image:(UIImage *)image;

//生成MD5的key
-(NSString *)cachePathForKey:(NSString *)key;
@end
