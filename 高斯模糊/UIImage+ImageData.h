//
//  UIImage+ImageData.h
//  高斯模糊
//
//  Created by 沈 晨豪 on 13-12-28.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageData)

+ (unsigned char *)getImageData:(UIImage *)image;

+ (UIImage *)imageWithChar:(unsigned char *)image_data width:(int)width height:(int)height;

@end
