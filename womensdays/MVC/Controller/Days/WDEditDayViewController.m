//
//  WDEditDayViewController.m
//  womensdays
//
//  Created by Irina Zavilkina on 14.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDEditDayViewController.h"

#import "WDDay.h"

@interface WDEditDayViewController ()

@property (nonatomic, unsafe_unretained) IBOutlet UIView *startDateView;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *startTitleLabel;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *startDateLabel;

@property (nonatomic, unsafe_unretained) IBOutlet UIView *endDateView;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *endTitleLabel;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *endDateLabel;

@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *durationTitleLabel;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *durationLabel;

@property (nonatomic, unsafe_unretained) IBOutlet UIDatePicker *datePicker;

- (void)selectRow:(id)sender;
- (IBAction)dateSelected:(id)sender;

@property (nonatomic, strong) WDLabel *selectedLabel;

- (void)cancel;
- (void)save;

@end

@implementation WDEditDayViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.startTitleLabel.text = NSLocalizedString(@"Start:", @"");
    self.endTitleLabel.text = NSLocalizedString(@"End:", @"");
    self.durationTitleLabel.text = NSLocalizedString(@"Duration:", @"");
    
    if (self.day)
    {
        self.startDateLabel.text = [self.day startDateAsStringWithFullFormat:YES];
        self.endDateLabel.text = [self.day endDateAsStringWithFullFormat:YES];
        self.durationLabel.text = self.day.durationAsString;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectRow:)];
    [self.startDateView addGestureRecognizer:tap];
    [self.endDateView addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)selectRow:(id)sender
{
    if (((UITapGestureRecognizer *)sender).view == self.startDateView)
    {
        self.selectedLabel = self.startDateLabel;
        self.datePicker.date = self.day.startDate;
    } else
    {
        self.selectedLabel = self.endDateLabel;
        self.datePicker.date = self.day.endDate;
    }
}

- (IBAction)dateSelected:(id)sender
{
    NSDate *selectedDate = ((UIDatePicker *)sender).date;
    
    if (self.selectedLabel == self.startDateLabel)
    {
        self.day.startDate = selectedDate;
        self.selectedLabel.text = [self.day startDateAsStringWithFullFormat:YES];
    } else
    {
        self.day.endDate = selectedDate;
        self.selectedLabel.text = [self.day endDateAsStringWithFullFormat:YES];
    }
    
    self.durationLabel.text = self.day.durationAsString;
}

#pragma mark - Private methods

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)save
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
