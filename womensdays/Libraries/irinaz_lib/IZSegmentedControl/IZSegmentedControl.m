//
//  FFSegmentedControl.m
//  flowerfactory
//
//  Created by Irina Zavilkina on 26.09.12.
//  Copyright (c) 2012 Irina Zavilkina. All rights reserved.
//

#import "IZSegmentedControl.h"

@interface IZSegmentedControl ()

@property (nonatomic, retain) NSArray *titles;
@property (nonatomic, assign) CGFloat screenScale;
@property (nonatomic, assign) IZSegmentedControlStyle style;
@property (nonatomic, assign) NSUInteger itemsCount;
@property (nonatomic, assign) UIButton *selectedButton;

@property (nonatomic, strong) NSMutableDictionary *textColors;
@property (nonatomic, strong) NSMutableDictionary *shadowColors;
@property (nonatomic, strong) NSMutableDictionary *shadowOffsets;

- (void)customize;
- (UIButton *)buttonForIndex:(NSUInteger)index;
- (void)tapped:(id)sender;

@end

@implementation IZSegmentedControl

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customize];
    }
    return self;
}

- (void)setFont:(UIFont *)font
{
    for (UIButton *button in self.subviews) {
        [button.titleLabel setFont:font];
    }
    
    _font = font;
}

