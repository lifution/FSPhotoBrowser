//
//  FSPhotoBrowser.m
//  FSPhotoBrowser
//
//  Created by StevenLee on 2016/11/14.
//  Copyright © 2016年 TrustDream. All rights reserved.
//

#import "FSPhotoBrowser.h"

@interface FSPhotoBrowser ()

@property (nonatomic, strong) UIWindow *window;

@end

@implementation FSPhotoBrowser

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
}

#pragma mark - Private
// 根据图片size计算图片的显示位置
- (CGRect)fitRectForImage:(UIImage *)image {
    CGRect imageRect = CGRectZero;
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds),
           viewHeight = CGRectGetHeight(self.view.bounds),
           imageWidth = image.size.width,
          imageHeight = image.size.height;
    
    if (imageWidth <= viewWidth && imageHeight <= viewHeight) {
        imageRect.size = image.size;
    }
    
    /*
    if (imageWidth >= viewWidth && imageHeight >= viewHeight) {
        if (imageWidth >= imageHeight) {
            imageHeight = (imageWidth * viewHeight)/viewWidth;
            imageWidth  = viewWidth;
        } else {
            imageWidth  = (imageHeight * viewWidth)/viewHeight;
            imageHeight = viewHeight;
        }
    }
    if (imageWidth >= viewWidth && imageHeight <= viewHeight) {
        if (imageWidth >= imageHeight) {
            imageHeight = (imageWidth * viewHeight)/viewWidth;
            imageWidth  = viewWidth;
        } else {
            imageWidth  = (imageHeight * viewWidth)/viewHeight;
            imageHeight = viewHeight;
        }
    }
     */
    
    if (imageWidth >= imageHeight) {
        imageHeight = imageHeight*(viewWidth/imageWidth);
        imageWidth  = viewWidth;
    } else {
        imageWidth  = imageWidth*(viewHeight/imageHeight);
        imageHeight = viewHeight;
    }
    
    imageRect.size = CGSizeMake(imageWidth, imageHeight);
    imageRect.origin = CGPointMake((viewWidth - imageWidth)/2, (viewHeight - imageHeight)/2);
    
    NSLog(@"%@", NSStringFromCGSize(image.size));
    
    return imageRect;
}

#pragma mark - Public
/*! @brief 从指定view跳转到图片浏览器
 */
- (void)presentFromImageView:(UIView *)fromView completion:(void(^)())completion {
    
    CGRect fromRect = [fromView.superview convertRect:fromView.frame toView:self.view];
    UIImageView *scaleImageView = [[UIImageView alloc] initWithImage:[(UIImageView *)fromView image]];
    scaleImageView.frame = fromRect;
    scaleImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:scaleImageView];
    
    _window = [[UIWindow alloc] init];
    _window.windowLevel = UIWindowLevelStatusBar + 1;
    _window.backgroundColor = [UIColor blackColor];
    _window.rootViewController = self;
    [_window makeKeyAndVisible];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        scaleImageView.frame = [self fitRectForImage:scaleImageView.image];
        
    } completion:^(BOOL finished) {
        completion ? completion() : NULL;
    }];
}

@end
