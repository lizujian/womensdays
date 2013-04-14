//
//  WDDay.h
//  womensdays
//
//  Created by Ирина Завилкина on 12.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDDay : NSObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@property (nonatomic, assign, readonly) NSUInteger duration;
@property (nonatomic, strong, readonly) NSString *durationAsString;

+ (NSArray *)allDays;

- (NSString *)startDateAsStringWithFullFormat:(BOOL)fullFormat;
- (NSString *)endDateAsStringWithFullFormat:(BOOL)fullFormat;

@end
