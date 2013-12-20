//
//  OpenAnalytics.h
//
//  Created by Alex Seewald on 04/11/2013.
//  Copyright (c) 2013 Openshadow Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ANALYTICS_API @"http://www.google-analytics.com/collect"

@interface OpenAnalytics : NSObject
{
	
}

@property (retain) NSOperationQueue *queue;
@property (retain) NSString *trackingID;

+(OpenAnalytics*)analytics;
+(OpenAnalytics*)analyticsWithTrackingID:(NSString*)idString;
-(void)trackPageView:(NSString*)pageViewTag;

@end
