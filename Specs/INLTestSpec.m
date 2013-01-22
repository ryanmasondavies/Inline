//
//  INLTestSpec.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLTest)

describe(@"-execute", ^{
    it(@"should invoke block", ^{
        __block BOOL executed = NO;
        INLTest *test = [[INLTest alloc] init];
        [test setBlock:^{ executed = YES; }];
        [test execute];
        expect(executed).to.beTruthy();
    });
});

SpecEnd
