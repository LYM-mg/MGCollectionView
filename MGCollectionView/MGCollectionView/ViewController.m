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
        CGFloat w = self.view.frame.size.width;
        CGRect rect = CGRectMake(0, 0, w, 200);
        collectionView.frame = rect;
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
    // 删除模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    
   // 删UI(刷新UI)
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
