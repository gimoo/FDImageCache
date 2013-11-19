//
//  TwoViewController.m
//  FDImageCache
//
//  Created by 笑虎 on 13-11-19.
//  Copyright (c) 2013年 笑虎. All rights reserved.
//

#import "TwoViewController.h"
#import "TwoCell.h"
#import "clearCache.h"

@interface TwoViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataList;
}
@end

@implementation TwoViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"扩展模式"];
        _dataList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Image" ofType:@"plist"];
    _dataList = [NSMutableArray arrayWithContentsOfFile:dataPath];
    NSLog(@"%@",[[NSBundle mainBundle] resourcePath]);

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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ident = @"cell";
    TwoCell *cell = [_tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[TwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    [cell setDicForValue:[_dataList objectAtIndex:indexPath.row]];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
