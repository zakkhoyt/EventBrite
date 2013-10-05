//
//  VWWResultsMapViewController.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWResultsMapViewController.h"
#import <MapKit/MapKit.h>
#import "VWWSession.h"
#import "VWWResultsTableViewCell.h"
#import "VWWEventDetailsViewController.h"
#import "VWWEventsSearch.h"
#import "VWWSearchResults.h"
#import "VWWEvent.h"
#import "VWWEventVenue.h"
#import "VWWEventAnnotation.h"
#import "VWWEventAnnotationView.h"
#import "VWWUtility.h"

@interface VWWResultsMapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSArray *events;
@property (nonatomic) BOOL hasLoaded;
@end

@implementation VWWResultsMapViewController

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
	self.mapView.showsUserLocation = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    VWWEventsSearch *search = [VWWSession sharedInstance].currentEventsSearch;
    self.events = search.searchResults.events.allObjects;
    
    MKCoordinateRegion eventRegion = [self calculateRegionFromEvents];
    [self.mapView setRegion:eventRegion];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if(self.hasLoaded == NO){
        self.hasLoaded = YES;
        
    }
    [self.view layoutSubviews];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self addAnnotationsForEvents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private methods

-(void)addAnnotationsForEvents{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

    for(NSInteger index = 0; index < self.events.count; index++){
        VWWEvent *event = self.events[index];
            VWWEventAnnotation *annotation = [[VWWEventAnnotation alloc] init];
            annotation.event = event;
            VWWEventVenue *venue = event.eventVenue;
            annotation.coordinate = CLLocationCoordinate2DMake(venue.latitude.floatValue, venue.longitude.floatValue);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mapView addAnnotation:annotation];
            });
        }
    });
}

-(MKCoordinateRegion)calculateRegionFromEvents{
    
    CLLocationDegrees minLatitude = 0;
    CLLocationDegrees maxLatitude = 0;
    CLLocationDegrees minLongitude = 0;
    CLLocationDegrees maxLongitude = 0;

    // Iterate through events to calculate a box
    for(VWWEvent *event in self.events){
        VWWEventVenue *venue = event.eventVenue;
        if(venue.latitude && venue.longitude){
            // Initialize the variables to first valid location
            if(minLatitude == 0){
                minLatitude = venue.latitude.floatValue;
                maxLatitude = venue.latitude.floatValue;
            }
            else{
                minLatitude = MIN(minLatitude, venue.latitude.floatValue);
                maxLatitude = MAX(maxLongitude, venue.latitude.floatValue);
            }
            
            
            if(minLongitude == 0){
                minLongitude = venue.longitude.floatValue;
                maxLongitude = venue.longitude.floatValue;
            }
            else{
                minLongitude = MIN(minLongitude, venue.longitude.floatValue);
                maxLongitude = MAX(maxLongitude, venue.longitude.floatValue);
            }
        }
    }
    
    // Convert the box to a region with a little math
    
    // Average the max and min to find the center
    CLLocationDegrees latitude = (minLatitude + maxLatitude) / 2.0;
    CLLocationDegrees longitude = (minLongitude + maxLongitude) / 2.0;
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    const CLLocationDegrees kMinimumSpan = 0.005;
    // Calculate the distance from center of the box to the edges
    CLLocationDegrees latitudeDelta = MAX((maxLatitude - minLatitude) / 2.0, kMinimumSpan);
    CLLocationDegrees longitudeDelta = MAX((maxLongitude - minLongitude) / 2.0, kMinimumSpan);
    

    latitudeDelta *= 4.0;
    longitudeDelta *= 4.0;
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    NSLog(@"Event region. Center: %f,%f  size: %f,%f",
          region.center.latitude,
          region.center.longitude,
          region.span.latitudeDelta,
          region.span.longitudeDelta);
    return region;
}

-(void)zoomToRegion{
    MKUserLocation *userLocation = self.mapView.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 50, 50);
    [self.mapView setRegion:region animated:NO];
}

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    NSLog(@"annotation: %@", [annotation class]);
    if([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    
    
    VWWEventAnnotationView *annotationView = [[VWWEventAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Event"];
    annotationView.canShowCallout = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"map_29"] forState:UIControlStateNormal];
    
    annotationView.rightCalloutAccessoryView = button;
    annotationView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    return annotationView;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
//    MyLocation *location = (MyLocation*)view.annotation;
    
//    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
//    [location.mapItem openInMapsWithLaunchOptions:launchOptions];
    [VWWUtility errorAlert:@"callout" title:@"pressed"];
}


@end