- (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state
{
    for (UIButton *button in self.subviews) {
        [button setTitleColor:textColor forState:state];
    }
    
    [self.textColors setObject:textColor forKey:@(state)];
}

- (void)setShadowColor:(UIColor *)shadowColor forState:(UIControlState)state
{
    if (state == UIControlStateNormal)
        for (UIButton *button in self.subviews) {
            [button setTitleShadowColor:shadowColor forState:state];
        }

    [self.shadowColors setObject:shadowColor forKey:@(state)];
}

- (void)setShadowOffset:(CGSize)shadowOffset forState:(UIControlState)state
{
    if (state == UIControlStateNormal)
        for (UIButton *button in self.subviews) {
            [button.titleLabel setShadowOffset:shadowOffset];
        }
    
    [self.shadowOffsets setObject:[NSValue valueWithCGSize:shadowOffset] forKey:@(state)];
}

- (void)setTitles:(NSArray *)titles withStyle:(IZSegmentedControlStyle)style
{
    self.itemsCount = [titles count];
    
    if (self.itemsCount == 0)
        return;
    
    self.titles = titles;
    self.style = style;
    
    for (int i = 0; i < [titles count]; i++)
    {
        UIButton *button = [self buttonForIndex:i];

        NSString *title = [titles objectAtIndex:i];
        [button setTitle:title forState:UIControlStateNormal];
        
        [button setTitleShadowColor:[self.shadowColors objectForKey:@(UIControlStateNormal)] forState:UIControlStateNormal];
        [button setTitleShadowColor:[self.shadowColors objectForKey:@(UIControlStateHighlighted)] forState:UIControlStateHighlighted];
        [button setTitleShadowColor:[self.shadowColors objectForKey:@(UIControlStateSelected)] forState:UIControlStateSelected];
        
        [button setTitleColor:[self.textColors objectForKey:@(UIControlStateNormal)] forState:UIControlStateNormal];
        [button setTitleColor:[self.textColors objectForKey:@(UIControlStateHighlighted)] forState:UIControlStateHighlighted];
        [button setTitleColor:[self.textColors objectForKey:@(UIControlStateSelected)] forState:UIControlStateSelected];
        
        CGSize offset = [[self.shadowOffsets objectForKey:@(UIControlStateNormal)] CGSizeValue];
        [button.titleLabel setShadowOffset:offset];

        [button.titleLabel setFont:self.font];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    
    self.selectedIndex = 0;
}

- (void)setImages:(NSArray *)images selectionImages:(NSArray *)selectionImages withStyle:(IZSegmentedControlStyle)style
{
    self.itemsCount = [images count];
    
    if (self.itemsCount == 0)
        return;

    self.style = style;
        
    for (int i = 0; i < [images count]; i++)
    {
        UIButton *button = [self buttonForIndex:i];

        [button setImage:[images objectAtIndex:i] forState:UIControlStateNormal];
        [button setImage:[selectionImages objectAtIndex:i] forState:UIControlStateSelected];
    }
    
    self.selectedIndex = 0;
}

#pragma mark - Setters

- (void)setEnabled:(BOOL)enabled
{
    for (UIButton *item in self.subviews) {
        [item setEnabled:enabled];
    }
    
    _enabled = enabled;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    self.selectedButton = [self.subviews objectAtIndex:selectedIndex];
}

- (void)setSelectedButton:(UIButton *)selectedButton
{
    if (self.selectedButton)
    {
        CGSize normalOffset = [[self.shadowOffsets objectForKey:@(UIControlStateNormal)] CGSizeValue];
        self.selectedButton.titleLabel.shadowOffset = normalOffset;
        self.selectedButton.selected = NO;
    }
    
    CGSize selectedOffset = [[self.shadowOffsets objectForKey:@(UIControlStateSelected)] CGSizeValue];
    selectedButton.titleLabel.shadowOffset = selectedOffset;
    selectedButton.selected = YES;

    _selectedButton = selectedButton;
    _selectedIndex = [self.subviews indexOfObject:selectedButton];
}

#pragma mark - Private methods

- (void)customize
{
    self.backgroundColor = [UIColor clearColor];
    self.screenScale = [[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.;

    self.textColors = [NSMutableDictionary dictionaryWithDictionary:@{
                       @(UIControlStateNormal) : [UIColor whiteColor],
                       @(UIControlStateHighlighted) : [UIColor blackColor],
                       @(UIControlStateSelected) : [UIColor blackColor]
                       }];
    self.shadowColors = [NSMutableDictionary dictionaryWithDictionary:@{
                         @(UIControlStateNormal) : [UIColor blackColor],
                         @(UIControlStateHighlighted) : [UIColor whiteColor],
                         @(UIControlStateSelected) : [UIColor whiteColor]
                         }];
    self.shadowOffsets = [NSMutableDictionary dictionaryWithDictionary:@{
                          @(UIControlStateNormal) : [NSValue valueWithCGSize:CGSizeMake(0, -1)],
                          @(UIControlStateHighlighted) : [NSValue valueWithCGSize:CGSizeMake(0, -1)],
                          @(UIControlStateSelected) : [NSValue valueWithCGSize:CGSizeMake(0, -1)]
                          }];
}

- (UIButton *)buttonForIndex:(NSUInteger)index
{
    CGFloat itemWidth = self.frame.size.width / self.itemsCount;
    CGFloat itemHeight = self.frame.size.height;
    CGFloat originX = itemWidth * index;
        
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(originX, 0., itemWidth, itemHeight)];
    
    button.adjustsImageWhenHighlighted = NO;
    
    NSString *imagePostfix = @"";
    if (self.style != IZSegmentedControlStyleSimple)
        imagePostfix = (index == 0 ? @"_left" : (index == self.itemsCount - 1 ? @"_right" : @"_middle"));
        
    switch (self.style) {
        case IZSegmentedControlStyleRounded: {
            UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"segmented_rounded%@", imagePostfix]];
            CGSize halfSize = CGSizeMake(normalImage.size.width / 2, normalImage.size.height);
            normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(halfSize.height, halfSize.width, halfSize.height, halfSize.width)];
            [button setBackgroundImage:normalImage forState:UIControlStateNormal];
            [button setBackgroundImage:normalImage forState:UIControlStateHighlighted];
            
            UIImage *highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"segmented_rounded%@_pressed", imagePostfix]];
            [button setBackgroundImage:[highlightedImage resizableImageWithCapInsets:UIEdgeInsetsMake(halfSize.height, halfSize.width, halfSize.height, halfSize.width)] forState:UIControlStateSelected];
        }
            break;
            
        case IZSegmentedControlStyleAngular: {
            CGRect buttonFrame = button.frame;
            if (index > 0 && index < self.itemsCount - 1) {
                buttonFrame.origin.x -= index == 1 ? 11. * self.screenScale : 5.5 * self.screenScale;
                buttonFrame.size.width += 16.5 * self.screenScale;
            }
            button.frame = buttonFrame;
            
            UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"segmented_angular%@", imagePostfix]];
            CGSize halfSize = CGSizeMake(normalImage.size.width / 2, normalImage.size.height);
            normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(halfSize.height, halfSize.width, halfSize.height, halfSize.width)];
            [button setBackgroundImage:normalImage forState:UIControlStateNormal];
            [button setBackgroundImage:normalImage forState:UIControlStateHighlighted];
            
            UIImage *highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"segmented_angular%@_pressed", imagePostfix]];
            [button setBackgroundImage:[highlightedImage resizableImageWithCapInsets:UIEdgeInsetsMake(halfSize.height, halfSize.width, halfSize.height, halfSize.width)] forState:UIControlStateSelected];
            
            if (index == 0)
                button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 11. * self.screenScale);
            else if (index == self.itemsCount - 1)
                button.contentEdgeInsets = UIEdgeInsetsMake(0, 11. * self.screenScale, 0, 0);
        }
            break;
        case IZSegmentedControlStyleSimple: {
            UIImage *normalImage = [UIImage imageNamed:@"segmented_simple"];
            CGSize halfSize = CGSizeMake(normalImage.size.width / 2, normalImage.size.height / 2.);
            normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(halfSize.height, halfSize.width, halfSize.height, halfSize.width)];
            [button setBackgroundImage:normalImage forState:UIControlStateNormal];
            [button setBackgroundImage:normalImage forState:UIControlStateHighlighted];

            UIImage *highlightedImage = [UIImage imageNamed:@"segmented_simple_pressed"];
            [button setBackgroundImage:[highlightedImage resizableImageWithCapInsets:UIEdgeInsetsMake(halfSize.height, halfSize.width, halfSize.height, halfSize.width)] forState:UIControlStateSelected];
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        default:
            break;
    }
    
    [button addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    
    return button;
}

- (void)tapped:(id)sender
{
    if (self.selectedButton == sender)
        return;
    
    self.selectedButton = sender;
    
    if ([self.delegate respondsToSelector:@selector(segmentedControl:didSelectedItem:)])
        [self.delegate segmentedControl:self didSelectedItem:self.selectedIndex];
}

#pragma mark - Public methods

- (NSString *)titleForItem:(NSInteger)itemIndex
{
    return [self.titles objectAtIndex:itemIndex];
}

@end
