//
//  UITextInput+AJWValidator.m
//  AJWValidator
//
//  Created by Michael Gaylord on 2014/08/28.
//  Copyright (c) 2014 Adam Waite. All rights reserved.
//

#import "UIView+AJWValidator_Protected.h"

#import <objc/runtime.h>

static char AJWValidators;

@implementation UIView (AJWValidator)

#pragma mark Associated Object Accessors

- (NSMutableArray *)AJW_validators
{
    return objc_getAssociatedObject(self, &AJWValidators);
}

#pragma mark Supported Input Views

- (AJWValidatorInputType)AJW_validatorType
{
    return AJWValidatorInputTypeUnsupported;
}

#pragma mark Attach/Remove

- (void)ajw_attachValidator:(AJWValidator *)validator
{
    NSLog(@"Tried to add AJWValidator to unsupported control type of class %@. %s.", [self class], __PRETTY_FUNCTION__);
    NSAssert(NO, nil);
}

- (void)storeValidator:(AJWValidator *)validator
{
    if (![self AJW_validators]) {
        objc_setAssociatedObject(self, &AJWValidators, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    [[self AJW_validators] addObject:validator];
}

- (void)ajw_removeValidators
{
    [[self AJW_validators] removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)ajw_isValid
{
    BOOL isValid = YES;
    // Don't use while because we should call validate on every instance
    for (AJWValidator *validator in [self AJW_validators]) {
        [validator validate:[self instanceToValidate]];
        if (isValid && ![validator isValid]) {
            isValid = NO;
        }
    }

    return isValid;
}

- (id)instanceToValidate
{
    NSAssert(NO, @"Subclasses should override this method");
    return nil;
}

#pragma mark Deprecated

- (void)attachValidator:(AJWValidator *)validator
{
    [self ajw_attachValidator:validator];
}

- (void)removeValidators
{
    [self ajw_removeValidators];
}

@end
