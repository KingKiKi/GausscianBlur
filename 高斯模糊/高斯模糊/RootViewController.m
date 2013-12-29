//
//  RootViewController.m
//  高斯模糊
//
//  Created by 沈 晨豪 on 13-12-27.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "RootViewController.h"
#import "PictureManager.h"
#import "GausscianBlurOne.h"
#import "GausscianBlurTwo.h"

@interface RootViewController ()
{
    UIImageView *_old_image_view;      //原始图片
    UIImageView *_filtered_image_view; //被过滤的图片
    
    UIButton    *_filter_button;       //过滤按键
    
    BOOL         _is_filtering;        //是否在过滤图片
    
}


/*布局*/
- (void)myLayer;

/*过滤按键被按下*/
- (void)filterButtonPressed:(id)sender;

@end

@implementation RootViewController

#pragma mark - 
#pragma mark - 私有方法

- (void)myLayer
{
    //图片
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"test" ofType:@"jpg"]];
    
    //原始图片的imageview
    
    [_old_image_view setFrame:CGRectMake(10.0f, 30.0f, 300.0f, 160.0f)];
    [_old_image_view setImage:image];
    
    [self.view addSubview:_old_image_view];

    
    //过滤按钮
    
    [_filter_button setFrame:CGRectMake(230.0f, 200.0f, 60.0, 30.0)];
    [_filter_button setTitle:@"高斯模糊" forState:UIControlStateNormal];
    [_filter_button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_filter_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_filter_button setBackgroundColor:[UIColor blackColor]];
    [_filter_button addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_filter_button];
    
    //过滤后的图片
    
    [_filtered_image_view setFrame:CGRectMake(10.0f, 240.0f, 300.0f, 160.0f)];
    
    [self.view addSubview:_filtered_image_view];
    
    
    
//    PictureManager   *pic_m    = [[[PictureManager alloc] init] autorelease];
//    GausscianBlurTwo *gb2      = [[[GausscianBlurTwo alloc] init] autorelease];
//    [gb2 setSigma:5.80f];
//    [pic_m setPicture_strategy:gb2];
//    
//    UIImage          *gb_image = [pic_m pictureTransform:image];
    

    

}

- (void)filterButtonPressed:(id)sender
{
    if(_is_filtering)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示:"
                                                        message:@"图片正在处理中请稍后..."
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
    _is_filtering = YES;
    
    UIImage          *image    = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"test" ofType:@"jpg"]];
    
    PictureManager   *pic_m    = [[[PictureManager alloc] init] autorelease];
    GausscianBlurTwo *gb2      = [[GausscianBlurTwo alloc] init];
    
    [gb2 setEndBlock:^{
        NSLog(@"结束了");
        _is_filtering = NO;
    }];
    [gb2 setSigma:4.0f];
    [pic_m setPicture_strategy:gb2];
    [gb2 release], gb2 = nil;

    UIImage          *gb_image = [pic_m pictureTransform:image];
    
    [_filtered_image_view setImage:gb_image];

}


#pragma mark - 
#pragma mark - 初始化

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        _old_image_view       = [[UIImageView alloc] init];
        _filtered_image_view  = [[UIImageView alloc] init];
        _filter_button        = [[UIButton alloc] init];
        
        _is_filtering         = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self myLayer];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    
    [_old_image_view      release], _old_image_view       = nil;
    
    [_filtered_image_view release], _filtered_image_view  = nil;
    
    [_filter_button       release], _filter_button        = nil;
}

@end
