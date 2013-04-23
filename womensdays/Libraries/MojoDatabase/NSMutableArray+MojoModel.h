//
//  NSMutableArray+MojoModel.h
//  naturino
//
//  Created by Ирина Завилкина on 23.04.13.
//  Copyright (c) 2013 Traffic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MojoModel;

@interface NSMutableArray (MojoModel)

@property (nonatomic, strong) MojoModel *owner;

+ (id)arrayWithArray:(NSArray *)array owner:(MojoModel *)owner;

- (BOOL)containsMojoObject:(id)anObject;

-(BOOL)deleteMojoObject:(MojoModel *)object;
-(BOOL)deleteAllMojoObjects;

-(BOOL)deleteMojoObject:(MojoModel *)object onlyRelashion:(BOOL)onlyRelashion;
-(BOOL)deleteAllMojoObjectsOnlyRelashion:(BOOL)onlyRelashion;

-(BOOL)addMojoObject:(MojoModel *)object;
-(BOOL)addMojoObjects:(NSArray *)objects;

@end
