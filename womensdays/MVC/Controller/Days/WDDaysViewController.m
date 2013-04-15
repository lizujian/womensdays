//
//  WDDaysViewController.m
//  womensdays
//
//  Created by Ирина Завилкина on 12.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDDaysViewController.h"
#import "WDEditDayViewController.h"

#import "WDTableView.h"
#import "WDDayCell.h"

#import "WDAppDelegate.h"

@interface WDDaysViewController () <UITableViewDelegate, UITableViewDataSource, WDEditDayViewControllerDelegate>

@property (nonatomic, unsafe_unretained) IBOutlet UIView *tableContainer;
@property (nonatomic, unsafe_unretained) IBOutlet WDTableView *tableView;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *startTitleLabel;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *durationTitleLabel;

@property (nonatomic, strong) NSMutableArray *daysList;

- (void)reloadTableData;
- (void)addDay;
- (void)editDay:(WDDay *)day;

@end

@implementation WDDaysViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Days", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"tabicon_list"];
        
        [self reloadTableData];
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDay)];
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

- (void)reloadTableData
{
    self.daysList = [[WDDay allDays] mutableCopy];

    [self.tableView reloadData];
}

- (void)addDay
{
    WDDay *newDay = [WDDay createEntity];
    newDay.startDate = [NSDate date];
    newDay.endDate = [NSDate dateWithTimeIntervalSinceNow:432000];
    
    [self editDay:newDay];
}

- (void)editDay:(WDDay *)day
{
    WDEditDayViewController *editDayViewController = [[WDEditDayViewController alloc] initWithNibName:@"WDEditDayViewController" bundle:nil];
    editDayViewController.day = day;
    editDayViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:editDayViewController];
    
    [self presentViewController:navController animated:YES completion:^{}];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.tableView beginUpdates];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        WDDay *deletingDay = [self.daysList objectAtIndex:indexPath.row];
        [deletingDay deleteEntity];
        if ([(WDAppDelegate *)[UIApplication sharedApplication].delegate saveContext])
            [self.daysList removeObject:deletingDay];
        
        [self.tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self editDay:[self.daysList objectAtIndex:indexPath.row]];
}

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

#pragma mark - Edit Day View Controller Delegate

- (void)editDayViewControllerDidSaveChanges
{
    [self reloadTableData];
}

@end
