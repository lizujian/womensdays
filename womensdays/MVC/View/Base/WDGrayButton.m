//
//  WDGrayButton.m
//  womensdays
//
//  Created by Ирина Завилкина on 16.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDGrayButton.h"

@interface WDGrayButton ()

- (void)custom;

@end

@implementation WDGrayButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self custom];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self custom];
    }
    
    return self;
}

#pragma mark - Private methods

- (void)custom
{
    self.adjustsImageWhenDisabled = NO;
    self.adjustsImageWhenHighlighted = NO;
    
    self.clipsToBounds = YES;

    UIColor *titleColor = [UIColor colorWithRed:0.620 green:0.298 blue:0.298 alpha:1.];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateHighlighted];
    [self setTitleColor:titleColor forState:UIControlStateSelected];
    
    [self setStretchableBackgroundImage:[UIImage imageNamed:@"gray_button"] forState:UIControlStateNormal];
    [self setStretchableBackgroundImage:[UIImage imageNamed:@"gray_button_pressed"] forState:UIControlStateHighlighted];
    [self setStretchableBackgroundImage:[UIImage imageNamed:@"gray_button_pressed"] forState:UIControlStateSelected];
}

@end
