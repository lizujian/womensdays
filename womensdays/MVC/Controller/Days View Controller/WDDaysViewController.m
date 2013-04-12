//
//  WDDaysViewController.m
//  womensdays
//
//  Created by Ирина Завилкина on 12.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDDaysViewController.h"

#import "WDTableView.h"
#import "WDDayCell.h"

@interface WDDaysViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, unsafe_unretained) IBOutlet UIView *tableContainer;
@property (nonatomic, unsafe_unretained) IBOutlet WDTableView *tableView;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *startTitleLabel;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *durationTitleLabel;
@property (nonatomic, unsafe_unretained) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, strong) NSArray *daysList;

- (void)addDay;

@end

@implementation WDDaysViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Days", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"tabicon_list"];
        
        self.daysList = [WDDay allDays];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.startTitleLabel.text = NSLocalizedString(@"Start", @"");
    self.durationTitleLabel.text = NSLocalizedString(@"Dur.", @"");
    
    self.tableContainer.hidden = self.daysList.count == 0;
    
    self.navigationItem.leftBarButtonItem = [self editButtonItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Add", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(addDay)];

    CGRect datePickerFrame = self.datePicker.frame;
    datePickerFrame.origin.y = self.view.frame.size.height;
    self.datePicker.frame = datePickerFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setters

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:YES];
}

#pragma mark - Private methods

- (void)addDay
{
    
}

#pragma mark - Table View Delegate & Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.daysList.count;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell setHighlighted:YES animated:YES];
//    
//    SNTIMViewController *aTIMViewController = [[SNTIMViewController alloc] initWithNibName:@"SNTIMViewController" bundle:nil];
//    aTIMViewController.aTIM = [self.aTIMList objectAtIndex:indexPath.row % self.aTIMList.count];
//    
//    [self.navigationController pushViewController:aTIMViewController animated:YES];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DayCell";
    WDDayCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WDDayCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    WDDay *day = [self.daysList objectAtIndex:indexPath.row];
    cell.day = day;
    
    return cell;
}

@end
