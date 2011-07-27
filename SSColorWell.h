//
//  SSColorWell.h
//  GFX_Edit_View
//
//  Created by Simoon on 24.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SSColorWell : NSView {
	
	CGColorRef _color;
	CGColorRef _secondaryColor;
	CGColorRef _swapColor;
	id		   _ownID;
}

//@property (readwrite) 

- (void) setColorWithCGColorRef: (CGColorRef)color;
- (void) setColorWithRed:(float)Red green:(float)Green blue:(float)Blue;
- (id) getID;
- (void) swapColor;

@end
