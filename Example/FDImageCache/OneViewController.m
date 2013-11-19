//
//  OneViewController.m
//  FDImageCache
//
//  Created by 笑虎 on 13-11-19.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import "OneViewController.h"
#import "OneCell.h"

//下面的ASI的引用是为了清理缓存的，实际应用是不需要
#import "clearCache.h"

@interface OneViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataList;
}
@end

@implementation OneViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"继承模式"];
        _dataList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    //载入数据
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Image" ofType:@"plist"];
    _dataList = [NSMutableArray arrayWithContentsOfFile:dataPath];

    [self addNavButton];
    [self addTableView];
}

//绘制一个导航按钮
-(void)addNavButton
{
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"清理缓存" style:UIBarButtonItemStylePlain target:self action:@selector(btnBar:)];
    [self.navigationItem setRightBarButtonItem:bar];
}

//按钮点击事件
-(void)btnBar:(UIBarButtonItem *)btn
{
    [[clearCache sharedClearCache] cleanCache:_dataList];
    [_tableView reloadData];
}

//绘制tableView
-(void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, FD_SCREEN_MAIN_HEIGHT) style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
}

//多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList count];
}

//多高
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300.0f;
}

//每个行的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ident = @"cell";
    OneCell *cell = [_tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[OneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }

    //赋值
    [cell setDicForValue:[_dataList objectAtIndex:indexPath.row]];
    return cell;
}
@end
