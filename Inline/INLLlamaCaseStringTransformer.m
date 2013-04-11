//
//  INLLlamaCaseStringTransformer.m
//  Inline
//
//  Created by Ryan Davies on 11/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLLlamaCaseStringTransformer.h"

@implementation INLLlamaCaseStringTransformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *components = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]];
    NSMutableArray *mutableComponents = [NSMutableArray arrayWithCapacity:[components count]];
    [components enumerateObjectsUsingBlock:^(id component, NSUInteger idx, BOOL *stop) {
        [mutableComponents addObject:(idx == 0 ? [component lowercaseString] : [component capitalizedString])];
    }];
    return [mutableComponents componentsJoinedByString:@""];
}

@end
