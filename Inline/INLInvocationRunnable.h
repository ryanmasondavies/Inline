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

#import <Foundation/Foundation.h>
@protocol INLRunnable;

/** An adapter which appears to be an instance of NSInvocation but instead forwards appropriate methods to an underlying INLRunnable. */
@interface INLInvocationRunnable : NSObject

/**
 Initialize an adapter.
 @param runnable The runnable object to run when invoked.
 @return An initialized adapter.
 */
- (id)initWithRunnable:(id<INLRunnable>)runnable;

/** @return The runnable which the adapter is forwarding messages to. */
- (id<INLRunnable>)runnable;

/**
 Inherited from NSInvocation.
 @return Returns nil.
 */
- (NSMethodSignature *)methodSignature;

/** Inherited from NSInvocation. Does nothing. */
- (void)retainArguments;

/**
 Inherited from NSInvocation.
 @return Returns NO.
 */
- (BOOL)argumentsRetained;

/**
 Inherited from NSInvocation.
 @return Returns nil.
 */
- (id)target;

/**
 Inherited from NSInvocation. Does nothing.
 @param target Ignored.
 */
- (void)setTarget:(id)target;

/**
 Inherited from NSInvocation.
 @return Returns nil.
 */
- (SEL)selector;

/**
 Inherited from NSInvocation. Does nothing.
 @param selector Ignored.
 */
- (void)setSelector:(SEL)selector;

/**
 Inherited from NSInvocation.
 @param retLoc Ignored.
 */
- (void)getReturnValue:(void *)retLoc;

/**
 Inherited from NSInvocation. Does nothing.
 @param retLoc Ignored.
 */
- (void)setReturnValue:(void *)retLoc;

/**
 Inherited from NSInvocation.
 @param argumentLocation Ignored.
 @param idx Ignored.
 */
- (void)getArgument:(void *)argumentLocation atIndex:(NSInteger)idx;

/**
 Inherited from NSInvocation. Does nothing.
 @param argumentLocation Ignored.
 @param idx Ignored.
 */
- (void)setArgument:(void *)argumentLocation atIndex:(NSInteger)idx;

/**
 Inherited from NSInvocation. Invokes `[INLRunnable run]` on runnable.
 */
- (void)invoke;

/**
 Inherited from NSInvocation. Invokes `[INLRunnable run]` on runnable.
 @param target Ignored.
 */
- (void)invokeWithTarget:(id)target;

@end
