//
//  SSView.m
//  GFX_Edit_View
//
//  Created by Simoon on 21.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSView.h"
#import "SSConfig.h"

@implementation SSView

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	return self;
}

- (void)drawRect: (NSRect)dirtyRect {
#if ShowSSStyle	
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
		CGContextSetRGBFillColor (myContext, 0.3490, 0.3490, 0.3490, 1.0);
		CGContextFillRect        (myContext, CGRectMake(0, 0, [self bounds].size.width, [self bounds].size.height));
		
#else
		[super drawRect:dirtyRect];
#endif
}

- (BOOL)isOpaque
{
	// return [[self backgroundColor] alphaComponent] >= 1.0 ? YES : NO;
	return YES;
}

- (void)dealloc
{
	[super dealloc];
}

@end
