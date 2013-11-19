//
//  TwoCell.m
//  FDImageCache
//
//  Created by 笑虎 on 13-11-19.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import "TwoCell.h"
#import "UIImageView+FDCache.h"

@implementation TwoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        [_title setText:@"标题"];
        [_title setTextColor:[UIColor grayColor]];
        [_title setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:_title];

        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(50, 40, 200, 250)];
        [self.contentView addSubview:_icon];
    }
    return self;
}

-(void)setDicForValue:(NSDictionary *)dic
{
    NSURL *url = [NSURL URLWithString:[dic objectForKey:@"url"]];
    [_title setText:[dic objectForKey:@"url"]];
    [_icon setImageWithUrl:url defImage:[UIImage imageNamed:@"defpic"]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
