//
//  VWWSearchViewController.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSearchViewController.h"
#import "MBProgressHUD.h"
#import "VWWRESTEngine.h"

@interface VWWSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *keywordTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@end

@implementation VWWSearchViewController

#pragma mark Overridden methods
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private methods


#pragma mark IBActions

- (IBAction)searchButtonTouchUpInside:(id)sender {
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.50];
    hud.labelText = @"Searching events...";
    
    VWWGetEventSearchForm *form = [[VWWGetEventSearchForm alloc]init];
    form.city = self.cityTextField.text;
    form.keywords = self.keywordTextField.text;
    
    
    
    
    [[VWWRESTEngine sharedInstance] getEventSearchWithForm:form
                                           completionBlock:^(NSArray *events) {
                                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                                           } errorBlock:^(NSError *error) {
                                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                                           }];
    
    
    
}



@end
