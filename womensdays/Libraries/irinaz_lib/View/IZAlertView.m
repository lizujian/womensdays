//
//  IZAlertView.m
//  carlsberg
//
//  Created by Ирина Завилкина on 22.03.13.
//  Copyright (c) 2013 Ирина Завилкина. All rights reserved.
//

#import "IZAlertView.h"

#import "IZLib.h"

@implementation IZAlertView

- (id)initInternetConnectionError
{
    self = [super initWithTitle:NSLocalizedString(kIZLibAlertViewDefaultTitle, @"") message:NSLocalizedString(kIZLibAlertViewInternetConnectionErrorString, @"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    return self;
}

- (id)initLocationNotDeniedError
{
    self = [super initWithTitle:NSLocalizedString(kIZLibAlertViewDefaultTitle, @"") message:NSLocalizedString(kIZLibAlertViewLocationNotDeniedErrorString, @"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    return self;
}

- (id)initWithMessage:(NSString *)message
{
    self = [super initWithTitle:NSLocalizedString(kIZLibAlertViewDefaultTitle, @"") message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [super initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    return self;
}

- (id)initQuestionWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate
{
    self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:NSLocalizedString(@"No", @"") otherButtonTitles:NSLocalizedString(@"Yes", @""), nil];
    
    return self;
}

@end
