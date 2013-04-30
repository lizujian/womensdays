//
//  WDDay.h
//  womensdays
//
//  Created by Irina Zavilkina on 15.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MojoModel.h"

@interface WDDay : MojoModel

@property (nonatomic, strong) NSDate * startDate;
@property (nonatomic, strong) NSDate * endDate;

@property (nonatomic, assign, readonly) NSUInteger duration;
@property (nonatomic, strong, readonly) NSString *durationAsString;
@property (nonatomic, assign, readonly) BOOL isLast;

+ (NSArray *)allDays;

- (NSString *)startDateAsStringWithFullFormat:(BOOL)fullFormat;
- (NSString *)endDateAsStringWithFullFormat:(BOOL)fullFormat;

@end
