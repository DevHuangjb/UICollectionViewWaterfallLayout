//
//  UICollectionViewWaterfallLayout.m
//  wanzhuangwang
//
//  Created by mac on 2019/4/1.
//  Copyright © 2020 apple. All rights reserved.
//

#import "UICollectionViewWaterfallLayout.h"

static const NSInteger      DefaultColumnCount = 2;
static const CGFloat        DefaultColumnMargin = 15;
static const CGFloat        DefaultRowMargin = 10;
static const UIEdgeInsets   DefaultEdgeInsets = {10, 10, 10, 10};

@interface UICollectionViewWaterfallLayout()

//类高度数组
@property (nonatomic, strong) NSMutableArray *columnHeights;
@property (nonatomic, strong) NSMutableArray *layoutAttributes;
@property(nonatomic,assign) CGFloat rowMargin;
@property(nonatomic,assign) CGFloat columnMargin;
@property(nonatomic,assign) NSInteger columnCount;
@property(nonatomic,assign) UIEdgeInsets edgeInsets;

@end

@implementation UICollectionViewWaterfallLayout

- (void)prepareLayout{
    [super prepareLayout];
    
    [self.columnHeights removeAllObjects];
    
    for (int i = 0; i<self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    [self.layoutAttributes removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //初始化每一个item的布局属性
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.layoutAttributes addObject:attributes];
    }
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectiViewWidth = self.collectionView.frame.size.width;
    
    CGFloat width = (collectiViewWidth - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1)* self.columnMargin) / self.columnCount;
    CGFloat height = [self.delegate waterfallLayout:self heigthForItemAtIndex:indexPath.item itemWidth:width];
    //查找最短的一列
    NSInteger column = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        //第i列高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (columnHeight < minColumnHeight) {
            minColumnHeight = columnHeight;
            column = i;
        }
    }
    CGFloat x = self.edgeInsets.left + column*(width + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attributes.frame = CGRectMake(x, y, width, height);
    
    //更新最短那列的高度
    self.columnHeights[column] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}


- (CGSize)collectionViewContentSize {
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, maxColumnHeight + self.edgeInsets.bottom);
}

#pragma mark - setter & getter
- (NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        _columnHeights = @[].mutableCopy;
    }
    return _columnHeights;
}
- (NSMutableArray *)layoutAttributes{
    if (!_layoutAttributes) {
        _layoutAttributes = @[].mutableCopy;
    }
    return _layoutAttributes;
}

- (CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterfallLayout:)]) {
        return [self.delegate rowMarginInWaterfallLayout:self];
    }
    return DefaultRowMargin;
}

- (CGFloat)columnMargin{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterfallLayout:)]) {
        return [self.delegate columnMarginInWaterfallLayout:self];
    }
    return DefaultColumnMargin;
}

- (NSInteger)columnCount{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterfallLayout:)]) {
        return [self.delegate columnCountInWaterfallLayout:self];
    } else {
        return DefaultColumnCount;
    }
}
- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterfallLayout:)]) {
        return [self.delegate edgeInsetsInWaterfallLayout:self];
    } else {
        return DefaultEdgeInsets;
    }
}

@end
