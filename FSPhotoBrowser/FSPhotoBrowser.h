//
//  FSPhotoBrowser.h
//  FSPhotoBrowser
//
//  Created by StevenLee on 2016/11/14.
//  Copyright © 2016年 TrustDream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSPhotoBrowser : UIViewController

/*! @brief 从指定view跳转到图片浏览器
 */
- (void)presentFromImageView:(UIView *)fromView completion:(void(^)())completion;

@end
