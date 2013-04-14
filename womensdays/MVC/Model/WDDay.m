//
//  WDDay.m
//  womensdays
//
//  Created by Ирина Завилкина on 12.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDDay.h"

@implementation WDDay

static NSString *FULL_DATE_FORMAT = @"dd MMMM yyyy, EE";
static NSString *SHORT_DATE_FORMAT = @"dd.MM.yyyy";

#pragma mark - Getters

- (NSUInteger)duration
{
    return 6;
}

- (NSString *)durationAsString
{
    return [NSString stringWithFormat:@"%i %@", self.duration, [@(self.duration) stringValueWithLocalizablingVariants:@[@"day", @"few days", @"days"]]];
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

- (NSString *)startDateAsStringWithFullFormat:(BOOL)fullFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = fullFormat ? FULL_DATE_FORMAT : SHORT_DATE_FORMAT;
    return [dateFormatter stringFromDate:self.startDate];
}

- (NSString *)endDateAsStringWithFullFormat:(BOOL)fullFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = fullFormat ? FULL_DATE_FORMAT : SHORT_DATE_FORMAT;
    return [dateFormatter stringFromDate:self.endDate];
}

@end
