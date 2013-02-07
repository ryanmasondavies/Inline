//
//  INLGroupedReporter.h
//  Inline
//
//  Created by Ryan Davies on 06/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Transcript/Transcript.h>

/** A reporter which groups tests together, e.g:
 
 a cat
     when it is sleeping
        should have its eyes closed
        should snore
     when it is hungry
        should incessantly meow
        should rub against every leg in near proximity
 
 Notice that the tests are indented appropriately.
 */
@interface INLGroupedReporter : TSCTidyReporter
@end
