//
//  VWWEvent.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEvent.h"
#import "VWWEventOrganizer.h"
#import "VWWEventTicket.h"
#import "VWWEventVenue.h"
#import "VWWSearchResults.h"
#import "NSDictionary+TypedGetters.h"
#import "SDWebImageManager.h"
#import "UIImage+Resize.h"

@implementation VWWEvent

@dynamic capacity;
@dynamic title;
@dynamic about;
@dynamic distance;
@dynamic logo;
@dynamic backgroundColor;
@dynamic boxBackgroundColor;
@dynamic boxBorderColor;
@dynamic startDate;
@dynamic uuid;
@dynamic boxHeaderBackgroundColor;
@dynamic boxHeaderTextColor;
@dynamic boxTextColor;
@dynamic url;
@dynamic eventOrganizer;
@dynamic eventVenue;
@dynamic searchResults;
@dynamic eventTickets;
@synthesize logoImage;

-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context{
    // Event details
    self.title = dictionary[@"title"];
    self.backgroundColor = dictionary[@"background_color"];
    self.boxBackgroundColor = dictionary[@"box_background_color"];
    self.boxBorderColor = dictionary[@"box_border_color"];
    self.boxHeaderBackgroundColor  = dictionary[@"box_header_background_color"];
    self.boxHeaderTextColor = dictionary[@"box_header_text_color"];
    self.boxTextColor = dictionary[@"box_text_color"];
    self.uuid = dictionary[@"id"];
    self.capacity = dictionary[@"capacity"];
    self.startDate = dictionary[@"start_date"];
    self.title = dictionary[@"title"];
    self.about = dictionary[@"description"];
    self.distance = dictionary[@"distance"];
    self.logo = dictionary[@"logo"];
    self.url = dictionary[@"url"];

    // Organizer
    NSDictionary *organizerDictionary = dictionary[@"organizer"];
    if(organizerDictionary){
        VWWEventOrganizer *organizer = [NSEntityDescription insertNewObjectForEntityForName:@"VWWEventOrganizer"
                                                                     inManagedObjectContext:context];

        [organizer populateWithDictionary:organizerDictionary context:context];
        self.eventOrganizer = organizer;
    }

    // Venue
    NSDictionary *venueDictionary = dictionary[@"venue"];
    if(venueDictionary){
        VWWEventVenue *venue = [NSEntityDescription insertNewObjectForEntityForName:@"VWWEventVenue"
                                                             inManagedObjectContext:context];
        [venue populateWithDictionary:venueDictionary context:context];
        self.eventVenue = venue;
    }
    
    // Ticket types
    NSArray *ticketsArray = dictionary[@"tickets"];
    if(ticketsArray){
        NSMutableSet *eventTickets = [[NSMutableSet alloc]init];
        for(NSDictionary *ticketDictionary in ticketsArray){
            NSDictionary *ticketDetailsDictionary = ticketDictionary[@"ticket"];
            if(ticketDetailsDictionary){
                VWWEventTicket *ticket = [NSEntityDescription insertNewObjectForEntityForName:@"VWWEventTicket"
                                                                       inManagedObjectContext:context];
                [ticket populateWithDictionary:ticketDetailsDictionary context:context];
                [eventTickets addObject:ticket];
            }
        }
        self.eventTickets = eventTickets;
    }
    
    
    // Now prefetch and resize logo Image
    NSURL *logoURL = [NSURL URLWithString:self.logo];
    [[SDWebImageManager sharedManager] downloadWithURL:logoURL
                                               options:SDWebImageRetryFailed
                                              progress:^(NSUInteger receivedSize, long long expectedSize) {
                                              } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                                                  CGFloat height = 32 * image.size.height / (float)image.size.width;
                                                  UIImage *resizedImage = [UIImage resizeImage:image toSize:CGSizeMake(32, height)];
                                                  self.logoImage = resizedImage;
                                              }];

}

-(NSString*)description{
    return [NSString stringWithFormat:@"backgroundColor: %@"
            @"boxBackgroundColor: %@"
            @"boxBorderColor: %@"
            @"boxHeaderBackgroundColor: %@"
            @"boxHeaderTextColor: %@"
            @"boxTextColor: %@"
            @"id: %@"
            @"capacity: %@"
            @"start_date: %@"
            @"title: %@"
            @"about: %@"
            @"distance: %@"
            @"logo: %@"
            @"url: %@",
            self.backgroundColor,
            self.boxBackgroundColor,
            self.boxBorderColor,
            self.boxHeaderBackgroundColor,
            self.boxHeaderTextColor,
            self.boxTextColor,
            self.uuid,
            self.capacity,
            self.startDate,
            self.title,
            self.about,
            self.distance,
            self.logo,
            self.url];
}

@end







@implementation VWWEvent (events)

-(void)shareEvent:(VWWEvent*)event viewControoller:(UIViewController*)viewController completion:(VWWEmptyBlock)completion{
    void (^shareEvent)(UIImage *image) = ^(UIImage *image){
        
        NSMutableArray *items = [@[event.title]mutableCopy];
        // Add image
        if(image)
            [items addObject:image];
        
        // Add event url
        NSURL *eventURL = [NSURL URLWithString:self.url];
        if(eventURL)
            [items addObject:eventURL];

//        // Add location URL, which will shell to apple maps
//        NSString *locationString = [[NSString alloc]initWithFormat:@"http://maps.apple.com/maps?q=%f,%f", event.eventVenue.latitude.floatValue, event.eventVenue.longitude.floatValue];
//        NSURL *locationURL = [NSURL URLWithString:locationString];
//        if(locationURL)
//            [items addObject:locationURL];
        
        
        NSMutableArray *activities = [@[]mutableCopy];
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:items
                                                                                            applicationActivities:activities];
        
        activityViewController.completionHandler = ^(NSString *activityType, BOOL completed){
            completion();
        };
        
        [viewController presentViewController:activityViewController animated:YES completion:nil];
    };
    
    
    NSURL *logoURL = [NSURL URLWithString:event.logo];
    [[SDWebImageManager sharedManager] downloadWithURL:logoURL
                                               options:SDWebImageRetryFailed
                                              progress:^(NSUInteger receivedSize, long long expectedSize) {
                                              } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                                                  shareEvent(image);
                                              }];
}

-(void)directionsToEvent:(VWWEvent*)event{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(event.eventVenue.latitude.floatValue, event.eventVenue.longitude.floatValue);
    MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
    destination.name = event.title;
    NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
    NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
                             MKLaunchOptionsDirectionsModeDriving,
                             MKLaunchOptionsDirectionsModeKey, nil];
    [MKMapItem openMapsWithItems: items launchOptions: options];
}
@end
