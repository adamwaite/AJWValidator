//
//  ALPValidatorEqualRule.m
//  ALPValidator
//
//  Created by Adam Waite on 31/01/2014.
//  Copyright (c) 2014 Adam Waite All rights reserved.
//

#import "ALPValidatorEqualRule.h"

@interface ALPValidatorEqualRule ()

@property (strong, nonatomic) id otherInstance;

@end

@implementation ALPValidatorEqualRule

#pragma mark Init

- (id)initWithType:(ALPValidatorRuleType)type invalidMessage:(NSString *)message otherInstance:(id)instance
{
    self = [super initWithType:type invalidMessage:message];
    if (self) {
        _otherInstance = instance;
    }
    return self;
}

#pragma mark Validate

- (BOOL)isValidationRuleSatisfied:(id)instance
{
    if ([instance isKindOfClass:[UITextField class]] && [self.otherInstance isKindOfClass:[UITextField class]])
        return [((UITextField *)instance).text isEqualToString:((UITextField *)self.otherInstance).text];
    if ([instance isKindOfClass:[NSString class]] && [self.otherInstance isKindOfClass:[UITextField class]])
        return [instance isEqualToString:((UITextField *)self.otherInstance).text];
    return [instance isEqual:self.otherInstance];
}

@end