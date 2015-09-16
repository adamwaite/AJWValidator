//
//  UIView+AJWValidator_Protected.h
//  AJWValidator
//
//  Created by Alexander Kozin on 16.09.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

#import "UIView+AJWValidator.h"

#import "AJWValidator.h"
#import "AJWValidatorInputType.h"

@interface UIView (AJWValidator_Protected)

- (NSMutableArray *)AJW_validators;
- (void)storeValidator:(AJWValidator *)validator;

@end
