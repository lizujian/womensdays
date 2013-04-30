//
//  UIFont+CustomFonts.m
//  LinguaLeo
//
//  Created by Oleg Ivanov on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIFont+Custom.h"


@implementation UIFont(Custom)

+ (id)helveticaNeueForSize:(CGFloat)size isBold:(BOOL)isBold
{
	NSString *aFontName = nil;
	
	if (isBold) {
		aFontName = @"HelveticaNeue-Bold";
	} else {
		aFontName = @"HelveticaNeue";
	}

	return [UIFont fontWithName:aFontName size:size];
}

+ (id)boldHelveticaNeueOfSize:(CGFloat)size
{
	return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

+ (id)helveticaNeueOfSize:(CGFloat)size
{
	return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

- (BOOL)isBold
{
	return [self.fontName rangeOfString:@"Bold" options:NSCaseInsensitiveSearch].location != NSNotFound;
}

- (BOOL)isItalic
{
	return [self.fontName rangeOfString:@"Italic" options:NSCaseInsensitiveSearch].location != NSNotFound;
}

@end
