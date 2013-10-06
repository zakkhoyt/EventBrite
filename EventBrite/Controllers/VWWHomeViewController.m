//
//  VWWHomeViewController.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWHomeViewController.h"
#import "VWWHomeNewSearchTableViewCell.h"
#import "VWWHomeClearSearchesTableViewCell.h"
#import "VWWHomePreviousSearchTableViewCell.h"
#import "VWWHomeAboutTableViewCell.h"
#import "VWWCoreData.h"
#import "VWWSession.h"
#import "MBProgressHUD.h"

typedef enum {
    VWWHomeTableViewSectionNewSearch = 0,
    VWWHomeTableViewSectionPreviousSearches = 1,
    VWWHomeTableViewSectionClearSearches = 2,
    VWWHomeTableViewSectionAbout = 3,
} VWWHomeTableViewSection;

static NSString *kSegueHomeToResults = @"segueHomeToResults";
static NSString *kSegueHomeToNewSearch = @"segueHomeToNewSearch";
static NSString *kSegueHomeToAbout = @"segueHomeToAbout";

@interface VWWHomeViewController ()
@property (nonatomic) BOOL hasLoaded;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *eventsSearches;
@end

@implementation VWWHomeViewController

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
    [self.navigationController setNavigationBarHidden:YES];
    [[VWWCoreData sharedInstance] getPreviousSearchesWithCompletion:^(NSArray *previousSearches) {
        NSLog(@"Found %d previous searches", previousSearches.count);
        self.eventsSearches = previousSearches;
        //        [self.tableView reloadData];
        //        [self.tableView setNeedsDisplay];
        NSIndexSet *sections = [NSIndexSet indexSetWithIndex:VWWHomeTableViewSectionPreviousSearches];
        [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [self.tableView reloadData];

}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if(self.hasLoaded == NO){
        self.hasLoaded = YES;
     
//        [[VWWCoreData sharedInstance] getPreviousSearchesWithCompletion:^(NSArray *previousSearches) {
//            NSLog(@"Found %d previous searches", previousSearches.count);
//            self.eventsSearches = previousSearches;
//            //        [self.tableView reloadData];
//            //        [self.tableView setNeedsDisplay];
//            NSIndexSet *sections = [NSIndexSet indexSetWithIndex:VWWHomeTableViewSectionPreviousSearches];
//            [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
//        }];
//        
//        [self.tableView reloadData];
    }
    
    [self.view layoutSubviews];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // TODO: query
//    [[VWWCoreData sharedInstance] getPreviousSearchesWithCompletion:^(NSArray *previousSearches) {
//        NSLog(@"Found %d previous searches", previousSearches.count);
//        self.eventsSearches = previousSearches;
////        [self.tableView reloadData];
////        [self.tableView setNeedsDisplay];
//        NSIndexSet *sections = [NSIndexSet indexSetWithIndex:VWWHomeTableViewSectionPreviousSearches];
//        [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
//    }];
//    
//    [self.tableView reloadData];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == VWWHomeTableViewSectionNewSearch){
        return 1;
    }
    else if(section == VWWHomeTableViewSectionPreviousSearches){
        return self.eventsSearches.count;
    }
    else if(section == VWWHomeTableViewSectionClearSearches){
        return 1;
    }
    else if(section == VWWHomeTableViewSectionAbout){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == VWWHomeTableViewSectionNewSearch){
        VWWHomeNewSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWHomeNewSearchTableViewCell"];
        return cell;
    }
    else if(indexPath.section == VWWHomeTableViewSectionPreviousSearches){
        VWWHomePreviousSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWHomePreviousSearchTableViewCell"];
        cell.eventsSearch = self.eventsSearches[indexPath.row];
        return cell;
    }
    else if(indexPath.section == VWWHomeTableViewSectionClearSearches){
        VWWHomeClearSearchesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWHomeClearSearchesTableViewCell"];
        return cell;
    }
    else if(indexPath.section == VWWHomeTableViewSectionAbout){
        VWWHomeAboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWHomeAboutTableViewCell"];
        return cell;
        
    }
    
    return [[UITableViewCell alloc]init];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s", __func__);
    if(indexPath.section == VWWHomeTableViewSectionNewSearch){
        [self performSegueWithIdentifier:kSegueHomeToNewSearch sender:self];
    }
    else if(indexPath.section == VWWHomeTableViewSectionPreviousSearches){
        [VWWSession sharedInstance].currentEventsSearch = self.eventsSearches[indexPath.row];
        [self performSegueWithIdentifier:kSegueHomeToResults sender:self];
    }
    else if(indexPath.section == VWWHomeTableViewSectionClearSearches){
        [[[UIAlertView alloc]initWithTitle:@"Delete searches" message:@"Are you sure?"
                                  delegate:self
                         cancelButtonTitle:@"No" otherButtonTitles:@"Yep", nil]show];
        
        
    }
    
    else if(indexPath.section == VWWHomeTableViewSectionAbout){
        [self performSegueWithIdentifier:kSegueHomeToAbout sender:self];
    }
    
}

#pragma   mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.50];
        hud.labelText = @"Deleting searches...";

        [[VWWCoreData sharedInstance]deleteAllObjectsWithCompletion:^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.eventsSearches = @[];
            [self.tableView reloadData];
        }];
    }
}


@end
