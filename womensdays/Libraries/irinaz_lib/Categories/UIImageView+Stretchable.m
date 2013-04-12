//
//  UIImageView+Stretchable.m
//  carlsberg
//
//  Created by Ирина Завилкина on 01.03.13.
//  Copyright (c) 2013 Ирина Завилкина. All rights reserved.
//

#import "UIImageView+Stretchable.h"

@implementation UIImageView (Stretchable)

- (void)setStretchableImage:(UIImage *)image
{
    CGSize imageHalfSize = CGSizeMake(image.size.width * .5, image.size.height * .5);
    UIImage *stretchableImage;
    if ([image respondsToSelector:@selector(resizableImageWithCapInsets:)])
        stretchableImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageHalfSize.height, imageHalfSize.width, imageHalfSize.height, imageHalfSize.width)];
    else
        stretchableImage = [image stretchableImageWithLeftCapWidth:imageHalfSize.width topCapHeight:imageHalfSize.height];
    
    [self setImage:stretchableImage];
}

@end
