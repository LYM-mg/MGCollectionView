//
//  MGCircleLayout.m
//  MGCollectionView
//
//  Created by ming on 16/5/31.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGCircleLayout.h"

@implementation MGCircleLayout

// 布局每次变化的时候就会调用该方法
- (void)prepareLayout{
    [super prepareLayout];
    // 设置行宽
    self.minimumLineSpacing = 100;
    self.minimumInteritemSpacing = 10;
    // 设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置每一个item的大小
    self.itemSize = CGSizeMake(100, 100);
    // 设置额外滚动区域
    self.collectionView.contentInset = UIEdgeInsetsMake(0, self.collectionView.frame.size.width * 0.5-50, 0, 160);
}

/**
 *  每次边界发生变化的时候就会调用该方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

/**
 *  用来设置collectionView停止滚动的那一刻
 *  @param proposedContentOffset collectionView停止滚动那一刻的位置
 *  @param velocity    滚动速度
 */
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
//
//}

/**
 *   对每一个cell的布局对象做处理
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
     attrs.size = CGSizeMake(50, 50);
    
    // 圆的半径
    CGFloat circleRadius = 70;
    CGPoint circleCenter = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    
    // 每个item之间的角度
    NSInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
    CGFloat angleDelta = M_PI * 2 / count;
    
    // 计算当前item的角度
    CGFloat angle = indexPath.item * angleDelta;
    attrs.center = CGPointMake(circleCenter.x
                               + circleRadius * cosf(angle), circleCenter.y - circleRadius * sinf(angle));
    attrs.zIndex = indexPath.item;
    
    return attrs;
}

/**
 *   返回所有的cell的布局对象
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attrs];
    }
    return array;
}

@end
