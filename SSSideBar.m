//
//  SSSideBar.m
//  GFX_Edit_View
//
//  Created by Simoon on 25.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSSideBar.h"


@implementation SSSideBar

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
	
	CGContextSetRGBFillColor (myContext, 0.305, 0.305, 0.305, 1.0);
	CGContextFillRect        (myContext, CGRectMake(0, 0, [self bounds].size.width, [self bounds].size.height));
	
	CGContextSetRGBStrokeColor   (myContext, 0.4392, 0.4392, 0.4392, 1.0);
	CGContextStrokeRectWithWidth (myContext, CGRectMake(0, 0, [self bounds].size.width, [self bounds].size.height), 2.0);
	CGContextSetRGBStrokeColor   (myContext, 0.1686, 0.1686, 0.1686, 1.0);
	CGContextStrokeRectWithWidth (myContext, CGRectMake(1.5, 1.5, (NSInsetRect([self bounds], 1.5, 1.5)).size.width, (NSInsetRect([self bounds], 1.5, 1.5)).size.height), 1.0);
		
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
