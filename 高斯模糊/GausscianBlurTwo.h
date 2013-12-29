//
//  GausscianBlurTwo.h
//  高斯模糊
//
//  Created by 沈 晨豪 on 13-12-27.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PictureStrategy.h"

@interface GausscianBlurTwo : PictureStrategy
{
    double   _sigma;               //设置 σ的值
    int      _radius;              //半径
    int      _diameter;            //直径
    
    double  *_gaussian_template;   //模糊的模版
    int      _template_size;       //模版的尺寸
}

@property (nonatomic,assign)   double sigma;
@property (nonatomic,readonly) int    radius;
@property (nonatomic,readonly) int    diameter;
@property (nonatomic,readonly) int    template_size;

@end
