//
//  VWWAboutViewController.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWAboutViewController.h"

@interface VWWAboutViewController ()
@property (weak, nonatomic) IBOutlet UITextView *aboutTextView;

@end

@implementation VWWAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
//    self.aboutTextView.text =
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

