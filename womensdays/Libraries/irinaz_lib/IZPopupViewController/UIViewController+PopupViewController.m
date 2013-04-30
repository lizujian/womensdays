//
//  UIViewController+PopupViewController.m
//  MJModalViewController
//
//  Created by Martin Juhasz on 11.05.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "UIViewController+PopupViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kPopupModalAnimationDuration 0.35
#define kMJSourceViewTag 23941
#define kMJPopupViewTag 23942
#define kMJBackgroundViewTag 23943
#define kMJOverlayViewTag 23945

#pragma mark -
#pragma mark Public

@implementation UIViewController (PopupViewController)

- (void)presentPopupViewController:(UIViewController*)popupViewController fromPoint:(CGPoint)point
{
    [self presentPopoverFromPoint:point inView:popupViewController.view];
}

- (void)presentPopupViewController:(UIViewController *)popupViewController
{
    [self presentPopoverInView:popupViewController.view];
}

- (void)dismissPopupViewController
{
    UIView *sourceView = [self topView];
    UIView *popupView = [sourceView viewWithTag:kMJPopupViewTag];
    UIView *overlayView = [sourceView viewWithTag:kMJOverlayViewTag];
    
    [overlayView removeGestureRecognizer:[overlayView.gestureRecognizers lastObject]];

    if ([self respondsToSelector:@selector(popoverViewDidDismiss:)]) {
        [self performSelector:@selector(popoverViewDidDismiss:) withObject:popupView];
    }
   
    [self fadeViewOut:popupView sourceView:sourceView overlayView:overlayView];
}

#pragma mark -
#pragma mark View Handling

- (void)presentPopoverFromPoint:(CGPoint)point inView:(UIView*)popupView
{
    UIView *sourceView = [self topView];
    sourceView.tag = kMJSourceViewTag;
    popupView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    popupView.tag = kMJPopupViewTag;
    popupView.frame = CGRectMake(0.0, 0.0, popupView.frame.size.width, popupView.frame.size.height);
    
    // check if source view controller is not in destination
    if ([sourceView.subviews containsObject:popupView]) return;
    
    // Add semi overlay
    UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
    overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlayView.tag = kMJOverlayViewTag;
    overlayView.backgroundColor = [UIColor clearColor];
    
    // BackgroundView
    UIImage *backgroundImage = [UIImage imageNamed:@"popover_background"];
    CGSize halfImageSize = CGSizeMake(backgroundImage.size.width / 2, backgroundImage.size.height / 2);
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(halfImageSize.height, halfImageSize.width, halfImageSize.height, halfImageSize.width)]];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [backgroundView setFrame:popupView.frame];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.tag = kMJBackgroundViewTag;
    [overlayView addSubview:backgroundView];

    // Make the Background Clickable
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopupViewController)];
    [overlayView addGestureRecognizer:tap];

    // Check if background arrow is necessary
    UIImage *arrowImage = [UIImage imageNamed:@"popover_arrow"];
    UIImageView *backgroundArrow = [[UIImageView alloc] initWithImage:arrowImage];
    
    point.x -= arrowImage.size.width / 2;

    if(point.y > backgroundView.frame.origin.y + backgroundView.frame.size.height)
    {
        backgroundArrow.frame = CGRectMake(point.x, backgroundView.frame.size.height - 17.0, arrowImage.size.width, arrowImage.size.height);
        backgroundArrow.transform = CGAffineTransformMakeRotation(M_PI);
    }
    else
        backgroundArrow.frame = CGRectMake(point.x, 1.0, arrowImage.size.width, arrowImage.size.height);
    [backgroundView addSubview:backgroundArrow];
    
    popupView.alpha = 0.0f;
    [overlayView addSubview:popupView];
    [sourceView addSubview:overlayView];

    [self fadeFromRect:CGRectMake(point.x, point.y, 0, 0) inView:popupView sourceView:sourceView overlayView:overlayView];
}

- (void)presentPopoverInView:(UIView*)popupView
{
    UIView *sourceView = [self topView];
    sourceView.tag = kMJSourceViewTag;
    popupView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    popupView.tag = kMJPopupViewTag;

    // check if source view controller is not in destination
    if ([sourceView.subviews containsObject:popupView]) return;

    // Add semi overlay
    UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
    overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlayView.tag = kMJOverlayViewTag;
    overlayView.backgroundColor = [UIColor clearColor];

    // BackgroundView
    UIImage *backgroundImage = [UIImage imageNamed:@"popover_background"];
    CGSize halfImageSize = CGSizeMake(backgroundImage.size.width / 2, backgroundImage.size.height / 2);
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(halfImageSize.height, halfImageSize.width, halfImageSize.height, halfImageSize.width)]];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [backgroundView setFrame:popupView.frame];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.tag = kMJBackgroundViewTag;
    [overlayView addSubview:backgroundView];

    // Make the Background Clickable
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopupViewController)];
    [overlayView addGestureRecognizer:tap];

    popupView.alpha = 0.0f;
    [overlayView addSubview:popupView];
    [sourceView addSubview:overlayView];
    
    [self fadeViewIn:popupView sourceView:sourceView overlayView:overlayView];
}

- (UIView *)topView
{
    UIViewController *recentView = self;
    
//    while (recentView.parentViewController != nil) {
//        recentView = recentView.parentViewController;
//    }

    return recentView.view;
}

#pragma mark - Fade Animation

- (void)fadeFromRect:(CGRect)rect inView:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    [[self controllerForView:popupView] viewWillAppear:YES];
    
    UIView *backgroundView = [overlayView viewWithTag:kMJBackgroundViewTag];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    
    CGFloat originY = (rect.origin.y < sourceSize.height - popupSize.height) ? rect.origin.y + 11.0: rect.origin.y - popupSize.height;
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     originY,
                                     popupSize.width,
                                     popupSize.height);
    
    // Set starting properties
    backgroundView.frame = popupEndRect;
    popupView.frame = popupEndRect;
    popupView.alpha = 0.0f;

    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        backgroundView.alpha = 1.0f;
        popupView.alpha = 1.0f;
        overlayView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    } completion:^(BOOL finished) {
    }];
}

- (void)fadeViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    [[self controllerForView:popupView] viewWillAppear:YES];

    UIView *backgroundView = [overlayView viewWithTag:kMJBackgroundViewTag];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2 - 12.0,
                                     popupSize.width, 
                                     popupSize.height);
    
    // Set starting properties
    backgroundView.frame = popupEndRect;
    popupView.frame = popupEndRect;
    popupView.alpha = 0.0f;
    
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        backgroundView.alpha = 1.0f;
        popupView.alpha = 1.0f;
        overlayView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    } completion:^(BOOL finished) {
    }];
}

- (void)fadeViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    UIView *backgroundView = [overlayView viewWithTag:kMJBackgroundViewTag];
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^
    {
        backgroundView.alpha = 0.0f;
        popupView.alpha = 0.0f;
        overlayView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished)
    {
        UIView *popupView = [overlayView viewWithTag:kMJPopupViewTag];
        [[self controllerForView:popupView] viewWillDisappear:YES];

        [backgroundView removeFromSuperview];
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
    }];
}

- (UIViewController*)controllerForView:(UIView *)view
{
    for (UIView* next = view; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    
    return nil;
}

#pragma mark - Getters

- (BOOL)popupViewIsActive
{
    UIView *sourceView = [self topView];
    UIView *popupView = [sourceView viewWithTag:kMJPopupViewTag];

    return (popupView != nil);
}

@end
