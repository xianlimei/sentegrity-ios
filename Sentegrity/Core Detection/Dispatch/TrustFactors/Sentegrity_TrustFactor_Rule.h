//
//  Sentegrity_TrustFactor_Rule.h
//  SenTest
//
//  Created by Nick Kramer on 2/7/15.
//  Copyright (c) 2015 Walid Javed. All rights reserved.
//

// Import Constants
#import "Sentegrity_Constants.h"

// Import Assertions
#import "Sentegrity_TrustFactor_Output_Object.h"

// System Frameworks
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Headers
#import <sys/sysctl.h>

// Location data
@import CoreLocation;




@interface Sentegrity_TrustFactor_Rule : NSObject

// Validate the given payload
+ (BOOL)validatePayload:(NSArray *)payload;

// ** PROCESS **
// List of process information including PID's, Names, PPID's, and Status'
+ (NSArray *)processInfo;

+ (NSNumber *) getOurPID;


// ** ROUTE **
// Route data source
+ (NSArray *)routeInfo;

// Get WiFi Router Address
+ (NSString *)wiFiRouterAddress;

// ** NETSTAT **
// Connection Info
+ (NSArray *) netstatInfo;

// ** LOCATION **
// Location Info
+ (CLLocation *)locationInfo;
+ (void)setLocation:(CLLocation *)location;
+ (void)setLocationDNEStatus:(int)dneStatus;
+ (int)locationDNEStatus;

// ** ACTIVITIES **
// Activity Info
+ (NSArray *)activityInfo;
+ (void)setActivity:(NSArray *)location;
+ (void)setActivityDNEStatus:(int)dneStatus;
+ (int)activityDNEStatus;

// ** MOTION **
// Motion Info
+ (NSArray *)motionInfo;
+ (void)setMotion:(NSArray *)motion;
+ (void)setMotionDNEStatus:(int)dneStatus;
+ (int)motionDNEStatus;

@end
