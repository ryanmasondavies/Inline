//
//  INLFakeTest.h
//  Inline
//
//  Created by Ryan Davies on 08/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

// OCMock does not allow stubbing of -description, so INLFakeTest is necessary.
// TODO: Deprecate INLFakeTest once Mockingbird supports stubbing of @selector(description).

@interface INLFakeTest : INLTest
- (id)initWithDescription:(NSString *)description;
@property (copy, nonatomic) NSString *description;
@end
