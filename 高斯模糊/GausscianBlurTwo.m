//
//  GausscianBlurTwo.m
//  高斯模糊
//
//  Created by 沈 晨豪 on 13-12-27.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "GausscianBlurTwo.h"
#import "UIImage+ImageData.h"



#define _a 0   //R
#define _b 1   //G
#define _c 2   //B
#define _d 3   //A

@interface GausscianBlurTwo (private)

/*计算权重*/
- (double)pointWithWeight:(int)x pointY:(int)y;

/*初始化 模糊模版*/
- (void)initGaussianTemplate:(int)r;

/*改变某个点*/
- (void)transformPixel:(unsigned char*)pixel gbimageData:(unsigned char*)image_data weight:(double *)weight_value pixelX:(int)x pixelY:(int)y width:(int)width height:(int)height;

/*边界检查  不足就由对面的弥补 */
- (int)checkEdge:(int)x changeNumber:(int)y referenceValue:(int)z;

/*计算模糊点*/
- (unsigned char)clampValue:(double)value;

@end

@implementation GausscianBlurTwo

@synthesize sigma         = _sigma;
@synthesize radius        = _radius;
@synthesize diameter      = _diameter;
@synthesize template_size = _template_size;


#pragma mark - 
#pragma mark - private

//            1
//G(x,y) = ------- * e^（-(x^2 + y^2)/2σ^2）  公式
//          2πσ^2

- (double)pointWithWeight:(int)x pointY:(int)y
{
    //            1
    //G(x,y) = -------
    //          2πσ^2
    double a = 1.0f / (2 * M_PI * _sigma * _sigma);
    
    //e^（-(x^2 + y^2)/2σ^2
    double b = exp(-((x * x) + (y * y))/ (2 * _sigma * _sigma));
    
    return a * b;
}

- (void)initGaussianTemplate:(int)r
{
    if(nil != _gaussian_template)
        return;
    
    _template_size     = _diameter * _diameter;
    _gaussian_template = (double *)malloc(_template_size * 8);
    
    if(_gaussian_template == NULL)
    {
        NSLog(@"失败");
        exit(0);
    }
    
    double sum = 0.0f;
   
    for (int y = -_radius,i = 0; y <= _radius ; ++y)
    {
        for (int x = -_radius; x <=_radius;  ++x, ++i)
        {
            _gaussian_template[i] = [self pointWithWeight:x pointY:y];
            
            sum                  += _gaussian_template[i];
            

        }
    }
    
    
    if(sum < 1.0f)
    {
        
        for (int y = -_radius,i = 0; y <= _radius ; ++y)
        {
            for (int x = -_radius; x <= _radius;  ++x, ++i)
            {
                _gaussian_template[i] = _gaussian_template[i] / sum;
                
            }
        }
    }
    
    
}




- (void)transformPixel:(unsigned char *)pixel gbimageData:(unsigned char *)image_data weight:(double *)weight_value pixelX:(int)x pixelY:(int)y width:(int)width height:(int)height
{
    double red   = 0.0f;
    double green = 0.0f;
    double blue  = 0.0f;
    
    
    /*i 是行 j是列*/
    for (int i = -_radius , n = 0;  i <=_radius; ++i)
    {
        int i_change = [self checkEdge:y changeNumber:i referenceValue:height];
        
        for (int j = -_radius; j <= _radius; ++j,++n)
        {
            int j_change = [self checkEdge:x changeNumber:j referenceValue:width];
            
            
            //rgb
            double r = (unsigned char)pixel[4 * i_change * width + 4 * j_change + _a];
            double g = (unsigned char)pixel[4 * i_change * width + 4 * j_change + _b];
            double b = (unsigned char)pixel[4 * i_change * width + 4 * j_change + _c];
          //  NSLog(@"%d %d",i_change,j_change);
          //  NSLog(@"%f %f %f %f",r,g,b,(double)pixel[4 * i_change * width + 4 * j_change + 3]);
           // NSLog(@"%d %d  %d %d", (4 * i_change * width + 4 * j_change + 0) , (4 * i_change * width + 4 * j_change + 1) , (4 * i_change * width + 4 * j_change + 2),(4 * i_change * width + 4 * j_change + 3));
            
//            if((4 * i_change * width + 4 * j_change + 3) >= width * height * 4)
//                NSLog(@"%d",4 * i_change * width + 4 * j_change + 3)
            
        
            red   += r * weight_value[n];
            green += g * weight_value[n];
            blue  += b * weight_value[n];
            

        }
        
    }
   
    image_data[4 * y * width + 4 * x + _a] = [self clampValue:red];
    image_data[4 * y * width + 4 * x + _b] = [self clampValue:green];
    image_data[4 * y * width + 4 * x + _c] = [self clampValue:blue];
    image_data[4 * y * width + 4 * x + _d] = 0xff;
    
}

