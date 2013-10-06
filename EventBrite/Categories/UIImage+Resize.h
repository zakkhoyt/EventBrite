//
//  UIImage+Resize.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Resize)
+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)newSize;
@end
