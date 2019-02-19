//
//  WLViewController.m
//  WLButtonGridView
//
//  Created by Nomeqc on 02/19/2019.
//  Copyright (c) 2019 Nomeqc. All rights reserved.
//

#import "WLViewController.h"
#import "WLButtonGridView.h"
#import "YYCategories.h"

@interface WLViewController ()

@end

@implementation WLViewController {
    WLButtonGridView *_gridView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
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
        [items addObject:({
            WLButtonGridItem *item = [[WLButtonGridItem alloc] init];
            item.title = @"用户";
            item.iconUrl = @"https://i.niupic.com/images/2019/02/19/5Ol3.png";
            NSString *title = item.title;
            [item setTapHandler:^{
                NSLog(@"%@",title);
            }];
            item;
        })];
        [items addObject:({
            WLButtonGridItem *item = [[WLButtonGridItem alloc] init];
            item.title = @"话题";
            item.iconUrl = @"https://i.niupic.com/images/2019/02/19/5Ol4.png";
            NSString *title = item.title;
            [item setTapHandler:^{
                NSLog(@"%@",title);
            }];
            item;
        })];
        [items addObject:({
            WLButtonGridItem *item = [[WLButtonGridItem alloc] init];
            item.title = @"私家客";
            item.iconUrl = @"https://i.niupic.com/images/2019/02/19/5Ol6.png";
            NSString *title = item.title;
            [item setTapHandler:^{
                NSLog(@"%@",title);
            }];
            item;
        })];
        [items addObject:({
            WLButtonGridItem *item = [[WLButtonGridItem alloc] init];
            item.title = @"联系微信13456768909";
            item.iconUrl = @"https://i.niupic.com/images/2019/02/19/5Ol1.png";
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

    [self.view addSubview:gridView];
    _gridView = gridView;
}

- (IBAction)didTapAddButton:(UIButton *)sender {
    _gridView.width -= 10;
}


@end
