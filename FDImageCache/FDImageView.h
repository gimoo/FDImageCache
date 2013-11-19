//
//  FDImageView.h
//  FDImageCache
//
//  Created by 笑虎 on 13-11-19.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "FDImageCache.h"

@interface FDImageView : UIImageView
<ASIHTTPRequestDelegate>
{
    NSString *_tmpUrl;
}

//提供图片赋值接口
-(void)setImageWithUrl:(NSURL *)url defImage:(UIImage *)image;

@end
