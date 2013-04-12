//
//  NSNumber+Localizable.m
//  carlsberg
//
//  Created by Ирина Завилкина on 28.02.13.
//  Copyright (c) 2013 Ирина Завилкина. All rights reserved.
//

#import "NSNumber+Localizable.h"

@implementation NSNumber (Localizable)

- (NSString *)stringValueWithVariants:(NSArray *)variants
{
    NSString *aStringValue = @"";
    
    if (!variants || variants.count == 0)
        return self.stringValue;
    else if (variants.count < 3)
        aStringValue = [variants objectAtIndex:0];
    else {
        if (self.intValue % 10 >= 2 && self.intValue <= 4)
            aStringValue = [variants objectAtIndex:1];
        else if (self.intValue % 10 == 1)
            aStringValue = [variants objectAtIndex:0];
        else
            aStringValue = [variants objectAtIndex:2];
    }
    
    return aStringValue;
}

- (NSString *)stringValueWithLocalizablingVariants:(NSArray *)variants
{
    NSMutableArray *localizablingVariants = [variants mutableCopy];
    NSUInteger count = localizablingVariants.count;
    
    for (int i = 0; i < count; i++) {
        NSString *string = [localizablingVariants objectAtIndex:i];
        [localizablingVariants replaceObjectAtIndex:i withObject:NSLocalizedString(string, @"")];
    }
    
    return [self stringValueWithVariants:localizablingVariants];
}

@end
