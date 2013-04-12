//
//  UIButton+Stretchable.m
//  carlsberg
//
//  Created by Ирина Завилкина on 28.02.13.
//  Copyright (c) 2013 Ирина Завилкина. All rights reserved.
//

#import "UIButton+Stretchable.h"

@implementation UIButton (Stretchable)

- (void)setStretchableBackgroundImage:(UIImage *)image forState:(UIControlState)state
{
    CGSize imageHalfSize = CGSizeMake(image.size.width * .5, image.size.height * .5);
    UIImage *stretchableImage;
    if ([image respondsToSelector:@selector(resizableImageWithCapInsets:)])
        stretchableImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageHalfSize.height, imageHalfSize.width, imageHalfSize.height, imageHalfSize.width)];
    else
        stretchableImage = [image stretchableImageWithLeftCapWidth:imageHalfSize.width topCapHeight:imageHalfSize.height];
    
    [self setBackgroundImage:stretchableImage forState:UIControlStateNormal];
}

@end
