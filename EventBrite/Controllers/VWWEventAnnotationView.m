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
#import "UIImage+Resize.h"

@implementation VWWEventAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        VWWEventAnnotation *eventAnnotation = (VWWEventAnnotation*)self.annotation;
        VWWEvent *event = eventAnnotation.event;

        
        //    __weak VWWEventDetailsViewController *weakSelf = self;
//        NSURL *logoURL = [NSURL URLWithString:event.logo];
//        [[SDWebImageManager sharedManager] downloadWithURL:logoURL
//                                                   options:SDWebImageRetryFailed
//                                                  progress:^(NSUInteger receivedSize, long long expectedSize) {
//                                                  } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
//                                                      CGFloat height = 32 * image.size.height / (float)image.size.width;
//                                                      UIImage *resizedImage = [UIImage resizeImage:image toSize:CGSizeMake(32, height)];
//                                                      self.image = resizedImage;
//                                                  }];

        if(event.logoImage){
            self.image = event.logoImage;
        }
        else{
            self.image = [UIImage imageNamed:@"vww_32.png"];
        }
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
