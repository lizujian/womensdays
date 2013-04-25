//
//  NSArray+MojoModel.m
//  naturino
//
//  Created by Ирина Завилкина on 24.04.13.
//  Copyright (c) 2013 Traffic. All rights reserved.
//

#import "NSArray+MojoModel.h"
#import "MojoModel.h"

@implementation NSArray (MojoModel)

- (BOOL)containsMojoObject:(id)object
{
    if (![object isKindOfClass:[MojoModel class]])
        return NO;
    
    NSUInteger objectID = [(MojoModel *)object primaryKey];
    
    for (id subObject in self)
    {
        NSUInteger secondID = [(MojoModel *)subObject primaryKey];
        if (objectID == secondID)
            return YES;
    }
    
    return NO;
}

@end
