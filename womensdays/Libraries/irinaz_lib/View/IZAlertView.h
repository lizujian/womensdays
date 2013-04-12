//
//  IZAlertView.h
//  carlsberg
//
//  Created by Ирина Завилкина on 22.03.13.
//  Copyright (c) 2013 Ирина Завилкина. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IZAlertView : UIAlertView

- (id)initInternetConnectionError;
- (id)initLocationNotDeniedError;
- (id)initWithMessage:(NSString *)message;
- (id)initWithTitle:(NSString *)title message:(NSString *)message;
- (id)initQuestionWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate;

@end
