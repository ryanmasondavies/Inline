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

#import "INLSenTestCase.h"
#import "INLInvocationRunnable.h"
#import "INLLlamaCaseStringTransformer.h"
#import "INLLettersStringTransformer.h"
#import "INLTest.h"

@interface SenTestCase ()
+ (NSArray *)senAllSuperclasses;
@end

@implementation INLSenTestCase

+ (NSArray *)testInvocations
{
    INLSenTestCase *testCase = [[[self class] alloc] init];
    NSArray *tests = [testCase tests];
    
    NSMutableArray *adapters = [[NSMutableArray alloc] init];
    [tests enumerateObjectsUsingBlock:^(id<INLRunnable> runnable, NSUInteger idx, BOOL *stop) {
        INLInvocationRunnable *adapter = [[INLInvocationRunnable alloc] initWithRunnable:runnable];
        [adapters addObject:adapter];
    }];
    
    return adapters;
}

+ (NSArray *)senAllSuperclasses
{
    NSArray *superclasses = [super senAllSuperclasses];
    if ([superclasses[0] isEqual:[INLSenTestCase class]]) return @[[NSObject class]];
    return superclasses;
}

- (void)failWithException:(NSException *)exception
{
    [exception raise];
}

- (NSString *)name
{
    INLInvocationRunnable *adapter = (id)[self invocation];
    INLTest *test = (INLTest *)[adapter runnable];
    NSValueTransformer *llamaCase = [[INLLlamaCaseStringTransformer alloc] init];
    NSValueTransformer *lettersOnly = [[INLLettersStringTransformer alloc] init];
    
    NSString *caseName = NSStringFromClass([self class]);
    if ([caseName rangeOfString:@"Spec"].location == [caseName length] - 4) {
        caseName = [caseName substringToIndex:[caseName length] - 4];
    }
    
    NSString *testName = [test name];
    testName = [llamaCase transformedValue:testName];
    testName = [lettersOnly transformedValue:testName];
    
    return [NSString stringWithFormat:@"-[%@ %@]", caseName, testName];
}

- (NSArray *)tests
{
    return nil;
}

@end
