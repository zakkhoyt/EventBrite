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
#import "VWWSession.h"
#import "VWWCoreData.h"
#import "VWWUtility.h"

static NSString *kSegueSearchToTabs = @"segueSearchToTabs";

@interface VWWSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *keywordTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;
@property (weak, nonatomic) IBOutlet UITextField *postalCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (nonatomic, strong) VWWSession *session;
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
	
    self.session = [VWWSession sharedInstance];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
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
    if(self.cityTextField.text.length) form.city = self.cityTextField.text;
    if(self.keywordTextField.text.length) form.keywords = self.keywordTextField.text;
    if(self.addressTextField.text.length) form.address = self.addressTextField.text;
    if(self.regionTextField.text.length) form.region = self.regionTextField.text;
    if(self.postalCodeTextField.text.length) form.postalCode = self.postalCodeTextField.text;
    if(self.countryTextField.text.length) form.country = self.countryTextField.text;
    
    
    [[VWWRESTEngine sharedInstance] getEventSearchWithForm:form
                                           completionBlock:^(VWWEventsSearch *eventsSearch) {
                                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                                               
                                               if(eventsSearch == nil){
                                                   [VWWUtility errorAlert:@"Bummer!" title:@"No results were found"];
                                               }
                                               else{
                                                   [VWWSession sharedInstance].currentEventsSearch = eventsSearch;
                                                   [self performSegueWithIdentifier:kSegueSearchToTabs sender:eventsSearch];
                                               }
                                           } errorBlock:^(NSError *error) {
                                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                                           }];
    
    
    
}



#pragma   mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
