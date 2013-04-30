//
//  UIViewController+PopupViewController.h
//  MJModalViewController
//
//  Created by Martin Juhasz on 11.05.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PopupViewController)

@property (nonatomic, readonly) BOOL popupViewIsActive;

- (void)presentPopupViewController:(UIViewController*)popupViewController fromPoint:(CGPoint)point;
- (void)presentPopupViewController:(UIViewController*)popupViewController;
- (void)dismissPopupViewController;
- (UIView *)topView;

@end