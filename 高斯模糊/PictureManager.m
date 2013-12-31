//
//  PictureManager.m
//  高斯模糊
//
//  Created by 沈 晨豪 on 13-12-27.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "PictureManager.h"

@implementation PictureManager

@synthesize picture_strategy = _picture_strategy;





- (UIImage *)pictureTransform:(UIImage *)image
{
   return [_picture_strategy pictureTransform:image];
}

- (void)pictureTransformProgress:(UIImage *)image
{
    [_picture_strategy pictureTransformProgress:image];
}

#pragma mark - 
#pragma mark - dealloc

- (void)dealloc
{
    [super dealloc];
    
    [_picture_strategy    release], _picture_strategy    = nil;
    
}

@end
