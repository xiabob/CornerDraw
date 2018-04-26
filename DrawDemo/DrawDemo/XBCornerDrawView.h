//
//  DrawViwq.h
//  DrawDemo
//
//  Created by xiabob on 2018/4/26.
//  Copyright © 2018年 xiabob. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XBCornerDrawPositionTop = 0,
    XBCornerDrawPositionRight,
    XBCornerDrawPositionBottom,
    XBCornerDrawPositionLeft
} XBCornerDrawPosition;

@interface XBCornerDrawLayout: NSObject

@property (nonatomic, assign) XBCornerDrawPosition position;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat degree;

@end

@interface XBCornerDrawView : UIView

- (instancetype)initWithRadius:(CGFloat)radius cornerLayout:(XBCornerDrawLayout *)layout fillColor:(UIColor *)fillColor;

- (void)setDrawInsets:(UIEdgeInsets)insets;

@end
