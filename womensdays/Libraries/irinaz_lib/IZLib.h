//
//  TRIZLib.h
//  carlsberg
//
//  Created by Ирина Завилкина on 22.03.13.
//  Copyright (c) 2013 Ирина Завилкина. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSTimer+Blocks.h"
#import "UIImageView+Stretchable.h"
#import "NSNumber+Localizable.h"

#ifndef kErrorRegInfoFailedCode
#define kErrorRegInfoFailedCode                         100
#endif

#ifndef kErrorDomain
#define kErrorDomain                                    kWomensDaysErrorDomain
#endif

#define kIZLibRegInfoErrorEmptyEmail                    @"kIZLibRegInfoErrorEmptyEmail"
#define kIZLibRegInfoErrorIncorrectEmail                @"kIZLibRegInfoErrorIncorrectEmail"

#define kIZLibAlertViewDefaultTitle                     @"kIZLibAlertViewDefaultTitle"
#define kIZLibAlertViewInternetConnectionErrorString    @"kIZLibAlertViewInternetConnectionErrorString"
#define kIZLibAlertViewLocationNotDeniedErrorString     @"kIZLibAlertViewLocationNotDeniedErrorString"

@interface IZLib : NSObject

+ (NSError *)validateEmail:(NSString *)email;

@end
