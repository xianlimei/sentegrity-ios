//
//  Sentegrity_TrustFactor_Dataset_Application.h
//  Sentegrity
//
//  Copyright (c) 2015 Sentegrity. All rights reserved.
//

// Import Constants
#import "Sentegrity_Constants.h"

// Headers
#import <Foundation/Foundation.h>

@interface Config : NSObject

// Check if wdevice password set
+ (NSNumber *) hasPassword;

@end
