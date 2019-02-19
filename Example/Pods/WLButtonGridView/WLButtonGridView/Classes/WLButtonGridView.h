//
//  XDBMeCommonGridView.h
//  XDBGridCategoryDemo
//
//  Created by iOSDeveloper003 on 16/9/27.
//  Copyright © 2016年 iOSDeveloper003. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *
 * @code
 
 WLButtonGridView *gridView = ({
 NSMutableArray *items = [NSMutableArray array];
 [items addObject:({
 WLButtonGridItem *item = [[WLButtonGridItem alloc] init];
 item.title = @"综合";
 item.iconUrl = @"https://i.niupic.com/images/2019/02/19/5Ol2.png";
 NSString *title = item.title;
 [item setTapHandler:^{
 NSLog(@"%@",title);
 }];
 item;
 })];
 [items addObject:({
 WLButtonGridItem *item = [[WLButtonGridItem alloc] init];
 item.title = @"近一周";
 item.iconUrl = @"https://i.niupic.com/images/2019/02/19/5Ol5.png";
 NSString *title = item.title;
 [item setTapHandler:^{
 NSLog(@"%@",title);
 }];
 item;
 })];
 
 WLButtonGridConfig *config = [[WLButtonGridConfig alloc] init];
 
 WLButtonGridView *view = [[WLButtonGridView alloc] initWithItemItems:items config:config];
 view.size = [view preferredSizeForWidth:self.view.width];
 view.left = 0;
 view.top = 64;
 view;
 });
 gridView.separatorLineColor = [UIColor redColor];
 [self.view addSubview:gridView];
 
 * @endcode
 */

@interface WLButtonGridItem : NSObject

@property (copy, nonatomic) NSString *title;

@property (nonatomic, copy) NSString *iconUrl;
@property (strong, nonatomic) UIImage *iconImage;

@property (copy, nonatomic) dispatch_block_t tapHandler;

@end

@interface WLButtonGridConfig : NSObject

/**
 *  图标大小 默认32x32
 */
@property (nonatomic) CGSize iconSize;

/**
 *  标题字体 默认 12号
 */
@property (nonatomic) UIFont *titleFont;

/**
 *  图标距离顶部的距离 默认16
 */
@property (nonatomic) CGFloat contentInsetTop;

/**
 *  label距离底部的距离 当做单行来处理
 */
@property (nonatomic) CGFloat contentInsetBottom;

/**
 *  标题和图标之间的距离 默认 5
 */
@property (nonatomic) CGFloat titleIconInterspacing;

/**
 *  每行显示列数 默认4列
 */
@property (nonatomic) NSInteger numberOfColumn;

@end

@interface WLButtonGridView : UIView

- (instancetype)initWithItemItems:(NSArray<WLButtonGridItem *> *)models config:(WLButtonGridConfig *)config;

///限定宽度，计算自身合适的大小
- (CGSize)preferredSizeForWidth:(CGFloat)width;

/// 分割线颜色
@property (nonatomic) UIColor *separatorLineColor;

@end
