//
//  VWWEventOrganizerViewController.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventOrganizerViewController.h"
#import "VWWEvent.h"

@interface VWWEventOrganizerViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation VWWEventOrganizerViewController

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
    [self.webView loadHTMLString:self.event.about baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
