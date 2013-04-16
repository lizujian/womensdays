//
//  WDEditDayViewController.m
//  womensdays
//
//  Created by Irina Zavilkina on 14.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDEditDayViewController.h"

#import "WDAppDelegate.h"

#import "WDDay.h"

@interface WDEditDayViewController ()

@property (nonatomic, unsafe_unretained) IBOutlet UIView *startDateView;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *startTitleLabel;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *startDateLabel;

@property (nonatomic, unsafe_unretained) IBOutlet UIView *endDateView;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *endTitleLabel;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *endDateLabel;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *deleteEndDateButton;

@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *durationTitleLabel;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *durationLabel;

@property (nonatomic, unsafe_unretained) IBOutlet UIDatePicker *datePicker;

- (IBAction)dateSelected:(id)sender;
- (IBAction)deleteEndDate:(id)sender;
- (void)selectRow:(id)sender;

@property (nonatomic, strong) WDLabel *selectedLabel;

- (void)cancel;
- (void)save;

@end

@implementation WDEditDayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.startTitleLabel.text = NSLocalizedString(@"Start:", @"");
    self.endTitleLabel.text = NSLocalizedString(@"End:", @"");
    self.durationTitleLabel.text = NSLocalizedString(@"Duration:", @"");

    self.selectedLabel = self.startDateLabel;

    if (self.day)
    {
        self.startDateLabel.text = [self.day startDateAsStringWithFullFormat:YES];
        self.endDateLabel.text = [self.day endDateAsStringWithFullFormat:YES];
        self.durationLabel.text = self.day.durationAsString;
        self.datePicker.date = self.day.startDate;
        self.deleteEndDateButton.hidden = !self.day.isLast;
    }
    
    UITapGestureRecognizer *startDateViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectRow:)];
    [self.startDateView addGestureRecognizer:startDateViewTap];
    UITapGestureRecognizer *endDateViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectRow:)];
    [self.endDateView addGestureRecognizer:endDateViewTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)dateSelected:(id)sender
{
    NSDate *selectedDate = ((UIDatePicker *)sender).date;
    
    if (self.selectedLabel == self.startDateLabel)
    {
        self.day.startDate = selectedDate;
        self.deleteEndDateButton.hidden = !self.day.isLast;
        self.selectedLabel.text = [self.day startDateAsStringWithFullFormat:YES];
    } else
    {
        self.day.endDate = selectedDate;
        self.selectedLabel.text = [self.day endDateAsStringWithFullFormat:YES];
    }
    
    self.durationLabel.text = self.day.durationAsString;
}

- (IBAction)deleteEndDate:(id)sender
{
    self.day.endDate = nil;
    self.endDateLabel.text = @"";
}

- (void)selectRow:(id)sender
{
    if (((UITapGestureRecognizer *)sender).view == self.startDateView)
    {
        self.selectedLabel = self.startDateLabel;
        self.datePicker.date = self.day.startDate;
        self.datePicker.minimumDate = nil;
    } else
    {
        self.selectedLabel = self.endDateLabel;
        self.datePicker.minimumDate = [self.day.startDate dateByAddingTimeInterval:86400];
        self.datePicker.date = self.day.endDate ? self.day.endDate : self.datePicker.minimumDate;
    }
}

#pragma mark - Private methods

- (void)cancel
{
    [(WDAppDelegate *)[UIApplication sharedApplication].delegate rollbackContext];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)save
{
    [(WDAppDelegate *)[UIApplication sharedApplication].delegate saveContext];

    [self.delegate editDayViewControllerDidSaveChanges];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
