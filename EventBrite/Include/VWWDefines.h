//
//  VWWDefines.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#ifndef EventBrite_VWWDefines_h
#define EventBrite_VWWDefines_h

#define VWW_EVENT_BRITE_SERVER @"www.eventbrite.com"
#define VWW_EVENT_BRITE_KEY @"XWBZSYUMMSGVQPP5TJ"



#define kVWWTokenKeychainItemID @"vww_token_keychain_item_id"
#define kVWWUUIDKeychainItemID @"vww_uuid_keychain_item_id"


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#endif
