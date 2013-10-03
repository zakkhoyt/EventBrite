//
//  VWWUserDefaults.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import <Foundation/Foundation.h>

@interface VWWUserDefaults : NSObject

+(BOOL)debugMode;




+(NSString*)server;

+(BOOL)smileServerSecure;
+(void)setSmileServerSecure:(BOOL)secure;



@end
