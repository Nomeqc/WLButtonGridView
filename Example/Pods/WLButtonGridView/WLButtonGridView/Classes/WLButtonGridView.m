//
//  XDBMeCommonGridView.m
//  XDBGridCategoryDemo
//
//  Created by iOSDeveloper003 on 16/9/27.
//  Copyright © 2016年 iOSDeveloper003. All rights reserved.
//

#import "WLButtonGridView.h"
#import "YYCategories.h"
#import "UIImageView+WebCache.h"

/********** WLButtonGridItem **********/
@implementation WLButtonGridItem
@end

/********** WLButtonGridCell **********/
@interface WLButtonGridCell : UICollectionViewCell

@property (nonatomic) UIImageView *iconImageView;

@property (nonatomic) UILabel *titleLabel;

@property (nonatomic) WLButtonGridConfig *config;

@end

@interface WLButtonGridCell ()

@end


@implementation WLButtonGridCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    UIImageView *iconImageView =  ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView;
    });
    UILabel *titleLabel =  ({
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.text = @"";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor darkTextColor];
        label;
    });
    [self.contentView addSubview:iconImageView];
    [self.contentView addSubview:titleLabel];
    _iconImageView = iconImageView;
    _titleLabel = titleLabel;
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    {
        _iconImageView.size = _config.iconSize;
        _iconImageView.top = _config.contentInsetTop;
        _iconImageView.centerX = self.width / 2;
    }
    {
        CGFloat horizontalMargin = 5;
        _titleLabel.width = self.width - horizontalMargin * 2;
        _titleLabel.height = MIN(ceilf([_titleLabel.text heightForFont:_titleLabel.font width:self.width - horizontalMargin - horizontalMargin * 2]), _titleLabel.font.lineHeight * 2);
        _titleLabel.top = _iconImageView.bottom + _config.titleIconInterspacing;
        _titleLabel.centerX = self.width / 2;
    }
}


@end

/********** WLButtonGridConfig **********/
@implementation WLButtonGridConfig

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _iconSize = CGSizeMake(32, 32);
    _titleFont = [UIFont systemFontOfSize:12];
    _contentInsetTop = 16;
    _contentInsetBottom = 16;
    _titleIconInterspacing = 5;
    _numberOfColumn = 4;
    
    return self;
}

@end


@interface WLButtonGridView ()
<UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray<WLButtonGridItem *> *items;

@property (nonatomic) NSInteger rowCount;

@property (nonatomic) WLButtonGridConfig *config;

@property (nonatomic) NSMutableArray<UIView *> *horizontalLines;

@property (nonatomic) NSMutableArray<UIView *> *verticalLines;

@end

static NSString *const kGridCellId = @"gridCell";

@implementation WLButtonGridView {
    CGFloat _cellHeight;
}

- (instancetype)initWithItemItems:(NSArray *)items
                           config:(WLButtonGridConfig *)config{
    _config = config;
    _items = [items copy];
    [self calculateCellHeight];
    self = [self initWithFrame:CGRectZero];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    UICollectionView *collectionView = ({
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:({
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            flowLayout.minimumLineSpacing = 0;
            flowLayout.minimumInteritemSpacing = 0;
            flowLayout;
        })];
        view.backgroundColor = [UIColor whiteColor];
        [view registerClass:[WLButtonGridCell class] forCellWithReuseIdentifier:kGridCellId];
        view.delegate = self;
        view.dataSource = self;
        view;
    });
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    UIColor *lineColor = UIColorHex(e8e8e8);
    self.horizontalLines = [NSMutableArray array];
    self.verticalLines = [NSMutableArray array];
    
    NSInteger numberOfRow = (_items.count + (_config.numberOfColumn - 1)) / _config.numberOfColumn;
    //横线
    for (NSInteger i = 0; i < numberOfRow; i ++) {
        UIView *horizontalLine = [[UIView alloc] init];
        horizontalLine.backgroundColor = lineColor;
        [collectionView addSubview:horizontalLine];
        [self.horizontalLines addObject:horizontalLine];
    }
    //竖线
    for (NSInteger i = 0; i < _config.numberOfColumn + 1; i++) {
        UIView *verticalLine = [[UIView alloc] init];
        verticalLine.backgroundColor = lineColor;
        [collectionView addSubview:verticalLine];
        [self.verticalLines addObject:verticalLine];
    }
    
    return self;
}

- (CGSize)preferredSizeForWidth:(CGFloat)width {
    if (_config.numberOfColumn == 0) {
        return CGSizeMake(width, _cellHeight);
    }
    NSInteger numberOfRow = (_items.count + (_config.numberOfColumn - 1)) / _config.numberOfColumn;
    return CGSizeMake(width, ceilf(numberOfRow * _cellHeight));
}

- (void)setSeparatorLineColor:(UIColor *)separatorLineColor {
    _separatorLineColor = separatorLineColor;
    [_horizontalLines enumerateObjectsUsingBlock:^(UIView * _Nonnull line, NSUInteger idx, BOOL * _Nonnull stop) {
        line.backgroundColor = separatorLineColor;
    }];
    [_verticalLines enumerateObjectsUsingBlock:^(UIView * _Nonnull line, NSUInteger idx, BOOL * _Nonnull stop) {
        line.backgroundColor = separatorLineColor;
    }];
}

// MARK: @Override

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height);
    
    [self.horizontalLines enumerateObjectsUsingBlock:^(UIView *line, NSUInteger idx, BOOL * _Nonnull stop) {
        line.frame = CGRectMake(0, idx * _cellHeight, CGRectGetWidth(self.collectionView.frame), 1/[UIScreen mainScreen].scale);
        [self.collectionView bringSubviewToFront:line];
    }];
    
    [self.verticalLines enumerateObjectsUsingBlock:^(UIView *line, NSUInteger idx, BOOL * _Nonnull stop) {
        line.frame = CGRectMake(idx *([UIScreen mainScreen].bounds.size.width/_config.numberOfColumn), 0, 1/[UIScreen mainScreen].scale, CGRectGetHeight(self.collectionView.frame));
        [self.collectionView bringSubviewToFront:line];
    }];
}


#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WLButtonGridItem *model = _items[indexPath.row];
    if (model.tapHandler) {
        model.tapHandler();
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _items.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WLButtonGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGridCellId forIndexPath:indexPath];
    cell.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
 
    WLButtonGridItem *model = _items[indexPath.row];
    if (model.iconUrl.length > 0) {
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    } else {
        cell.iconImageView.image = model.iconImage;
    }
    
    cell.titleLabel.text = model.title;
    cell.titleLabel.font = _config.titleFont;
    cell.config = self.config;

    return cell;
}

// MARK: UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame)/_config.numberOfColumn, _cellHeight);
}

// MARK: Helper
- (void)calculateCellHeight {
    CGFloat height = 0;
    height += _config.contentInsetTop;
    height += _config.iconSize.height;
    height += _config.titleIconInterspacing;
    height += _config.titleFont.lineHeight;
    height += _config.contentInsetBottom;
    _cellHeight = height;
}

@end
