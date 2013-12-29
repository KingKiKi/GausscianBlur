//
//  GausscianBlurOne.h
//  高斯模糊
//  1纬的高斯模糊的处理
//  Created by 沈 晨豪 on 13-12-27.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PictureStrategy.h"

@interface GausscianBlurOne : PictureStrategy
{
    int _radius;
}

@property (nonatomic,assign) int radius;

@end
