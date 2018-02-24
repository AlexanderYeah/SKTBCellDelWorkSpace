//
//  SecondCell.h
//  SKTBCellDeleteDemo
//
//  Created by AY on 2018/2/24.
//  Copyright © 2018年 AY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZanBlock)();
typedef void(^DelBlcok)();
typedef void(^SwipBlock)();
@interface SecondCell : UITableViewCell


/** 标记左滑菜单是否打开 */
@property (nonatomic,assign)BOOL isOpen;

/** Cell的内容 */
@property (nonatomic,strong)UILabel *contentLbl;

/**取消关注的回调*/
@property (nonatomic,copy)ZanBlock zanCb;

/**删除的回调*/
@property (nonatomic,copy)DelBlcok delCb;

/**左右滑动的回调*/
@property (nonatomic,copy)SwipBlock swipCb;


/**
	关闭左滑菜单
*/

- (void)closeMenuWithCompletionHandle:(void (^)(void))completionHandle;


@end
