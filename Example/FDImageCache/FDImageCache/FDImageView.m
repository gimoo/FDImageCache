//
//  FDImageView.m
//  FDImageCache
//  图片缓存类-继承基类的方式
//
//  Created by 笑虎 on 13-11-19.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import "FDImageView.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation FDImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tmpUrl = NULL;
    }
    return self;
}

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
        //        [self setCurrUrl:[url absoluteString]];
        [self getNetImage:url];
    }
}

//从网络下载图片
-(void)getNetImage:(NSURL *)url
{
    //本地存储当前url样本
    _tmpUrl = [url absoluteString];

    //实例化ASI对象
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
        [self setCache:request.url image:_image];

        //检测是否为当前的URL
        if (![[request.url absoluteString] isEqualToString:_tmpUrl]) {
            return;
        }

        [self setImage:_image];
    }
}

#pragma mark cache
//获取图像
-(UIImage *)getCache:(NSURL *)url
{
    NSString *fmd5 = [self cachePathForKey:[url absoluteString]];
    return [[FDImageCache sharedImageCache] objectForKey:fmd5];
}

//保存到缓存
-(void)setCache:(NSURL *)url image:(UIImage *)image
{
    NSString *fmd5 = [self cachePathForKey:[url absoluteString]];
    [[FDImageCache sharedImageCache] setObject:image forKey:fmd5 cost:image.size.height * image.size.width * image.scale];
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
