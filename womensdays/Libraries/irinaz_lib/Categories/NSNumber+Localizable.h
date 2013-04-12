//
//  NSNumber+Localizable.h
//  carlsberg
//
//  Created by Ирина Завилкина on 28.02.13.
//  Copyright (c) 2013 Ирина Завилкина. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Localizable)

- (NSString *)stringValueWithVariants:(NSArray *)variants;
- (NSString *)stringValueWithLocalizablingVariants:(NSArray *)variants;

@end
