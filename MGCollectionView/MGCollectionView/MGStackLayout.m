//
//  MGStackLayout.m
//  MGCollectionView
//
//  Created by ming on 16/5/31.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGStackLayout.h"

@implementation MGStackLayout

/**
 *  每次边界发生变化的时候就会调用该方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

/**
 *   对每一个cell的布局对象做处理
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *angles = @[@0, @(-0.2), @(-0.5), @(0.2), @(0.5)];
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(100, 100);
    attrs.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    
    if (indexPath.item >= 5){
        attrs.hidden = YES;
    }else{
        attrs.hidden = NO;
        attrs.transform = CGAffineTransformMakeRotation([angles[indexPath.item] floatValue]);
         attrs.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item;
    }
    
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
