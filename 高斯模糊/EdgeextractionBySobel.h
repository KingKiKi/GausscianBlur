//
//  EdgeextractionBySobel.h
//  高斯模糊
//  通过sobel算子实现
//  Created by 沈 晨豪 on 14-1-2.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "PictureStrategy.h"




@interface EdgeextractionBySobel : PictureStrategy
{
    BOOL   _is_use_gb;    //是否在处理前使用高斯模糊
    
    BOOL   _is_average;   //是否平均取值
    
    double _scale;        //比例
}
@property (nonatomic,assign) BOOL   is_use_gb;
@property (nonatomic,assign) BOOL   is_average;
@property (nonatomic,assign) double scale;
@end
