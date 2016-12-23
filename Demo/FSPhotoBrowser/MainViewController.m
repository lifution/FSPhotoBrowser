//
//  MainViewController.m
//  FSPhotoBrowser
//
//  Created by StevenLee on 2016/11/11.
//  Copyright © 2016年 TrustDream. All rights reserved.
//

#import "MainViewController.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "FSPhotoBrowser.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self setupSubviews];
    }];
}

- (void)setupSubviews {
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat spacing = 5.f;
    CGFloat imageWH = (viewWidth - spacing*5)/4;
    
    UIScrollView *contentView = [UIScrollView new];
    contentView.frame = self.view.bounds;
    contentView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:contentView];
    
    UIImageView *lastImageView;
    for (int i = 0; i < 50; i ++) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        [contentView addSubview:imageView];
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewGesture:)]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://i2.s1.dpfile.com/pc/08e2a57127b540b93b15ba2f0045d882(740x2048)/thumb.jpg"]];
        
        CGFloat x = spacing, y = spacing;
        if (lastImageView) {
            if (CGRectGetMaxX(lastImageView.frame) == (viewWidth - spacing)) {
                x = spacing;
                y = CGRectGetMaxY(lastImageView.frame) + spacing;
            } else {
                x = CGRectGetMaxX(lastImageView.frame) + spacing;
                y = CGRectGetMinY(lastImageView.frame);
            }
        }
        
        imageView.frame = CGRectMake(x, y, imageWH, imageWH);
        
        lastImageView = imageView;
    }
    
    contentView.contentSize = CGSizeMake(viewWidth, CGRectGetMaxY(lastImageView.frame) + 20);
}

- (void)tapImageViewGesture:(UITapGestureRecognizer *)gesture {
    
    [[FSPhotoBrowser new] presentFromImageView:gesture.view completion:^{
        // present完成回调
    }];
}

@end
