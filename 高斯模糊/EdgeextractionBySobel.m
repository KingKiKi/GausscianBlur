//
//  EdgeextractionBySobel.m
//  高斯模糊
//
//  Created by 沈 晨豪 on 14-1-2.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "EdgeextractionBySobel.h"
#import "UIImage+ImageData.h"

/*
      ｜－1 0 ＋1｜        |+1 +2 +1|
 gx = ｜－2 0 ＋2｜   gy = | 0  0  0|
      ｜－1 0 ＋1｜        |-1 -2 -1|
 */

/*横向*/
static int gx[] = { -1,  0,  1,
                    -2,  0,  2,
                    -1,  0,  1 };

/*纵向*/
static int gy[] = {  1,  2,  1,
                     0,  0,  0,
                    -1, -2, -1 };

@interface EdgeextractionBySobel(private)

/*
sobel因子提取
 @prams
 
 is_average :是否使用平均取值
 */
- (void)imageBySobel:(unsigned char *)image_data edgeImage:(unsigned char *)edge_image_data width:(int)width hegiht:(int)hegiht average:(BOOL)is_average scale:(double)scale_value;

@end


@implementation EdgeextractionBySobel

@synthesize is_use_gb  = _is_use_gb;
@synthesize is_average = _is_average;
@synthesize scale      = _scale;

#pragma mark - 
#pragma mark - private

- (void)imageBySobel:(unsigned char *)image_data edgeImage:(unsigned char *)edge_image_data width:(int)width hegiht:(int)hegiht average:(BOOL)is_average scale:(double)scale_value
{
    int red_v;
    int green_v;
    int blue_v;
    
    int red_h;
    int green_h;
    int blue_h;
    
    int n = 0;
    
    for (int y = 1; y < hegiht - 1; ++y)
    {
        for (int x = 1; x < width - 1; ++x)
        {
            //偏移量
            n       = (y * width + x)* 4;

            //横向
            red_v   = abs(gx[0] * image_data[n - width * 4 - 4 + _R] + gx[2] * image_data[n - width * 4 + 4 + _R] +
                          gx[3] * image_data[n - 4 + _R]             + gx[5] * image_data[n + 4 + _R]             +
                          gx[6] * image_data[n + width * 4 - 4 + _R] + gx[8] * image_data[n + width * 4 + 4 + _R]);
            
            green_v = abs(gx[0] * image_data[n - width * 4 - 4 + _G] + gx[2] * image_data[n - width * 4 + 4 + _G] +
                          gx[3] * image_data[n - 4 + _G]             + gx[5] * image_data[n + 4 + _G]             +
                          gx[6] * image_data[n + width * 4 - 4 + _G] + gx[8] * image_data[n + width * 4 + 4 + _G]);
            
            blue_v  = abs(gx[0] * image_data[n - width * 4 - 4 + _B] + gx[2] * image_data[n - width * 4 + 4 + _B] +
                          gx[3] * image_data[n - 4 + _B]             + gx[5] * image_data[n + 4 + _B]             +
                          gx[6] * image_data[n + width * 4 - 4 + _B] + gx[8] * image_data[n + width * 4 + 4 + _B]);
            
            //纵向
            red_h   = abs(gy[0] * image_data[n - width * 4 - 4 + _R] + gy[1] * image_data[n + _R]                 +
                          gy[2] * image_data[n - width * 4 + 4 + _R] + gy[6] * image_data[n + width * 4 - 4 + _R] +
                          gy[7] * image_data[n + width * 4 + _R]     + gy[8] * image_data[n + width * 4 + 4 + _R]);
            
            green_h = abs(gy[0] * image_data[n - width * 4 - 4 + _G] + gy[1] * image_data[n + _G]                 +
                          gy[2] * image_data[n - width * 4 + 4 + _G] + gy[6] * image_data[n + width * 4 - 4 + _G] +
                          gy[7] * image_data[n + width * 4 + _G]     + gy[8] * image_data[n + width * 4 + 4 + _G]);
            
            blue_h  = abs(gy[0] * image_data[n - width * 4 - 4 + _B] + gy[1] * image_data[n + _B]                 +
                          gy[2] * image_data[n - width * 4 + 4 + _B] + gy[6] * image_data[n + width * 4 - 4 + _B] +
                          gy[7] * image_data[n + width * 4 + _B]     + gy[8] * image_data[n + width * 4 + 4 + _B]);
            
            
            
            //灰度差
            
            int  v_average  = red_v + green_v + blue_v;
            int  h_average  = red_h + green_h + blue_h;
            int  gray_value = 0;
            
            if(_is_average)
            {
                gray_value = (v_average + h_average) / 2;
            }
            else
            {
                gray_value = v_average > h_average?v_average:h_average;
            }
            
            gray_value = gray_value * scale_value;
            
            gray_value = gray_value > 0xff?0xff:gray_value;
            
            //设置灰度图片
            
            edge_image_data[n + _R] = gray_value;
            edge_image_data[n + _G] = gray_value;
            edge_image_data[n + _B] = gray_value;
            edge_image_data[n + _A] = 0xff;
            
        }
        
    }
    
    
}


#pragma mark -
#pragma mark - public

#pragma mark -
#pragma mark - init

- (id)init
{
    self = [super init];
    
    if(self)
    {
        _is_use_gb  = NO;
        _is_average = YES;
        _scale      = 0.3;
        
    }
    
    return self;
}

- (UIImage *)pictureTransform:(UIImage *)image
{
    
    unsigned char *image_data      = [UIImage getImageData:image];
    
    int            width           = (int)CGImageGetWidth(image.CGImage);
    int            height          = (int)CGImageGetHeight(image.CGImage);
    
    unsigned char *edge_image_data = (unsigned char*)malloc(4 * width * height);
    
    
    [self imageBySobel:image_data edgeImage:edge_image_data width:width hegiht:height average:_is_average scale:_scale];
    
    
    UIImage       *edge_image      = [UIImage imageWithChar:edge_image_data width:width height:height];
    
    free(image_data);
    free(edge_image_data);
    
    return edge_image;
}

- (void)pictureTransformProgress:(UIImage *)image
{
    
#ifdef DEBUG
    NSLog(@"还未实现");
#endif
    
}

#pragma mark -
#pragma mark - dealloc

- (void)dealloc
{
    
    [super dealloc];
}

@end
