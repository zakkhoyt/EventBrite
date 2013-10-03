//
//  UIColor+VWW.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "UIColor+VWW.h"

@implementation UIColor (VWW)

// 49AE85
+(UIColor*)vwwGreenColor{
    return [UIColor colorWithRed:(0x49/(float)0xFF) green:(0xAE/(float)0xFF) blue:(0x85/(float)0xFF) alpha:1.0];
}


+(UIColor*)randomColor{
    CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
@end
