//
//  PictureStrategy.m
//  高斯模糊
//
//  Created by 沈 晨豪 on 13-12-27.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "PictureStrategy.h"

@implementation PictureStrategy:NSObject

- (void)setStartBlock:(VoidBlock)start_block
{
    [_start_block release];
    _start_block = [start_block copy];
}

- (void)setEndBlock:(VoidBlock)end_block
{
    [_end_block release];
    _end_block = [end_block copy];
}

- (void)setShowProgressBlock:(ShowProgressBlock)show_progress_block
{
    [_show_progress_block release];
    _show_progress_block = [show_progress_block copy];
}


- (UIImage *)pictureTransform:(UIImage *)image
{
    //重写方法
    
    return nil;
}

#pragma mark -
#pragma mark - dealloc

- (void)dealloc
{
    [super dealloc];
    
    [_start_block         release], _start_block         = nil;
    
    [_end_block           release], _end_block           = nil;
    
    [_show_progress_block release], _show_progress_block = nil;
}
@end
