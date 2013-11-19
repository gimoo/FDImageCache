//
//  UIImageView+FDCache.m
//  FDImageCache
//
//  Created by 笑虎 on 13-11-11.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import "UIImageView+FDCache.h"

@implementation UIImageView (FDCache)
#pragma mark loadImage
//通过URL载入远程图片
-(void)setImageWithUrl:(NSURL *)url defImage:(UIImage *)image
{
    //如果有默认图片则先展现默认图
    if (image) {
        [self setImage:image];
    }

    [self checkImageCache:url];
}

//检测是否存在缓存，否则网络获取
-(void)checkImageCache:(NSURL *)url
{
    //先检测高速缓存
    UIImage *image = [[FDImageCache sharedImageCache] getCache:url];
    if (image) {
        [self setImage:image];
        return;
    }

    //磁盘查找
    NSData *data = [[ASIDownloadCache sharedCache] cachedResponseDataForURL:url];
    if (data) {
        [self setImage:[UIImage imageWithData:data]];
    }else{
        [self getNetImage:url];
    }
}

//从网络下载图片
-(void)getNetImage:(NSURL *)url
{
//    XDLOG(@"cacheImg:%@",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    //--------------------代理设置开始--------------------------------------
    NSDictionary *cfgDic = [self getConfig];
    NSString *host = [cfgDic objectForKey:@"apiUrl"];
    if (![[cfgDic objectForKey:@"apiHost"] isEqualToString:@""] && [host rangeOfString:[url host]].location != NSNotFound) {
        [request setProxyHost:[cfgDic objectForKey:@"apiHost"]];
        
        //代理port
        [request setProxyPort:[[cfgDic objectForKey:@"apiPort"] intValue]];
    }
    //--------------------代理设置结束---------------------------------------

    [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setDelegate:self];
    [request startAsynchronous];
}

//读取系统配置文件
-(NSDictionary *)getConfig
{
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dataPath];
    return dic;
}
#pragma mark ASIHTTPRequestDelegate
//下载完成时
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.responseStatusCode == 200) {
        NSData * _data = [request responseData];
        UIImage * _image = [UIImage imageWithData: _data];

        //保存至高速缓存
        [[FDImageCache sharedImageCache] setCache:request.url image:_image];

        [self setImage:_image];
    }
}
@end
