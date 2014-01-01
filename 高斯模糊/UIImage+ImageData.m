//
//  UIImage+ImageData.m
//  高斯模糊
//
//  Created by 沈 晨豪 on 13-12-28.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "UIImage+ImageData.h"


#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

#define kCGImageAlphaPremultipliedLast  (kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast)

#else

#define kCGImageAlphaPremultipliedLast  kCGImageAlphaPremultipliedLast

#endif




@implementation UIImage (ImageData)

+ (unsigned char *)getImageData:(UIImage *)image
{
    CGImageRef      image_ref    = [image CGImage];
    
   
    CGColorSpaceRef cololr_space = CGColorSpaceCreateDeviceRGB();
    
    
    
    int              width       = (int)CGImageGetWidth(image_ref);
    int              height      = (int)CGImageGetHeight(image_ref);
    
    unsigned char   *image_data  = (unsigned char *)malloc(width * height * 4);//设为4个字节
    

#ifdef DEBUG
    if(image_data == NULL)
    {
        NSLog(@"失败");
        exit(0);
    }
#endif
    
    CGContextRef    context_ref  = CGBitmapContextCreate(image_data,
                                                         width,
                                                         height,
                                                         8,
                                                         4 * width,
                                                         cololr_space,
                                                         kCGImageAlphaPremultipliedLast);
    
    //画入image_data
    CGContextDrawImage(context_ref,
                       CGRectMake(0.0f, 0.0f, width, height),
                       image_ref);
    
    
    
    CGColorSpaceRelease(cololr_space);
    CGContextRelease(context_ref);
    
    return image_data;
}

+ (UIImage *)imageWithChar:(unsigned char*)image_data width:(int)width height:(int)height
{
    
   

    CGColorSpaceRef cololr_space = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef    context_ref  = CGBitmapContextCreate(image_data,
                                                         width,
                                                         height,
                                                         8,
                                                         4 * width,
                                                         cololr_space,
                                                         kCGImageAlphaPremultipliedLast);
    
    CGImageRef     image_ref     = CGBitmapContextCreateImage(context_ref);
    
    UIImage       *image         = [UIImage imageWithCGImage:image_ref];
    
    
    CGColorSpaceRelease(cololr_space);
    CGContextRelease(context_ref);
    
   
    
    return image;
}


+ (CGImageRef)imageRefWithChar:(unsigned char *)image_data width:(int)width height:(int)height
{
    
    
    CGColorSpaceRef cololr_space = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef    context_ref  = CGBitmapContextCreate(image_data,
                                                         width,
                                                         height,
                                                         8,
                                                         4 * width,
                                                         cololr_space,
                                                         kCGImageAlphaPremultipliedLast);
    
    CGImageRef     image_ref     = CGBitmapContextCreateImage(context_ref);
    
   // UIImage       *image         = [UIImage imageWithCGImage:image_ref];
    
    
    CGColorSpaceRelease(cololr_space);
    CGContextRelease(context_ref);
    
    
    
    return image_ref;
}

@end
