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

#import "INLRunnableInvocation.h"
#import "INLRunnable.h"

@interface INLRunnableInvocation ()
@property (strong, nonatomic) id<INLRunnable> runnable;
@end

@implementation INLRunnableInvocation

- (id)initWithRunnable:(id<INLRunnable>)runnable
{
    if (self = [self init]) {
        [self setRunnable:runnable];
    }
    return self;
}

- (void)invoke
{
    [[self runnable] run];
}

- (void)invokeWithTarget:(id)target
{
    [[self runnable] run];
}

- (void)setSelector:(SEL)selector
{
}

- (SEL)selector
{
    return nil;
}

- (void)setTarget:(id)target
{
}

- (id)target
{
    return nil;
}

- (void)setArgument:(void *)argumentLocation atIndex:(NSInteger)idx
{
}

- (void)getArgument:(void *)argumentLocation atIndex:(NSInteger)idx
{
}

- (BOOL)argumentsRetained
{
    return NO;
}

- (void)retainArguments
{
}

- (void)setReturnValue:(void *)retLoc
{
}

- (void)getReturnValue:(void *)retLoc
{
}

- (NSMethodSignature *)methodSignature
{
    return nil;
}

@end
