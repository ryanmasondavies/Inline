//
//  INLBlockHookSpec.m
//  Inline
//
//  Created by Ryan Davies on 05/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLBlockHook)

describe(@"-execute", ^{
    it(@"should invoke the assigned block", ^{
        INLBlockHook *hook = [[INLBlockHook alloc] init];
        __block BOOL executed = NO;
        [hook setBlock:^{ executed = YES; }];
        [hook execute];
        expect(executed).to.beTruthy();
    });
});

SpecEnd
