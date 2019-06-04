/*

 ValidatorTests.swift
 Validator

 Created by @adamwaite.

 Copyright (c) 2015 Adam Waite. All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

*/

import XCTest
@testable import Validator

class ValidatorTests: XCTestCase {
    
    func testThatItCanEvaluateRules() {
        
        let err = testError
        
        let rule = ValidationRuleCondition<String>(error: err) { ($0?.count)! > 0 }
        
        let invalid = Validator.performValidation(input: "", rule: rule)
        XCTAssertEqual(invalid, ValidationResult.invalid([err]))
        
        let valid = Validator.performValidation(input: "😀", rule: rule)
        XCTAssertEqual(valid, ValidationResult.valid)
        
    }
    
    func testThatItCanEvaluateMultipleRules() {

        let err1 = testError
        let err2 = ValidationError(message: "💣💣")
        
        var ruleSet = ValidationRuleSet<String>()
        ruleSet.add(rule: ValidationRuleLength(min: 1, error: err1))
        ruleSet.add(rule: ValidationRuleCondition<String>(error: err2) { $0 == "😀" })
        
        let definitelyInvalid = Validator.performValidation(input: "", rules: ruleSet)
        XCTAssertEqual(definitelyInvalid, ValidationResult.invalid([err1, err2]))
        
        let partiallyValid = "😁".performValidation(rules: ruleSet)
        XCTAssertEqual(partiallyValid, ValidationResult.invalid([err2]))

        let valid = "😀".performValidation(rules: ruleSet)
        XCTAssertEqual(valid, ValidationResult.valid)
        
    }
    
}
