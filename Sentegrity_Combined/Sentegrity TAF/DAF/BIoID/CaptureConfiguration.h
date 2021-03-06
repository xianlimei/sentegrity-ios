//
//  CaptureConfiguration.h
//  BioIDSample
//
//  Copyright (c) 2015 BioID. All rights reserved.
//

#import <Foundation/Foundation.h>

#if ! DEBUG
    #define NSLog(...) /* suppress NSLog when in release mode */
#endif

@interface CaptureConfiguration : NSObject

@property (nonatomic, readonly) NSString *bwsToken;
@property (nonatomic, readonly) BOOL performEnrollment;
@property (nonatomic, readonly) NSURL *bwsInstance;

@property (nonatomic, strong, readonly) NSString *BCID;


-(id)initForEnrollment;
-(id)initForVerification:(BOOL)enableChallenge;
-(void)ensureToken:(void (^)(NSError *))callbackBlock;


// create fullBCID with classID generated from string (email)
- (void) updateWithClassIDString: (NSString *) string;


@end

@protocol CaptureDelegate

- (void)biometricTaskFinished:(CaptureConfiguration*)data withSuccess:(BOOL)success;

@end
