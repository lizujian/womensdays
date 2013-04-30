//
//  UIFont+CustomFonts.h
//  LinguaLeo
//
//  Created by Oleg Ivanov on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFont(Custom)

+ (id)helveticaNeueForSize:(CGFloat)size isBold:(BOOL)isBold;
+ (id)boldHelveticaNeueOfSize:(CGFloat)size;
+ (id)helveticaNeueOfSize:(CGFloat)size;

- (BOOL)isBold;
- (BOOL)isItalic;

@end
