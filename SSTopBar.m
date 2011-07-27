//
//  SSTopBar.m
//  GFX_Edit_View
//
//  Created by Simoon on 25.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSTopBar.h"


@implementation SSTopBar

-(id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	if(self)
	{
			}
	return self;
}

-(void)drawRect:(NSRect)dirtyRect
{
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextBeginTransparencyLayer(myContext, NULL);
	
	CGContextSetRGBFillColor(myContext, 0, 0, 0, 0.2);
	CGContextFillRect(myContext, CGRectMake(4, 1, dirtyRect.size.width -8, 1));
	CGContextSetRGBFillColor(myContext, 1, 1, 1, 0.1);
	CGContextFillRect(myContext, CGRectMake(4, 0, dirtyRect.size.width -8, 1));	
	
	CGContextEndTransparencyLayer(myContext);
}
- (BOOL)isOpaque
{
	return YES;
}

-(void)dealloc
{
	[super dealloc];
}


@end
