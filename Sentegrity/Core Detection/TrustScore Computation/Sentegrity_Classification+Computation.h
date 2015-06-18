//
//  Sentegrity_Classification+Computation.h
//  SenTest
//
//  Created by Kramer on 4/15/15.
//  Copyright (c) 2015 Walid Javed. All rights reserved.
//

#import "Sentegrity_Classification.h"

@interface Sentegrity_Classification (Computation)

//links
@property (nonatomic,retain) NSArray *subClassifications;
@property (nonatomic,retain) NSArray *trustFactors;

//protect mode
@property (nonatomic,retain) NSArray *trustFactorsToWhitelist;

//penalty
@property (nonatomic) NSInteger basePenalty;
@property (nonatomic) NSInteger weightedPenalty;

//messages
@property (nonatomic,retain) NSArray *issuesInClass;
@property (nonatomic,retain) NSArray *suggestionsInClass;
@property (nonatomic,retain) NSArray *subClassStatus;

@end
