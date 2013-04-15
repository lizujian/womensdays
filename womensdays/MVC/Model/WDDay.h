//
//  WDDay.h
//  womensdays
//
//  Created by Irina Zavilkina on 15.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface WDDay : NSManagedObject

@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * endDate;

@property (nonatomic, assign, readonly) NSUInteger duration;
@property (nonatomic, strong, readonly) NSString *durationAsString;

+ (NSArray *)allDays;

- (NSString *)startDateAsStringWithFullFormat:(BOOL)fullFormat;
- (NSString *)endDateAsStringWithFullFormat:(BOOL)fullFormat;

@end
