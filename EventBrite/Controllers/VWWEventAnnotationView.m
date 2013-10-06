//
//  VWWEventAnnotationView.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventAnnotationView.h"
#import "VWWEventAnnotation.h"
#import "UIImageView+WebCache.h"
#import "VWWEvent.h"
#import "VWWEventAnnotation.h"

@implementation VWWEventAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        VWWEventAnnotation *eventAnnotation = (VWWEventAnnotation*)self.annotation;
//        VWWEvent *event = eventAnnotation.event;
        
        self.image = [UIImage imageNamed:@"vww_32.png"];
//        self.userInteractionEnabled = YES;
        
//        [self addGestureRecognizers];
    }
    
    return self;
}

//-(void)addGestureRecognizers{
//    // Gesture recognizer
//    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureHandler:)];
//    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
//    [self. addGestureRecognizer:singleTapGestureRecognizer];
//    
////    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureHandler:)];
////    [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
////    [self.scrollView addGestureRecognizer:doubleTapGestureRecognizer];
////    
////    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
//}
//
//
//
//-(void)singleTapGestureHandler:(UIGestureRecognizer*)gestureRecognizer{
//    //[self.delegate fullLibraryDataViewControllerSingleTap:self];
//    NSLog(@"asdfasd");
//}

@end
