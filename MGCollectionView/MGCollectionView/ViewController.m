//
//  ViewController.m
//  MGCollectionView
//
//  Created by ming on 16/5/31.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ViewController.h"
#import "MGImgaeCell.h"
#import "MGCircleLayout.h"
#import "MGStackLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *images;
/** UICollectionView */
@property (nonatomic,weak) UICollectionView *collectionView;

@end

@implementation ViewController

static NSString *const ID = @"imageCell";
#pragma mark- lazy
- (NSMutableArray *)images{
    if (!_images) {
        self.images = [[NSMutableArray alloc] init];
        
        for (int i = 1; i<=20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    // 创建CollectionView
    [self setUpCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[MGStackLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[MGCircleLayout alloc] init] animated:YES];
    } else {
        [self.collectionView setCollectionViewLayout:[[MGStackLayout alloc] init] animated:YES];
    }
}

- (void)setUpCollectionView{
    
    // 设置UICollectionView的参数
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[MGCircleLayout alloc] init]];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        // 设置UICollectionView的参数
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        CGFloat h = [UIScreen mainScreen].bounds.size.height;
        CGRect rect = CGRectMake(0, h*0.15, w, 400);
        collectionView.frame = rect;
        collectionView.backgroundColor = [UIColor colorWithHue:23 saturation:0.3 brightness:0.9 alpha:0.9];
        collectionView;
    });
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MGImgaeCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
//    [collectionView registerNib:[UINib nibWithNibName:@"MGImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MGImageCell"];
}

#pragma mark- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGImgaeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.image = self.images[indexPath.item];
    return cell;
}

#pragma mark- UICollectionViewDelegate 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 取得当前cell
    MGImgaeCell *cell = (MGImgaeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:1.0 animations:^{
        CGAffineTransform form1 = CGAffineTransformMakeScale(2.0, 2.0);
        CGAffineTransform form2 = CGAffineTransformMakeRotation(2*M_PI);
        cell.transform = CGAffineTransformConcat(form1, form2);
    }];
   
//    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    base.fromValue = @(1.0);
//    base.toValue = @(2.0);
//    base.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
//    base.duration = 1.0;
//    [cell.layer addAnimation:base forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 删除模型数据
        [self.images removeObjectAtIndex:indexPath.item];
        
        // 删UI(刷新UI)
        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
    });
    
}

@end
