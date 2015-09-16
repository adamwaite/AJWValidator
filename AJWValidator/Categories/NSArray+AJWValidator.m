//
//  NSArray+AJWValidator.m
//  AJWValidator
//
//  Created by Alexander Kozin on 16.09.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

#import "NSArray+AJWValidator.h"

#import "UIView+AJWValidator.h"

@implementation NSArray (AJWValidator)

- (BOOL)ajw_isValid
{
    BOOL isValid = YES;

    // Don't use while because we should validate every object
    for (UIView *object in self) {
        BOOL localValidationResult = [object ajw_isValid];
        if (!localValidationResult) {
            isValid = NO;
        }
    }

    return isValid;
}

@end
