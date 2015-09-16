//
//  UITextField+AJWValidator.m
//  AJWValidator
//
//  Created by Alexander Kozin on 16.09.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

#import "UITextField+AJWValidator.h"
#import "UIView+AJWValidator_Protected.h"

@implementation UITextField (AJWValidator)

- (AJWValidatorInputType)AJW_validatorType
{
    return AJWValidatorInputTypeUITextField;
}

- (void)ajw_attachValidator:(AJWValidator *)validator
{
    NSParameterAssert(validator);
    
    [self AJW_attachTextFieldValidator];

    [self storeValidator:validator];
}

- (void)AJW_attachTextFieldValidator
{
    [(UITextField *)self addTarget:self action:@selector(AJW_validateTextFieldForChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)AJW_validateTextFieldForChange:(UITextField *)textField
{
    [[self AJW_validators] enumerateObjectsUsingBlock:^(AJWValidator *validator, NSUInteger idx, BOOL *stop) {
        [validator validate:textField.text];
    }];
}

- (id)instanceToValidate
{
    return self.text;
}

@end
