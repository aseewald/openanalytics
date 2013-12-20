openanalytics
=============

*Foreword*

This library was born out of the necessary of integrating Google Analytics tracking in a 64-bit application. It does not have as many features as the real thing, but it should help you if you want a lighter version of Analytics that will build on any architecture - and if you need more control over what information is being sent to Analytics.

*Google Analytics' Collection API*

The library uses Google's REST API directly - [its documentation is available here](https://developers.google.com/analytics/devguides/collection/protocol/v1/devguide).

*How to install*

1. Add the OpenAnalytics project to your Xcode project and add the OpenAnalytics library as a dependencies

2. Add the following line to your app delegate:

    \#import "OpenAnalytics.h"

3. In your application: didFinishLaunchingWithOptions: function, before you track anything, add the following call, with UA-XXXXXX-X being your Analytics ID.

    [OpenAnalytics analyticsWithTrackingID:@"UA-XXXXXX-X"];

4. Now, anywhere you want to track a page view, just call
    
    [[OpenAnalytics analytics]trackPageView:@"my_event"];

That's it!

*Improvements welcome*

There's a number of improvements to make - such as queuing up page views if the device is offline, or sending more device information back to Google Analytics. Do not hesitate to make some improvements and commit them!
