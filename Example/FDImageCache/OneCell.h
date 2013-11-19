//
//  OneCell.h
//  FDImageCache
//
//  Created by 笑虎 on 13-11-19.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDImageView.h"

@interface OneCell : UITableViewCell
{
    UILabel *_title;
    FDImageView *_icon;
}

-(void)setDicForValue:(NSDictionary *)dic;

@end
