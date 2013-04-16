//
//  WDLabel.m
//  womensdays
//
//  Created by Ирина Завилкина on 12.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDLabel.h"

@implementation WDLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.textColor = [UIColor whiteColor];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.textColor = [UIColor whiteColor];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
