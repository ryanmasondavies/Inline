//
//  INLBuilderSpec.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLBuilder)

when(@"initialized", ^{
    it(@"should have a root group", ^{
        expect([[INLBuilder new] rootGroup]).to.beKindOf([INLGroup class]);
    });
});

SpecEnd
