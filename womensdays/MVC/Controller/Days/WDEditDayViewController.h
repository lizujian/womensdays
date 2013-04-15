//
//  WDEditDayViewController.h
//  womensdays
//
//  Created by Irina Zavilkina on 14.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDViewController.h"

@class WDDay;

@protocol WDEditDayViewControllerDelegate <NSObject>

- (void)editDayViewControllerDidSaveChanges;

@end

@interface WDEditDayViewController : WDViewController

@property (nonatomic, strong) WDDay *day;

@property (nonatomic, assign) id <WDEditDayViewControllerDelegate> delegate;

@end
