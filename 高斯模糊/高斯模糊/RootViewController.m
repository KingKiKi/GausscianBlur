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
#import "UIImage+ImageData.h"
#import "EdgeextractionBySobel.h"

@interface RootViewController ()
{
    UIImageView *_old_image_view;      //原始图片
    UIImageView *_filtered_image_view; //被过滤的图片
    
    UIButton    *_filter_button;       //过滤按键
    
    UILabel     *_progress_label;      //进度label
    
    BOOL         _is_filtering;        //是否在过滤图片
 
}


/*布局*/
- (void)myLayer;

/*过滤按键被按下*/
- (void)filterButtonPressed:(id)sender;

/*过滤图片*/
- (void)filterImage;

@end

@implementation RootViewController

#pragma mark - 
#pragma mark - 私有方法

- (void)myLayer
{
    //图片
   // UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"test" ofType:@"jpg"]];
    UIImage *image = [UIImage imageNamed:@"test.jpg"];
    //原始图片的imageview
    
    [_old_image_view setFrame:CGRectMake(10.0f, 30.0f, 300.0f, 160.0f)];
    [_old_image_view setImage:image];
    
    [self.view addSubview:_old_image_view];

    
    //过滤按钮
    
    [_filter_button setFrame:CGRectMake(230.0f, 200.0f, 60.0, 30.0)];
    [_filter_button setTitle:@"过滤" forState:UIControlStateNormal];
    [_filter_button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_filter_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_filter_button setBackgroundColor:[UIColor blackColor]];
    [_filter_button addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_filter_button];
    
    //过滤后的图片
    
    [_filtered_image_view setFrame:CGRectMake(10.0f, 240.0f, 300.0f, 160.0f)];
    
    [self.view addSubview:_filtered_image_view];
    
    //进度label
    
    [_progress_label setFrame:CGRectMake(240.0f, 410.0f, 80.0f, 30.0f)];
    [_progress_label setFont:[UIFont systemFontOfSize:12.0f]];
    
    [self.view addSubview:_progress_label];
    
    
    
//    PictureManager   *pic_m    = [[[PictureManager alloc] init] autorelease];
//    GausscianBlurTwo *gb2      = [[[GausscianBlurTwo alloc] init] autorelease];
//    [gb2 setSigma:5.80f];
//    [pic_m setPicture_strategy:gb2];
//    
//    UIImage          *gb_image = [pic_m pictureTransform:image];
    

    

}


- (void)filterImage
{
    
    UIImage *image = [UIImage imageNamed:@"test.jpg"];
    
    PictureManager   *pic_m    = [[[PictureManager alloc] init] autorelease];
    GausscianBlurTwo *gb2      = [[GausscianBlurTwo alloc] init];
    //
    //
    //    //开始模糊
    [gb2 setStartBlock:^(void *data) {
        
    }];
    
    
    
    //进行中
    [gb2 setShowProgressBlock:^(double value, void *data, id information) {
        
        
        
        
        CGSize size;
        [(NSValue *)information getValue:&size];
        
        
        //        UIImage *temp_image = [UIImage imageWithChar:data width:size.width height:size.height];
        //
        //        [temp_image_view setImage:temp_image];
        
        CGImageRef temp_image_ref = [UIImage imageRefWithChar:data width:size.width height:size.height];
        
        //[temp_image_view setImage:[UIImage imageWithCGImage:temp_image_ref]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            _progress_label.text = [NSString stringWithFormat:@"%.2f %%",(value * 100)];
            [_filtered_image_view setImage:[UIImage imageWithCGImage:temp_image_ref]];
        });
        
        //
        
    }];
    
    //结束
    [gb2 setEndBlock:^(void *data) {
        // // [_filtered_image_view setImage:(UIImage *)data];
        //[_filtered_image_view setImage:[UIImage imageWithCGImage:data]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [_filtered_image_view setImage:[UIImage imageWithCGImage:data]];
            _is_filtering = NO;
            
        });
        
    }];
    
    
    [gb2 setSigma:4.0f];
    pic_m.picture_strategy = gb2;
    [gb2 release], gb2 = nil;
    
    // something
    [pic_m pictureTransformProgress:image];

    
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
        
        return;
    }
    
    _is_filtering = YES;
    

    //高斯模糊
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        [self filterImage];
//        
//        
//    });
    
    //边缘提取
    UIImage *image = [UIImage imageNamed:@"test.jpg"];
    PictureManager        *pic_m    = [[[PictureManager alloc] init] autorelease];
    EdgeextractionBySobel *eb       = [[[EdgeextractionBySobel alloc] init] autorelease];
    [pic_m setPicture_strategy:eb];
    UIImage *image2 = [pic_m pictureTransform:image];
    
    [_filtered_image_view setImage:image2];
    
    _is_filtering = NO;
    
 
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
        _progress_label       = [[UILabel alloc] init];
        
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
    [_old_image_view      release], _old_image_view       = nil;
    
    [_filtered_image_view release], _filtered_image_view  = nil;
    
    [_filter_button       release], _filter_button        = nil;
    
    [_progress_label      release], _progress_label       = nil;
    
    [super dealloc];
    

}

@end
