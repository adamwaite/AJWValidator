//
//  UITextView+AJW.m
//  AJWValidator
//
//  Created by Alexander Kozin on 16.09.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

#import "UITextView+AJWValidator.h"
#import "UIView+AJWValidator_Protected.h"

#import "AJWValidatorInputType.h"

@implementation UITextView (AJWValidator)

- (AJWValidatorInputType)AJW_validatorType
{
    return AJWValidatorInputTypeUITextView;
}

- (void)ajw_attachValidator:(AJWValidator *)validator
{
    NSParameterAssert(validator);

    [self AJW_attachTextViewValidator];

    [self storeValidator:validator];
}

- (void)AJW_attachTextViewValidator
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AJW_validateTextViewForChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)AJW_validateTextViewForChange:(NSNotification *)notification
{
    [[self AJW_validators] enumerateObjectsUsingBlock:^(AJWValidator *validator, NSUInteger idx, BOOL *stop) {
        UITextView *textView = notification.object;
        [validator validate:textView.text];
    }];
}

- (id)instanceToValidate
{
    return self.text;
}

@end
