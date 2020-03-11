//
//  UICollectionViewWaterfallLayout.h
//  wanzhuangwang
//
//  Created by mac on 2019/4/1.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UICollectionViewWaterfallLayout;

@protocol UICollectionViewWaterfallLayoutDelgate <NSObject>

@required
- (CGFloat)waterfallLayout:(UICollectionViewWaterfallLayout *)layout heigthForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;
@optional

/**
 瀑布流的列数目,默认2列
 
 */
- (CGFloat)columnCountInWaterfallLayout:(UICollectionViewWaterfallLayout *)layout;

/**
 瀑布流列之间的间距，默认15
 */
- (CGFloat)columnMarginInWaterfallLayout:(UICollectionViewWaterfallLayout *)layout;

/**
 行间距，默认10
 */
- (CGFloat)rowMarginInWaterfallLayout:(UICollectionViewWaterfallLayout *)layout;

/**
 内容区域edgeInsets，默认{10, 10, 10, 10}
 */
- (UIEdgeInsets)edgeInsetsInWaterfallLayout:(UICollectionViewWaterfallLayout *)layout;
@end

@interface UICollectionViewWaterfallLayout : UICollectionViewLayout

@property(nonatomic, weak)id<UICollectionViewWaterfallLayoutDelgate> delegate;

@end

NS_ASSUME_NONNULL_END
