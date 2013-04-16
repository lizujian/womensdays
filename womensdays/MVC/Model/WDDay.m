//
//  WDDay.m
//  womensdays
//
//  Created by Irina Zavilkina on 15.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDDay.h"

@implementation WDDay

@dynamic startDate;
@dynamic endDate;

static NSString *FULL_DATE_FORMAT = @"dd MMMM yyyy, EE";
static NSString *SHORT_DATE_FORMAT = @"dd.MM.yyyy";

#pragma mark - Getters

- (NSUInteger)duration
{
    return (int)round([(self.endDate ? self.endDate : [NSDate date]) timeIntervalSinceDate:self.startDate] / 86400);
}

- (NSString *)durationAsString
{
    return [NSString stringWithFormat:@"%i %@", self.duration, [@(self.duration) stringValueWithLocalizablingVariants:@[@"day", @"few days", @"days"]]];
}

- (BOOL)isLast
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate > %@", self.startDate];
    return [[WDDay findAllWithPredicate:predicate] count] == 0;
}

#pragma mark - Public methods

+ (NSArray *)allDays
{
    return [WDDay findAllSortedBy:@"startDate" ascending:NO];
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
