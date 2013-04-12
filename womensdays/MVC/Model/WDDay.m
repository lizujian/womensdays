//
//  WDDay.m
//  womensdays
//
//  Created by Ирина Завилкина on 12.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDDay.h"

@implementation WDDay

#pragma mark - Getters

- (NSUInteger)duration
{
    return 6;
}

- (NSString *)startDateAsString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    return [dateFormatter stringFromDate:self.startDate];
}

- (NSString *)endDateAsString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    return [dateFormatter stringFromDate:self.endDate];
}

#pragma mark - Public methods

+ (NSArray *)allDays
{
    //TODO: stub!
    NSMutableArray *newDays = [NSMutableArray arrayWithCapacity:20];
    
    for (int i = 0; i < 20; i++)
    {
        WDDay *newDay = [[WDDay alloc] init];
        newDay.startDate = [NSDate date];
        newDay.endDate = [NSDate date];
        [newDays addObject:newDay];
    }

    return newDays;
}

@end
