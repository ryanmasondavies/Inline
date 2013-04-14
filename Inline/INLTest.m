// The MIT License
// 
// Copyright (c) 2013 Ryan Davies
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "INLTest.h"
#import "INLTestDelegate.h"

@interface INLTest ()
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) INLVoidBlock block;
@property (strong, nonatomic) id<INLTestDelegate> delegate;
@end

@implementation INLTest

- (id)initWithName:(NSString *)name block:(INLVoidBlock)block delegate:(id<INLTestDelegate>)delegate
{
    if (self = [self init]) {
        [self setName:name];
        [self setBlock:block];
        [self setDelegate:delegate];
    }
    return self;
}

- (void)run
{
    [[self delegate] testWillRun:self];
    [self block]();
    [[self delegate] testDidRun:self];
}

@end
