//
//  WDMainViewController.m
//  womensdays
//
//  Created by Ирина Завилкина on 12.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDMainViewController.h"

#import "WDGrayButton.h"

#import "WDDay.h"

@interface WDMainViewController ()

@property (nonatomic, unsafe_unretained) IBOutlet UIView *weatherView;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *weatherLabel;

@property (nonatomic, unsafe_unretained) IBOutlet UIView *mainView;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *remainsTitleLabel;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *passedTitleLabel;

@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *addTitleLabel;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *addSexButton;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *addDateButton;

@property (nonatomic, unsafe_unretained) IBOutlet UIView *datePickerView;
@property (nonatomic, unsafe_unretained) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, unsafe_unretained) IBOutlet WDGrayButton *cancelButton;
@property (nonatomic, unsafe_unretained) IBOutlet WDGrayButton *saveButton;

- (IBAction)addSex:(id)sender;
- (IBAction)addDate:(id)sender;

@property (nonatomic, strong) NSArray *allDays;

- (void)hideDatePicker:(BOOL)hide;

@end

@implementation WDMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Main", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"tabicon_calendar"];
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    
    self.weatherLabel.text = NSLocalizedString(@"Write down the last few months the cycle in the calendar to get the weather", @"");
    self.remainsTitleLabel.text = NSLocalizedString(@"Remains", @"");
    self.passedTitleLabel.text = NSLocalizedString(@"Passed since the last cycle", @"");
    self.addTitleLabel.text = NSLocalizedString(@"Add", @"");
    
    [self.addSexButton setTitle:NSLocalizedString(@"Sex", @"") forState:UIControlStateNormal];
    [self.addDateButton setTitle:NSLocalizedString(@"Started", @"") forState:UIControlStateNormal];
    
    [self.cancelButton setTitle:NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
    [self.saveButton setTitle:NSLocalizedString(@"Save", @"") forState:UIControlStateNormal];
    
    CGRect datePickerFrame = self.datePicker.frame;
    datePickerFrame.size.height = 162;
    datePickerFrame.origin.y = self.datePickerView.frame.size.height - datePickerFrame.size.height;
    self.datePicker.frame = datePickerFrame;
    self.datePicker.date = [NSDate date];
}

- (void)viewWillAppear:(BOOL)animated
{
    CGRect datePickerFrame = self.datePickerView.frame;
    datePickerFrame.origin.y = self.view.frame.size.height;
    self.datePickerView.frame = datePickerFrame;

    [super viewWillAppear:animated];
        
    self.allDays = [WDDay allDays];

    NSUInteger daysCount = self.allDays.count;
    self.mainView.hidden = daysCount == 0;
    self.weatherView.hidden = daysCount != 0;
}

#pragma mark - Actions

- (IBAction)addSex:(id)sender
{
    self.addTitleLabel.text = NSLocalizedString(@"Add sex", @"");
    
    [self hideDatePicker:NO];
}

- (IBAction)addDate:(id)sender
{
    self.addTitleLabel.text = NSLocalizedString(@"Started", @"");    
    
    [self hideDatePicker:NO];
}

#pragma mark - Private methods

- (void)hideDatePicker:(BOOL)hide
{
    CGRect datePickerFrame = self.datePickerView.frame;
    datePickerFrame.origin.y = hide ? self.view.frame.size.height : self.view.frame.size.height - datePickerFrame.size.height;

    [UIView animateWithDuration:.3 animations:^
    {
        self.datePickerView.frame = datePickerFrame;
    } completion:^(BOOL finished)
    {
        if (hide)
        {
            self.addTitleLabel.text = NSLocalizedString(@"Add", @"");

            [self.view removeGestureRecognizer:[self.view.gestureRecognizers lastObject]];
        } else
        {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDatePicker:)];
            [self.view addGestureRecognizer:tap];
        }
    }];
}

@end
