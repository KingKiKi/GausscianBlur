//
//  PictureStrategy.h
//  高斯模糊
//
//  Created by 沈 晨豪 on 13-12-27.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>


#define _R 0   //R
#define _G 1   //G
#define _B 2   //B
#define _A 3   //A

typedef void (^VoidBlock)(void* data);
typedef void (^ShowProgressBlock)(double value,void* data,id information);

@interface PictureStrategy : NSObject
{
    VoidBlock          _start_block;         //开始
    VoidBlock          _end_block;           //结束
    ShowProgressBlock  _show_progress_block; //进度
}

@property (nonatomic,assign) BOOL is_on_progress;


/*
 返回需要模糊后的图片
 */
- (UIImage*)pictureTransform:(UIImage *)image;

/*
 图片进度
 */
- (void)pictureTransformProgress:(UIImage *)image;


- (void)setStartBlock:(VoidBlock)start_block;
- (void)setEndBlock:(VoidBlock)end_block;
- (void)setShowProgressBlock:(ShowProgressBlock)show_progress_block;


@end
