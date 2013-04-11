//
//  INLOCUnitTemplateFactory.m
//  Inline
//
//  Created by Ryan Davies on 11/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLOCUnitTemplateFactory.h"

@implementation INLOCUnitTemplateFactory

+ (GRMustacheTemplate *)createTemplate
{
    NSString *string = @"Test Suite 'Suite' started at {{startDate}}{{#tests}}\n"
                        "Test Case '-[Test {{llamaCase(name)}}]' started.{{#failure}}\n"
                        "{{#isEmpty(filePath)}}Unknown.m{{^}}{{filePath}}{{/}}:{{#isEmpty(lineNumber)}}0{{^}}{{lineNumber}}{{/}}: error: -[Test {{llamaCase(name)}}] : {{reason}}\n"
                        "Test Case '-[Test {{llamaCase(name)}}]' failed (0.001 seconds).{{^failure}}\n"
                        "Test Case '-[Test {{llamaCase(name)}}]' passed ({{threeDecimalPoints(duration)}} seconds).{{/failure}}{{/tests}}\n"
                        "Test Suite 'Suite' finished at {{finishDate}}.\n"
                        "Executed {{tests.count}} {{#pluralize(tests.count)}}test{{/}}, with {{numberOfFailures(tests)}} {{#pluralize(numberOfFailures(tests))}}failure{{/}} (0 unexpected) in {{threeDecimalPoints(duration)}} ({{threeDecimalPoints(duration)}}) seconds";
    return [GRMustacheTemplate templateFromString:string error:NULL];
}

@end
