//
//  ViewController.m
//  DrawDemo
//
//  Created by xiabob on 2018/4/26.
//  Copyright © 2018年 xiabob. All rights reserved.
//

#import "ViewController.h"
#import "XBCornerDrawView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    XBCornerDrawLayout *layout = [[XBCornerDrawLayout alloc] init];
    layout.position = XBCornerDrawPositionLeft;
    layout.offset = 75;
    layout.height = 10;
    layout.degree = 80;
    XBCornerDrawView *drawView = [[XBCornerDrawView alloc] initWithRadius:8 cornerLayout:layout fillColor:[UIColor redColor]];
    [drawView setDrawInsets:UIEdgeInsetsMake(4, 0, 4, 0)];
    drawView.frame = CGRectMake(40, 100, 100, 300);
    drawView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:drawView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = drawView.bounds;
    [drawView.layer displayIfNeeded];
    maskLayer.contents = drawView.layer.contents;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demo.jpg"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.frame = CGRectMake(200, 100, 100, 300);
    imageView.layer.mask = maskLayer;
    [self.view addSubview:imageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
