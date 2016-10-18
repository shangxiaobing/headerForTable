//
//  ViewController.m
//  tableHeader
//
//  Created by YXZT on 16/10/11.
//  Copyright © 2016年 YXZT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIView *_headerView;
    UIImageView *imagee;
}
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 200)];
    UIImage *image = [UIImage imageNamed:@"callDetailBack"];
    imagee = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, [[UIScreen mainScreen] bounds].size.width, 200)];
    imagee.image = image;
    [_headerView addSubview:imagee];
    self.tableView.tableHeaderView = _headerView;
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 50, 30, 20)];
    label.backgroundColor = [UIColor redColor];
    [_headerView addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"cell";
    return cell;
}



//scrollView的方法视图滑动时 实时调用
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat width = self.view.frame.size.width;
//    // 图片宽度
//    CGFloat yOffset = scrollView.contentOffset.y;
//    // 偏移的y值
//    if(yOffset < 0)
//    {CGFloat totalOffset = 200 + ABS(yOffset);
//        CGFloat f = totalOffset / 200;
//        //拉伸后的图片的frame应该是同比例缩放。
//        self.tableView.tableHeaderView.frame =  CGRectMake(- (width *f-width) / 2, yOffset, width * f, totalOffset);
//    }
//}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset = self.tableView.contentOffset.y;
    //向上偏移量变正  向下偏移量变负
    if (yOffset < 0) {
        CGFloat factor = ABS(yOffset)+200;
        CGRect f = CGRectMake(-([[UIScreen mainScreen] bounds].size.width*factor/200-[[UIScreen mainScreen] bounds].size.width)/2,-ABS(yOffset), [[UIScreen mainScreen] bounds].size.width*factor/200, factor);
        imagee.frame = f;
    }else {
        CGRect f = _headerView.frame;
        f.origin.y = 0;
        _headerView.frame = f;
        imagee.frame = CGRectMake(0, f.origin.y, [[UIScreen mainScreen] bounds].size.width, 200);
    }
}






@end
