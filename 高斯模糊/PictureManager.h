//
//  PictureManager.h
//  高斯模糊
//
//  Created by 沈 晨豪 on 13-12-27.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PictureStrategy.h"


@interface PictureManager : NSObject
{
    PictureStrategy   *_picture_strategy;    //图片处理的策略
    

}
@property (nonatomic,retain) PictureStrategy *picture_strategy;


- (UIImage *)pictureTransform:(UIImage *)image;

- (void)pictureTransformProgress:(UIImage *)image;

@end
