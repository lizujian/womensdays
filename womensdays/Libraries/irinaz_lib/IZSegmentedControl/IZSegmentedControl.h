//
//  FFSegmentedControl.h
//  flowerfactory
//
//  Created by Irina Zavilkina on 26.09.12.
//  Copyright (c) 2012 Irina Zavilkina. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IZSegmentedControlStyle) {
    IZSegmentedControlStyleRounded = 1,
    IZSegmentedControlStyleAngular,
    IZSegmentedControlStyleSimple
};

@class IZSegmentedControl;

@protocol IZSegmentedControlDelegate <NSObject>

@optional

-(void)segmentedControl:(IZSegmentedControl *)segmentedControl didSelectedItem:(NSUInteger)item;

@end

@interface IZSegmentedControl : UIView

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, assign) IBOutlet id <IZSegmentedControlDelegate> delegate;

- (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state;
- (void)setShadowColor:(UIColor *)shadowColor forState:(UIControlState)state;
- (void)setShadowOffset:(CGSize)shadowOffset forState:(UIControlState)state;
- (void)setTitles:(NSArray *)titles withStyle:(IZSegmentedControlStyle)style;
- (void)setImages:(NSArray *)images selectionImages:(NSArray *)selectionImages withStyle:(IZSegmentedControlStyle)style;

- (NSString *)titleForItem:(NSInteger)itemIndex;

@end
