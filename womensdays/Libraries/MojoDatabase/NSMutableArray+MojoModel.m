//
//  NSMutableArray+MojoModel.m
//  naturino
//
//  Created by Ирина Завилкина on 23.04.13.
//  Copyright (c) 2013 Traffic. All rights reserved.
//

#import "NSMutableArray+MojoModel.h"

#import "MojoModel.h"

@implementation NSMutableArray (MojoModel)

@dynamic owner;

+ (id)arrayWithArray:(NSArray *)array owner:(MojoModel *)owner
{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:array];
    [newArray setValue:owner forKey:@"owner"];
    
    return newArray;
}

- (BOOL)containsMojoObject:(id)anObject
{
    if (![anObject isKindOfClass:[MojoModel class]])
        return NO;
    
    NSUInteger anObjectID = [(MojoModel *)anObject primaryKey];
    
    for (id object in self) {
        if ([object isKindOfClass:[anObject class]])
        {
            NSUInteger secondID = [(MojoModel *)object primaryKey];
            if (anObjectID == secondID)
                return YES;
        }
    }
    
    return NO;
}

-(BOOL)deleteMojoObject:(MojoModel *)object
{
    return [self deleteMojoObject:object onlyRelashion:NO];
}

-(BOOL)deleteAllMojoObjects
{
    return [self deleteAllMojoObjectsOnlyRelashion:NO];
}

-(BOOL)deleteMojoObject:(MojoModel *)object onlyRelashion:(BOOL)onlyRelashion
{
    if (!self.owner)
        return NO;
    
    if (onlyRelashion ? [object deleteForeignKeyOf:self.owner] : [object delete])
    {
        [self removeObject:object];
        return YES;
    } else
        return NO;
}

-(BOOL)deleteAllMojoObjectsOnlyRelashion:(BOOL)onlyRelashion
{
    if (!self.owner)
        return NO;

    BOOL result = YES;
    
    for (id object in self)
    {
        if ([object isKindOfClass:[MojoModel class]])
            result &= [self deleteMojoObject:object onlyRelashion:onlyRelashion];
    }
    
    return result;
}

-(BOOL)addMojoObject:(MojoModel *)object
{
    return [object save] && [object addForeignKeyOf:self.owner];
}

-(BOOL)addMojoObjects:(NSArray *)objects
{
    BOOL result = YES;
    
    for (id object in self)
    {
        if ([object isKindOfClass:[MojoModel class]])
            result &= [self addMojoObject:object];
    }
    
    return result;
}

@end
