//
//  ViewController.m
//  WaterfallLayout
//
//  Created by mac on 2020/3/11.
//  Copyright © 2020 com.devhuang. All rights reserved.
//

#import "ViewController.h"
#import "UICollectionViewWaterfallLayout.h"

#define kScreenW        ([[UIScreen mainScreen] bounds].size.width)
#define kScreenH        ([[UIScreen mainScreen] bounds].size.height)
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewWaterfallLayoutDelgate>

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc]init];
    
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, kScreenW - 20, kScreenH) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.alwaysBounceVertical = YES;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = randomColor;
    return cell;
}

- (CGFloat)waterfallLayout:(UICollectionViewWaterfallLayout *)layout heigthForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    return 100 + arc4random_uniform(100);
}



@end
