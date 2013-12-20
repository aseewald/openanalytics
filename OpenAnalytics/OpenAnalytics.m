//
//  OpenAnalytics.h
//
//  Created by Alex Seewald on 04/11/2013.
//  Copyright (c) 2013 Openshadow Limited. All rights reserved.
//

#import "OpenAnalytics.h"
#import "OpenUDID.h"

__strong OpenAnalytics *analytics = nil;

@implementation OpenAnalytics

-(id)init
{
	if (self = [super init])
	{
		self.queue = [[NSOperationQueue alloc]init];
		[_queue setMaxConcurrentOperationCount:1];
	}
	return self;
}

+(OpenAnalytics*)analytics
{
	if (!analytics)
	{
		analytics = [[OpenAnalytics alloc]init];
	}
	
	return analytics;
}

+(OpenAnalytics*)analyticsWithTrackingID:(NSString*)idString
{
	if (!analytics)
	{
		analytics = [[OpenAnalytics alloc]init];
	}
	
	[analytics setTrackingID:idString];
	
	return analytics;
}

-(void)trackPageView:(NSString *)pageViewTag
{
	assert(_trackingID); // Ensure we have a tracking ID - remember to initialise the library with [OpenAnalytics analytics]analyticsWithTrackingID:@"xxxxx"] when the app loads
	
	NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:
								   ^{
									   
									   /* Unused for now
										float scale = [[UIScreen mainScreen]scale];
									   CGSize resolution = [[UIScreen mainScreen]bounds].size;
									   NSString *resolutionString = [NSString stringWithFormat:@"%ix%i", (int)(resolution.width * scale), (int)(resolution.height * scale)];
										*/
									   
									   NSString *userLanguage = [[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"][0];
									   
									   NSString *urlString = [NSString stringWithFormat:@"%@?v=1&tid=%@&cid=%@&ul=%@&t=appview&an=%@&av=%@&cd=%@&z=%i",
															  ANALYTICS_API,
															  [_trackingID stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
															  [[OpenUDID value] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
															  [userLanguage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
															  [[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleName"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
															  [[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleVersion"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
															  [[pageViewTag stringByReplacingOccurrencesOfString:@"/" withString:@""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
															  rand()%1000000];
									   
									   NSURL *url = [NSURL URLWithString:urlString];
									   NSURLResponse *response = nil;
									   NSError *error = nil;

#if TARGET_IPHONE_SIMULATOR
									   NSData *data =
#endif
									   
									   [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:&response error:&error];
									   
#if TARGET_IPHONE_SIMULATOR
									   NSLog(@"%@", response);
									   NSLog(@"%@", error);
									   NSLog(@"Response for %@ = %@", url, data);
#endif
									   
								   }];
	[_queue addOperation:operation];
}

-(void)dealloc
{
	[_queue cancelAllOperations];
}

@end
