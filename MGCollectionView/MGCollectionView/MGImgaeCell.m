//
//  MGImgaeCell.m
//  MGCollectionView
//
//  Created by ming on 16/5/31.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGImgaeCell.h"

@interface MGImgaeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MGImgaeCell

- (void)awakeFromNib {
    self.imageView.layer.borderWidth = 3;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = self.frame.size.width * 0.04;
    self.imageView.clipsToBounds = YES;
}

- (void)setImage:(NSString *)image
{
    _image = [image copy];
    
    self.imageView.image = [UIImage imageNamed:image];
}
@end
