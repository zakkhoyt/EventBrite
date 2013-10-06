//
//  UIColor+VWW.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "UIColor+VWW.h"

@implementation UIColor (VWW)

+(UIColor*)vwwGreenColor{
    return [UIColor colorWithRed:(0x49/(float)0xFF) green:(0xAE/(float)0xFF) blue:(0x85/(float)0xFF) alpha:1.0];
}

+(UIColor*)vwwLightBlueColor{
    return [UIColor colorWithRed:(74/(float)0xFF) green:(201/(float)0xFF) blue:(247/(float)0xFF) alpha:1.0];
}

+(UIColor*)vwwDarkBlueColor{
    return [UIColor colorWithRed:(57/(float)0xFF) green:(169/(float)0xFF) blue:(207/(float)0xFF) alpha:1.0];
}


+(UIColor*)randomColor{
    CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+(UIColor*)colorFromHexString:(NSString*)hexString{
    NSScanner* scanner = [NSScanner scannerWithString:hexString];
    unsigned int hex = 0;
    if ([scanner scanHexInt:&hex]) {
        int r = (hex >> 16) & 0xFF;
        int g = (hex >>  8) & 0xFF;
        int b = (hex      ) & 0xFF;
        return [UIColor colorWithRed:r/(float)0xFF green:g/(float)0xFF blue:b/(float)0xFF alpha:1.0];
    }
    return nil;
}
@end
