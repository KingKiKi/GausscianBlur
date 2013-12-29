//
//  GausscianBlurOne.m
//  高斯模糊
//
//  Created by 沈 晨豪 on 13-12-27.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "GausscianBlurOne.h"
#import "UIImage+ImageData.h"

@interface GausscianBlurOne(private)


///*1纬高斯模糊*/
//- (void)linear:(double *)weight_value;
//
///*改变某个点*/
//- (void)transformPixel:(unsigned char*)pixel gbimageData:(unsigned char*)image_data weight:(double *)weight_value pixelX:(int)x pixelY:(int)y width:(int)width height:(int)height;
//
///*边界检查  不足就由对面的弥补 */
//- (int)checkEdge:(int)x changeNumber:(int)y referenceValue:(int)z;
//
///*计算模糊点*/
//- (char)clampValue:(double)value;



@end

@implementation GausscianBlurOne

@synthesize radius = _radius;

//#pragma mark - 
//#pragma mark - 私有函数
//
//
//- (void)linear:(double *)weight_value
//{
//    double x   = 2.0f / ((double)((_radius<<1) + 1));
//    double y   = -(x / ((double)_radius));
//    
//    double sum = 0.0f;
//    for (int i = -_radius; i <= _radius; ++i)
//    {
//   
//        
//        weight_value[i + _radius] = y * abs(i) + x;
//        sum += y * abs(i) + x;
//    }
//    
//    if(sum != 1.0f)
//    {
//        for (int i = -_radius; i <= _radius; ++i)
//        {
//            
//            weight_value[i + _radius] = weight_value[i + _radius] / sum;
//       
//        }
//    }
//    
//    
//}
//
//
//- (void)transformPixel:(unsigned char *)pixel gbimageData:(unsigned char *)image_data weight:(double *)weight_value pixelX:(int)x pixelY:(int)y width:(int)width height:(int)height
//{
//    double red   = 0.0f;
//    double green = 0.0f;
//    double blue  = 0.0f;
//
//    
//    /*i 是行 j是列*/
//    for (int i = -_radius;  i < _radius + 1; ++i)
//    {
//        int i_change = [self checkEdge:y changeNumber:i referenceValue:height];
//        
//        for (int j = -_radius; j < _radius + 1; ++j)
//        {
//            int j_change = [self checkEdge:x changeNumber:j referenceValue:width];
//            
//            
//            int r = pixel[4 * i_change * width + 4 * j_change + 0];
//            int g = pixel[4 * i_change * width + 4 * j_change + 1];
//            int b = pixel[4 * i_change * width + 4 * j_change + 2];
//            
//            red   += ((double)r) * weight_value[j + _radius];
//            green += ((double)g) * weight_value[j + _radius];
//            blue  += ((double)b) * weight_value[j + _radius];
//
//        }
//
//        
//    }
//  
//    image_data[4 * y * width + 4 * x + 0] = [self clampValue:red ];
//    image_data[4 * y * width + 4 * x + 1] = [self clampValue:green];
//    image_data[4 * y * width + 4 * x + 2] = [self clampValue:blue];
//    
//
//}
//
//- (int)checkEdge:(int)x changeNumber:(int)y referenceValue:(int)z
//{
//    int number = x + y;
//    
//    
//    if(number < 0)  number = z + number;
//    
//    if(number >= z) number = number - z;
//    
//    
//    return number;
//}
//
//- (char)clampValue:(double)value
//{
//    
//    if(value > 255.0f)
//        return 0xff;
//
//    int temp_char = value;
//    return temp_char;
//    
//}
//
//
//#pragma mark - 
//#pragma mark - public
//
//- (UIImage *)pictureTransform:(UIImage *)image
//{
//    
//    unsigned char *image_data   = [UIImage getImageData:image];
//
//    
//    int            width        = (int)CGImageGetWidth(image.CGImage);
//    int            height       = (int)CGImageGetHeight(image.CGImage);
//    
//    double        *weight_value = malloc((2 * _radius + 1) * 8);
//    
//  //  NSLog(@"%lu",(((_radius<<1) + 1) * sizeof(double)));
//    unsigned char *gbimage_data = malloc(4 * width * height);
//    
//    
//   [self linear:weight_value];
//    
//    /*遍历模糊*/
//    for (int i = 0; i < height; ++i)
//    {
//        
//        
//        for (int j = 0; j < width; ++j)
//        {
//           
//            
//            [self transformPixel:image_data gbimageData:gbimage_data weight:weight_value pixelX:j pixelY:i width:width height:height];
//            
//        }
//    }
////    for (int i = 0; i < height; ++i)
////    {
////        
////        
////        for (int j = 0; j <4 * width; ++j)
////        {
////            
////            gbimage_data[4 * width * i + j] = image_data[4 * width * i + j];
////            
////        }
////    }
//    
//    
//    
//    free(image_data);
//    
//    UIImage *gb_image = [UIImage imageWithChar:gbimage_data width:width height:height];
//    
//    free(gbimage_data);
//    free(weight_value);
//    
//   
//    
//    return gb_image;
//}

@end

















