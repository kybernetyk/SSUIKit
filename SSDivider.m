//
//  SSDivider.m
//  GFX_Edit_View
//
//  Created by Simoon on 23.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSDivider.h"
#import "SSConfig.h"

@implementation SSStatusDivider

- (id) initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[self lockFocus];
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextBeginTransparencyLayer(myContext, NULL);
	
		if(ShowSSStyle)
		{

			if(dirtyRect.size.width > 5)
			{	
				CGContextSetRGBFillColor(myContext, 1, 1, 1, 0.5);
				CGContextFillRect(myContext, CGRectMake(2, 2, dirtyRect.size.width - 4, dirtyRect.size.height - 4));
				CGContextSetRGBFillColor(myContext, 0, 0, 0, 0.2);
				CGContextFillRect(myContext, dirtyRect);
			} else {
				CGContextSetRGBFillColor(myContext, 0, 0, 0, 0.2);
				CGContextFillRect(myContext, CGRectMake(1, 0, 1, dirtyRect.size.height -7));
				CGContextSetRGBFillColor(myContext, 1, 1, 1, 0.1);
				CGContextFillRect(myContext, CGRectMake(0, 0, 1, dirtyRect.size.height -7));
			}
			
		} else {
		
			CGContextSetRGBFillColor(myContext, 0, 0, 0, 0.2);
			CGContextFillRect(myContext, CGRectMake(1, 0, 1, dirtyRect.size.height -7));
			CGContextSetRGBFillColor(myContext, 1, 1, 1, 0.1);
			CGContextFillRect(myContext, CGRectMake(0, 0, 1, dirtyRect.size.height -7));
		}
	
	CGContextEndTransparencyLayer(myContext);
	[self unlockFocus];
}

- (BOOL)isOpaque
{
	// return [[self backgroundColor] alphaComponent] >= 1.0 ? YES : NO;
	return YES;
}

@end
