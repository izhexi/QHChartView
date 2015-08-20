//
//  ViewController.m
//  QHChartView
//
//  Created by imqiuhang on 15/8/20.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "WelcomViewController.h"
#import "LineChartViewController.h"
#import "PieChartViewController.h"
@interface WelcomViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WelcomViewController
{
    UITableView *dataTableView;
    NSArray *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"hi,imqiuhang";
    [self initModel];
    [self initView];
}

#pragma mark - tableViewDelegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = data[indexPath.row][@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.navigationController pushViewController:(UIViewController *)[NSClassFromString(data[indexPath.row][@"vc"]) new] animated:YES];
}

#pragma mark - init
- (void)initModel {
  data = @[
            @{
              @"title" : @"lineChart",
              @"vc" : @"LineChartViewController"
            },
            @{
              @"title" : @"pieChart",
              @"vc" : @"PieChartViewController"
            },

  ];
}

- (void)initView {
    dataTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    dataTableView.delegate   = self;
    dataTableView.dataSource = self;
    [self.view addSubview:dataTableView];
}

@end
