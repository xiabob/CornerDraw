//
//  DrawViwq.m
//  DrawDemo
//
//  Created by xiabob on 2018/4/26.
//  Copyright © 2018年 xiabob. All rights reserved.
//

#import "XBCornerDrawView.h"

@implementation XBCornerDrawLayout
@end

@interface XBCornerDrawView()

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) XBCornerDrawLayout *cornerLayout;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) UIEdgeInsets drawInsets;

@end

@implementation XBCornerDrawView

- (instancetype)initWithRadius:(CGFloat)radius cornerLayout:(XBCornerDrawLayout *)layout fillColor:(UIColor *)fillColor {
    if (self = [super init]) {
        self.radius = radius;
        self.cornerLayout = layout;
        self.fillColor = fillColor ?: [UIColor whiteColor];
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat radius = self.radius;
    CGFloat left = self.drawInsets.left + (XBCornerDrawPositionLeft == self.cornerLayout.position ? self.cornerLayout.height : 0);
    CGFloat top = self.drawInsets.top + (XBCornerDrawPositionTop == self.cornerLayout.position ? self.cornerLayout.height : 0);
    CGFloat right = self.drawInsets.right + (XBCornerDrawPositionRight == self.cornerLayout.position ? self.cornerLayout.height : 0);
    CGFloat bottom = self.drawInsets.bottom + (XBCornerDrawPositionBottom == self.cornerLayout.position ? self.cornerLayout.height : 0);
    
    CGPoint topLeft = CGPointMake(left, top + radius);
    [path addArcWithCenter:CGPointMake(topLeft.x+ radius, topLeft.y) radius:radius startAngle:M_PI endAngle:M_PI + M_PI_2 clockwise:YES];
    
    CGPoint topRight = CGPointMake(rect.size.width - radius - right, top);
    [path addLineToPoint:topRight];
    [path addArcWithCenter:CGPointMake(topRight.x, topRight.y + radius) radius:radius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    
    CGPoint bottomRight = CGPointMake(rect.size.width - right, rect.size.height - bottom - radius);
    [path addLineToPoint:bottomRight];
    [path addArcWithCenter:CGPointMake(bottomRight.x-radius, bottomRight.y) radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    CGPoint bottomLeft = CGPointMake(left + radius, rect.size.height - bottom);
    [path addLineToPoint:bottomLeft];
    [path addArcWithCenter:CGPointMake(topLeft.x+ radius, bottomRight.y) radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:topLeft];
    
    //draw corner
    switch (self.cornerLayout.position) {
        case XBCornerDrawPositionTop:
            [self drawCorner:rect atTopPosition:path padding:top];
            break;
            
        case XBCornerDrawPositionRight:
            [self drawCorner:rect atRightPosition:path padding:right];
            break;
            
        case XBCornerDrawPositionBottom:
            [self drawCorner:rect atBottomPosition:path padding:bottom];
            break;
            
        case XBCornerDrawPositionLeft:
            [self drawCorner:rect atLeftPosition:path padding:left];
            break;
    }

    [self.fillColor set];
    [path fill];

}

- (void)drawCorner:(CGRect)rect atTopPosition:(UIBezierPath *)path padding:(CGFloat)padding {
    CGFloat top = padding;
    CGFloat cornerHeight = self.cornerLayout.height;
    CGFloat cornerSpace = self.cornerLayout.offset;
    CGFloat cornerHalfWidth = cornerHeight * tan((self.cornerLayout.degree / 180.0 * M_PI) / 2.0);
    CGPoint cornerLeftPoint = CGPointMake(cornerSpace - cornerHalfWidth, top);
    CGPoint cornerCenterPoint = CGPointMake(cornerSpace, self.drawInsets.top);
    CGPoint cornerRightPoint = CGPointMake(cornerSpace + cornerHalfWidth, top);
    [path moveToPoint:cornerLeftPoint];
    [path addLineToPoint:cornerCenterPoint];
    [path addLineToPoint:cornerRightPoint];
}

- (void)drawCorner:(CGRect)rect atRightPosition:(UIBezierPath *)path padding:(CGFloat)padding {
    CGFloat right = padding;
    CGFloat cornerHeight = self.cornerLayout.height;
    CGFloat cornerSpace = self.cornerLayout.offset;
    CGFloat cornerHalfWidth = cornerHeight * tan((self.cornerLayout.degree / 180.0 * M_PI) / 2.0);
    CGPoint cornerTopPoint = CGPointMake(rect.size.width - right, cornerSpace - cornerHalfWidth);
    CGPoint cornerCenterPoint = CGPointMake(rect.size.width - self.drawInsets.right, cornerSpace);
    CGPoint cornerBottomPoint = CGPointMake(rect.size.width - right, cornerSpace + cornerHalfWidth);
    [path moveToPoint:cornerTopPoint];
    [path addLineToPoint:cornerCenterPoint];
    [path addLineToPoint:cornerBottomPoint];
}

- (void)drawCorner:(CGRect)rect atBottomPosition:(UIBezierPath *)path padding:(CGFloat)padding {
    CGFloat bottom = padding;
    CGFloat cornerHeight = self.cornerLayout.height;
    CGFloat cornerSpace = self.cornerLayout.offset;
    CGFloat cornerHalfWidth = cornerHeight * tan((self.cornerLayout.degree / 180.0 * M_PI) / 2.0);
    CGPoint cornerLeftPoint = CGPointMake(cornerSpace - cornerHalfWidth, rect.size.height - bottom);
    CGPoint cornerCenterPoint = CGPointMake(cornerSpace, rect.size.height - self.drawInsets.bottom);
    CGPoint cornerRightPoint = CGPointMake(cornerSpace + cornerHalfWidth, rect.size.height - bottom);
    [path moveToPoint:cornerLeftPoint];
    [path addLineToPoint:cornerCenterPoint];
    [path addLineToPoint:cornerRightPoint];
}

- (void)drawCorner:(CGRect)rect atLeftPosition:(UIBezierPath *)path padding:(CGFloat)padding {
    CGFloat left = padding;
    CGFloat cornerHeight = self.cornerLayout.height;
    CGFloat cornerSpace = self.cornerLayout.offset;
    CGFloat cornerHalfWidth = cornerHeight * tan((self.cornerLayout.degree / 180.0 * M_PI) / 2.0);
    CGPoint cornerTopPoint = CGPointMake(left ,cornerSpace - cornerHalfWidth);
    CGPoint cornerCenterPoint = CGPointMake(self.drawInsets.left, cornerSpace);
    CGPoint cornerBottomPoint = CGPointMake(left ,cornerSpace + cornerHalfWidth);
    [path moveToPoint:cornerTopPoint];
    [path addLineToPoint:cornerCenterPoint];
    [path addLineToPoint:cornerBottomPoint];
}

@end
