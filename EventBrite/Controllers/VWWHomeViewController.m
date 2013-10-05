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

typedef enum {
  VWWHomeTableViewSectionNewSearch = 0,
    VWWHomeTableViewSectionPreviousSearches = 1,
    VWWHomeTableViewSectionClearSearches = 2,
} VWWHomeTableViewSection;


@interface VWWHomeViewController ()

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }
    else if(section == 1){
        return 0;
    }
    else if(section == 2){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        VWWHomeNewSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWHomeNewSearchTableViewCell"];
        return cell;
    }
    else if(indexPath.section == 1){
        
    }
    else if(indexPath.section == 2){

    }
    
    return [[UITableViewCell alloc]init];
}

@end
