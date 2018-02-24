//
//  TwoViewController.m
//  SKTBCellDeleteDemo
//
//  Created by AY on 2018/2/24.
//  Copyright © 2018年 AY. All rights reserved.
//

#import "TwoViewController.h"
#import "SecondCell.h"
@interface TwoViewController ()<UITableViewDataSource,UITableViewDelegate>


/** 背景 tableview */
@property (nonatomic,strong)UITableView *mainTableView;
/** 默认的数据源 */
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation TwoViewController


- (NSMutableArray *)dataArray
{
	if (!_dataArray) {
		_dataArray = [NSMutableArray arrayWithObjects:@"上海",@"北京",@"深圳",@"杭州",@"三亚", nil];
		
	}
	return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self createMainTB];
    
	
}

- (void)createMainTB
{


    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.bounces = NO;
    self.mainTableView.separatorStyle = UITableViewCellSelectionStyleGray;
    self.mainTableView.showsVerticalScrollIndicator = NO;
	// self.mainTableView.backgroundColor = kMainColor;
    [self.view addSubview:self.mainTableView];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    SecondCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[SecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.contentLbl.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
	
	// 按钮点击的回调
	cell.zanCb = ^{
		NSLog(@"赞");
	};
	
	// 删除的回调
	cell.delCb = ^{
		[self.dataArray removeObjectAtIndex:indexPath.row];
		[self.mainTableView reloadData];
	};
	
	
	// 一旦有cell 左滑手势的时候 视图上所有的cell 都进行关闭操作
	cell.swipCb = ^{
		for (SecondCell *cell in tableView.visibleCells) {
			[cell closeMenuWithCompletionHandle:nil];
		}
	};
	
	return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
