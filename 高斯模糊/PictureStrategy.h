//
//  PictureStrategy.h
//  高斯模糊
//
//  Created by 沈 晨豪 on 13-12-27.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VoidBlock)(void* data);
typedef void (^ShowProgressBlock)(double value,void* data,id information);

@interface PictureStrategy : NSObject
{
    VoidBlock          _start_block;         //开始
    VoidBlock          _end_block;           //结束
    ShowProgressBlock  _show_progress_block; //进度
}

@property (nonatomic,assign) BOOL is_on_progress;


/*图片变化的2个方法*/
- (UIImage*)pictureTransform:(UIImage *)image;

- (void)pictureTransformProgress:(UIImage *)image;


- (void)setStartBlock:(VoidBlock)start_block;
- (void)setEndBlock:(VoidBlock)end_block;
- (void)setShowProgressBlock:(ShowProgressBlock)show_progress_block;


@end
