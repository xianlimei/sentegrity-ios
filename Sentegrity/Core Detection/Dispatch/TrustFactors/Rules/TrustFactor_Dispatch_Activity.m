//
//  TrustFactor_Dispatch_Activity.m
//  SenTest
//
//  Created by Walid Javed on 1/28/15.
//  Copyright (c) 2015 Walid Javed. All rights reserved.
//

#import "TrustFactor_Dispatch_Activity.h"

@implementation TrustFactor_Dispatch_Activity



// 39
+ (Sentegrity_TrustFactor_Output_Object *)unknown:(NSArray *)payload {
    
    // Create the trustfactor output object
    Sentegrity_TrustFactor_Output_Object *trustFactorOutputObject = [[Sentegrity_TrustFactor_Output_Object alloc] init];
    
    // Set the default status code to OK (default = DNEStatus_ok)
    [trustFactorOutputObject setStatusCode:DNEStatus_ok];
    
    // Create the output array
    NSMutableArray *outputArray = [[NSMutableArray alloc] initWithCapacity:payload.count];
    
    // Get the user's activity history
    NSArray *activities;
    
    // If the handler already determined a problem
    if ([self activityDNEStatus] != 0 ){
        // Set the DNE status code to what was previously determined
        [trustFactorOutputObject setStatusCode:[self activityDNEStatus]];
        
        // Return with the blank output object
        return trustFactorOutputObject;
    }
    else{ //try to get dataset
        
        activities = [self activityInfo];
        
        // Check activity dataset again 
        if (!activities || activities == nil || activities.count < 4) {
            
            [trustFactorOutputObject setStatusCode:DNEStatus_error];
            // Return with the blank output object
            return trustFactorOutputObject;
        }
        
        
    }
    
    bool walking = 0;
    bool running = 0;
    bool driving = 0;
    bool stationary = 0;
    
    // Check each category for hit since lots of activities are returned in most cases
    for (CMMotionActivity *actItem in activities)
    {
        if (actItem.walking == 1)
            walking=1;
        if (actItem.running == 1)
            running=1;
        if (actItem.automotive == 1)
            driving=1;
        if (actItem.stationary == 1)
            stationary=1;
    }
    
    
    NSLog(@"walking: %i", walking);
    NSLog(@"running: %i", running);
    NSLog(@"driving: %i",  driving);
    NSLog(@"stationary: %i", stationary);
    
    NSString *activityTuple = [NSString stringWithFormat:@"%i%i%i%i",walking,running,driving,stationary];
    
    NSLog(@"activityTuple: %@", activityTuple);
    
    [outputArray addObject:activityTuple];
    
    // Set the trustfactor output to the output array (regardless if empty)
    [trustFactorOutputObject setOutput:outputArray];
    
    // Return the trustfactor output object
    return trustFactorOutputObject;
    
}


@end
