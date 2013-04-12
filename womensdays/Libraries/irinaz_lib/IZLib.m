//
//  TRIZLib.m
//  carlsberg
//
//  Created by Ирина Завилкина on 22.03.13.
//  Copyright (c) 2013 Ирина Завилкина. All rights reserved.
//

#import "IZLib.h"



@implementation IZLib

+ (NSError *)validateEmail:(NSString *)email
{
    NSError *error = nil;
    
    if (!email || [email isEqualToString:@""])
        error = [NSError errorWithDomain:kErrorDomain code:kErrorRegInfoFailedCode userInfo:[NSDictionary dictionaryWithObject:NSLocalizedString(kIZLibRegInfoErrorEmptyEmail, @"") forKey:NSLocalizedDescriptionKey]];
    else {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        
        if (![emailTest evaluateWithObject:email])
            error = [NSError errorWithDomain:kErrorDomain code:kErrorRegInfoFailedCode userInfo:[NSDictionary dictionaryWithObject:NSLocalizedString(kIZLibRegInfoErrorIncorrectEmail, @"") forKey:NSLocalizedDescriptionKey]];
    }

    return error;
}

@end
