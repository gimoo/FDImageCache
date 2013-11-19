//
//  UIImageView+FDCache.h
//  FDImageCache
//
//  Created by 笑虎 on 13-11-11.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "FDImageCache.h"

@interface UIImageView (FDCache)
<ASIHTTPRequestDelegate>

-(void)setImageWithUrl:(NSURL *)url defImage:(UIImage *)image;

@end
