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
#import "VWWRESTSession.h"

static NSString *kSegueSearchToTabs = @"segueSearchToTabs";

@interface VWWSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *keywordTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (nonatomic, strong) VWWRESTSession *session;
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
	
    self.session = [VWWRESTSession sharedInstance];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setTitle:@"Testing"];
//    [self.navigationItem setTitle:@"Testinger"];
//    [self.navigationController.navigationItem setTitle:@"eeee"];
//    self.navigationController.navigationBar setTitl
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:kSegueSearchToTabs]){
        
    }
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
    
    
    [self.session.searches removeAllObjects];
    
    [[VWWRESTEngine sharedInstance] getEventSearchWithForm:form
                                           completionBlock:^(VWWEvents *events) {
                                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                                               
                                               
                                               VWWEventsSearch *search = [[VWWEventsSearch alloc]init];
                                               search.searchParemeters = @{@"city" : form.city,
                                                                           @"keywords" : form.keywords};
                                            
                                               search.events = events;
                                               [self.session.searches addObject:search];
                                               
                                               
                                               [self performSegueWithIdentifier:kSegueSearchToTabs sender:self];
                                           } errorBlock:^(NSError *error) {
                                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                                           }];
    
    
    
}



@end