- (int)checkEdge:(int)x changeNumber:(int)y referenceValue:(int)z
{
    int number = x + y;
    
    
    if(number < 0)  number = z + number;
    
    if(number >= z) number = number - z;
    
    
    return number;
}

- (unsigned char)clampValue:(double)value
{
    
    if(value >= 255.0f)
        return 0xff;

    unsigned char temp_char = (unsigned char)value;

    return temp_char;
    
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
        _gaussian_template = nil;
        
    }
    
    return self;
}
- (void)setSigma:(double)sigma
{
    if(_sigma != sigma)
    {
        
        _sigma = sigma;
        
        if(nil != _gaussian_template)
        {
            free(_gaussian_template);
            _gaussian_template = nil;
        }

        _radius   = (int)(3 * _sigma + 0.5f);
        _diameter = 2 * _radius + 1;
        
   
    }
}

- (UIImage *)pictureTransform:(UIImage *)image
{
     //   return nil;
    
    [self initGaussianTemplate:_radius];
    
  
    
    unsigned char *image_data   = [UIImage getImageData:image];
    

    
    int            width        = (int)CGImageGetWidth(image.CGImage);
    int            height       = (int)CGImageGetHeight(image.CGImage);
    
    unsigned char *gbimage_data = (unsigned char*)malloc(4 * width * height);

    if(NULL == gbimage_data)
    {
        NSLog(@"失败");
        exit(0);
    }
    
    /*遍历模糊*/
    for (int y = 0; y < height; ++y)
    {
        
        for (int x = 0; x < width; ++x)
        {
            [self transformPixel:image_data gbimageData:gbimage_data weight:_gaussian_template pixelX:x pixelY:y width:width height:height];
            
        }
    }

    
    free(image_data);
    
    UIImage *gb_image = [UIImage imageWithChar:gbimage_data width:width height:height];
    
    free(gbimage_data);
    
    return gb_image;
}

- (void)pictureTransformProgress:(UIImage *)image
{
    [self initGaussianTemplate:_radius];
    
    
    unsigned char *image_data   = [UIImage getImageData:image];
    
    
    
    int            width           = (int)CGImageGetWidth(image.CGImage);
    int            height          = (int)CGImageGetHeight(image.CGImage);
    
    unsigned char *gbimage_data    = (unsigned char*)malloc(4 * width * height);
    
    
    if(NULL == gbimage_data)
    {
        NSLog(@"失败");
        exit(0);
    }
    
    /*进度值*/
    double         progress_value  = 0.0f;
    double         period_of_value = 1.0f / (double)height;
    
    /*属性值*/
    CGSize         size            = CGSizeMake(width, height);
    NSValue       *size_value      = [NSValue valueWithCGSize:size];
    
    
    
    //开始
    if(_start_block)
    {
        _start_block(gbimage_data);
    }
    
    /*遍历模糊*/
    for (int y = 0; y < height; ++y)
    {
        
        for (int x = 0; x < width; ++x)
        {
            [self transformPixel:image_data gbimageData:gbimage_data weight:_gaussian_template pixelX:x pixelY:y width:width height:height];
            
        }
        
        
        //模糊的进度
        if(_show_progress_block)
        {
            
            progress_value += period_of_value;
            _show_progress_block(progress_value,gbimage_data,size_value);
        }
    }
    
    
    free(image_data);
    
    CGImageRef gb_image_ref = [UIImage imageRefWithChar:gbimage_data width:width height:height];
    
    if(_end_block)
    {
        _end_block(gb_image_ref);
    }
    
    free(gbimage_data);
    
    
}


#pragma mark - 
#pragma mark - dealloc

- (void)dealloc
{
    
    
    if(nil != _gaussian_template)
    {
       
        free(_gaussian_template);
    }
    [super dealloc];
}

@end
