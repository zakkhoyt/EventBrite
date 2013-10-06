//
//  VWWPushCrossfadeSegue
//  Heartstream
//
//  Created by Zakk Hoyt on 6/24/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWPushCrossfadeSegue.h"
#import <QuartzCore/QuartzCore.h>

@implementation VWWPushCrossfadeSegue
-(void)perform{
    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    CATransition* transition = [CATransition animation];
    transition.duration = .45;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush,   kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    
    
    [sourceViewController.navigationController.view.layer addAnimation:transition
                                                                forKey:kCATransition];
    
    [sourceViewController.navigationController pushViewController:destinationController animated:NO];
    
    
}
@end
