//
//  WDDayCell.m
//  womensdays
//
//  Created by Ирина Завилкина on 12.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDDayCell.h"

@interface WDDayCell ()

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;

@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *startDateLabel;
@property (nonatomic, unsafe_unretained) IBOutlet WDLabel *durationLabel;

@end

@implementation WDDayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Setters

- (void)setDay:(WDDay *)day
{
    self.startDateLabel.text = day.startDateAsString;
    self.durationLabel.text = @(day.duration).stringValue;
    
    _day = day;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
