//
//  SSStatusBar.m
//  GFX_Edit_View
//
//  Created by Simoon on 22.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSStatusBar.h"
#import "SSConfig.h"

@implementation SSStatusBar

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame: frameRect];
	return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
//	CGContextSetShouldAntialias(myContext, NO);
#if ShowSSStyle	
	// Neuer CoreGraphics Code:
		[self lockFocus];
		CGContextBeginTransparencyLayer(myContext, NULL);
		
		CGContextSetRGBFillColor(myContext, 0, 0, 0, 0.2);
		CGContextFillRect(myContext, CGRectMake(4, dirtyRect.size.height-4, dirtyRect.size.width -8, 4));
		CGContextSetRGBStrokeColor(myContext, 1, 1, 1, .1);
		CGContextStrokeRectWithWidth(myContext, CGRectMake(4, dirtyRect.size.height-4, dirtyRect.size.width -8, 4), 1);
		
		// gradient erstellen
		
		CGGradientRef darkeningGradient;
		
		CGFloat locations[2] = { 0.0, 1.0 };
		CGFloat components[8] = { 0.0, 0.0, 0.0, 0.2,	//start color
								  0.0, 0.0, 0.0, 0.0 };	//end color
		darkeningGradient = CGGradientCreateWithColorComponents(CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB), // <- spaghettiCode
																components,
																locations,
																((size_t)2));
		
		// gradient malen
		
		CGPoint startPoint, endPoint;
		startPoint.x = 0.0;
		startPoint.y = 0.0;
		endPoint.x   = 0.0;
		endPoint.y   = [self bounds].size.height;
		
		CGContextDrawLinearGradient( myContext, darkeningGradient, startPoint, endPoint, 0);
		
		CGContextEndTransparencyLayer(myContext);
		[self unlockFocus]; 

// **************************************************************************************************** /*
/*		
		// Alter Cocoa-Code:
		
				[[NSColor colorWithDeviceRed: 0.2431 green: 0.2431 blue: 0.2431 alpha: 1.0] set];
		 NSRectFill((NSMakeRect(4, dirtyRect.size.height-4, dirtyRect.size.width -8, 4)));
		 [[NSColor colorWithDeviceRed:0.4392f green:0.4392f blue:0.4392f alpha:1] set];
		 NSFrameRect((NSMakeRect(4, dirtyRect.size.height-4, dirtyRect.size.width -8, 4))); 
		
		
		
		NSColor* black1 = [NSColor colorWithDeviceRed:0.0823f green:0.0823f blue:0.0823f alpha:0.2f];
		NSColor* black2 = [NSColor colorWithDeviceRed:0.0823f green:0.0823f blue:0.0823f alpha:0.001f];	
		NSArray* blackToBlack   = [NSArray arrayWithObjects:black1, black2, nil];
	
		NSGradient *innerBlackGradient = [[NSGradient alloc] initWithColors:blackToBlack];
	
	
		[innerBlackGradient drawInRect:(NSMakeRect(1, 1, [self bounds].size.width -2, [self bounds].size.height -2)) angle: 90]; 
		[innerBlackGradient release]; 
*/		
// **************************************************************************************************** */
		
#else
		
		CGContextSetRGBFillColor(myContext, 0, 0, 0, 0.4);
		CGContextFillRect(myContext, CGRectMake(4, dirtyRect.size.height-3, dirtyRect.size.width -8, 1));
		CGContextSetRGBStrokeColor(myContext, 1, 1, 1, 0.5);
		CGContextStrokeRect(myContext, CGRectMake(4, dirtyRect.size.height-4, dirtyRect.size.width -8, 1));
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
