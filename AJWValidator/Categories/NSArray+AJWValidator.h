//
//  NSArray+AJWValidator.h
//  AJWValidator
//
//  Created by Alexander Kozin on 16.09.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (AJWValidator)

/**
 *  Determines whether all objects in array is valid
 *
 *  Internally calls -ajw_isValid for all objects in array
 *
 *  @return 'YES' if object contains any data, otherwise 'NO'
 */
- (BOOL)ajw_isValid;

@end
