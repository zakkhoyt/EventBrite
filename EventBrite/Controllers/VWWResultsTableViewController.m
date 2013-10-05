//
//  VWWResultsTableViewController.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWResultsTableViewController.h"
#import "VWWRESTSession.h"
#import "VWWResultsTableViewCell.h"
//#import "VWWEvents.h"
#import "VWWEventDetailsViewController.h"

static NSString *kSegueTableToDetails = @"segueTableToDetails";

@interface VWWResultsTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VWWRESTSession *session;
@end

@implementation VWWResultsTableViewController

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
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:kSegueTableToDetails]){
        VWWEventDetailsViewController *vc = segue.destinationViewController;
        vc.event = sender;
    }
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    VWWEventsSearch *search = self.session.searches[0];
//    VWWEvents *results = search.results;
//    return results.events.count;
////    return self.session.searches.events.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    VWWResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWResultsTableViewCell"];
//    VWWEventsSearch *search = self.session.searches[0];
//    VWWEvents *results = search.results;
//    cell.event = results.events[indexPath.row];
//    return cell;
////    cell.event = events
////    return cell;
    return [[UITableViewCell alloc]init];
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VWWResultsTableViewCell *cell = (VWWResultsTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:kSegueTableToDetails sender:cell.event];
}



@end

