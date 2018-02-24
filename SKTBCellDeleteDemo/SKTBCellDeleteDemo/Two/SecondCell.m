//
//  SecondCell.m
//  SKTBCellDeleteDemo
//
//  Created by AY on 2018/2/24.
//  Copyright © 2018年 AY. All rights reserved.
//

#import "SecondCell.h"


@interface SecondCell()

/** 容器 */

@property(nonatomic,strong)UIView *containerView;


@end

@implementation SecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
		
        [self createUI];
    }
    return self;
	
}

-(void)createUI{
	//取消关注按钮
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, 0, 60, 60)];
    cancelBtn.backgroundColor=[UIColor grayColor];
    [cancelBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    cancelBtn.titleLabel.numberOfLines=0;
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];

	
	//删除按钮
    UIButton *deleteBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 0, 60, 60)];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.backgroundColor=[UIColor redColor];
    [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:cancelBtn];
    [self.contentView addSubview:deleteBtn];
	
	
	_containerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    _containerView.backgroundColor=[UIColor greenColor];
    [self.contentView addSubview:_containerView];
	
	
	if (_isOpen) {
		_containerView.center = CGPointMake(SCREEN_WIDTH/2-120, _containerView.center.y);
	}
	
	
	//测试Label
    _contentLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    
    [_containerView addSubview:_contentLbl];
	
	// 给contentview 添加一个左滑的手势
	UISwipeGestureRecognizer *swipLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [_containerView addGestureRecognizer:swipLeft];
	
	
	//添加右滑手势
    UISwipeGestureRecognizer *swipRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipRight.direction=UISwipeGestureRecognizerDirectionRight;
    [_containerView addGestureRecognizer:swipRight];
	
	
}

#pragma mark - 事件的相应
// 取消关注的
- (void)cancelClick
{
	
	self.zanCb();
	
}

// 删除按钮的点击
- (void)deleteClick
{
	self.delCb();
	
}



// 滑动
- (void)swip:(UISwipeGestureRecognizer *)sender
{
	
	// 滑动的回调 从而实现互斥的效果
	
	
	
	// 第一步  通知tableview  关闭自己cell的菜单
	
	if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
	
		NSLog(@"222");
		if (self.swipCb) {
			self.swipCb();
		}
	}
	
	
	
	
	
	// 第二不 在根据当前滑动的方向做对应的操作
	// 左滑的时候
	
	if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
		if (_isOpen) {
			return;
		}
		
		[UIView animateWithDuration:0.3 animations:^{
			sender.view.center = CGPointMake(sender.view.center.x-120, sender.view.center.y);
		}];
		_isOpen = YES;
		
	}
	
	
	// 右滑的时候 进行关闭
	if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
		
		if (!_isOpen) {
			return;
		}
		[UIView animateWithDuration:0.3 animations:^{
			sender.view.center = CGPointMake(SCREEN_WIDTH / 2, sender.view.center.y);
		}];
		_isOpen = NO;
		
	}

	
}



/** 关闭左滑菜单 */
- (void)closeMenuWithCompletionHandle:(void (^)(void))completionHandle
{
	if (!_isOpen) {
		return;
	}
	
	__weak typeof(self) wkSelf = self;
	
	[UIView animateWithDuration:0.3 animations:^{
        wkSelf.containerView.center=CGPointMake(SCREEN_WIDTH/2, wkSelf.containerView.center.y);
    }completion:^(BOOL finished) {
        if(completionHandle)
            completionHandle();
    }];
    _isOpen=NO;

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
