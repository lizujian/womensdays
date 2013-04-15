//
//  Day.h
//  womensdays
//
//  Created by Irina Zavilkina on 15.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Day : NSManagedObject

@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * endDate;

@end
