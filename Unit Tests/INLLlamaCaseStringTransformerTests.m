//
//  INLLlamaCaseStringTransformer.m
//  Inline
//
//  Created by Ryan Davies on 11/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLLlamaCaseStringTransformerTests : SenTestCase

@end

@implementation INLLlamaCaseStringTransformerTests

- (void)testCapitalizesAllButFirstWordAndRemovesSpaces
{
    // given
    INLLlamaCaseStringTransformer *transformer = [[INLLlamaCaseStringTransformer alloc] init];
    
    // when
    NSString *result = [transformer transformedValue:@"The Great Llama Case"];
    
    // then
    [[result should] beEqualTo:@"theGreatLlamaCase"];
}

@end
