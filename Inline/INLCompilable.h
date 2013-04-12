//
//  INLCompilable.h
//  Inline
//
//  Created by Ryan Davies on 12/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol INLCompiler;

/** An object that can be handled by a compiler. */
@protocol INLCompilable <NSObject>

/**
 Compile with the given compiler.
 @param compiler The compiler to use.
 */
- (void)compileWithCompiler:(id<INLCompiler>)compiler;

@end
