//
//  SSColorWell.m
//  GFX_Edit_View
//
//  Created by Simoon on 24.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSColorWell.h"


@implementation SSColorWell
//@synthesize _color;

- (id)initWithFrame:(NSRect)frameRect
{
	_ownID = self = [super initWithFrame:frameRect];
	
	if (self) {
		_secondaryColor = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0);
		_color			= CGColorCreateGenericRGB(0.0, 0.0, 0.0, 1.0);
	}
	
	return self;
	
}

- (id)getID
{
	return self;
}

- (void)swapColor
{
	_swapColor = _color;
	_color = _secondaryColor;
	_secondaryColor = _swapColor;
	
	[self setNeedsDisplay: YES];
}

- (void) setColor: (NSColor *) color
{
	CGColorSpaceRef colorSpace = [[color colorSpace] CGColorSpace];
    NSInteger componentCount = [color numberOfComponents];
    CGFloat *components = (CGFloat *)alloca(componentCount*sizeof(CGFloat));
    [color getComponents:components];
    _color = CGColorCreate(colorSpace, components);
	[self setNeedsDisplay: YES];
}

- (void) setColorWithCGColorRef: (CGColorRef)color
{
	_color = color;
	[self setNeedsDisplay: YES];
}

- (void) setColorWithRed:(float)Red green:(float)Green blue:(float)Blue
{
	_color = CGColorCreateGenericRGB(Red, Green, Blue, 1.0);
	[self setNeedsDisplay: YES];
}

- (void) drawColor:(CGColorRef)color inRect:(CGRect)rect
{
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextBeginTransparencyLayer(myContext, NULL);
	
	CGContextSetFillColorWithColor(myContext, color);
	CGContextFillRect        (myContext, rect);
	
	CGContextSetRGBStrokeColor   (myContext, 0.4392, 0.4392, 0.4392, 1.0);
	CGContextStrokeRectWithWidth (myContext, rect, 2);
	CGContextSetRGBStrokeColor   (myContext, 0.1686, 0.1686, 0.1686, 1.0);
	CGContextStrokeRectWithWidth (myContext, CGRectMake(rect.origin.x + 1.5,rect.origin.y + 1.5, (NSInsetRect(rect, 1.5, 1.5)).size.width, (NSInsetRect(rect, 1.0, 1.0)).size.height), 1.0);
	
	CGGradientRef gradient;
	CGColorSpaceRef rgbColorSpace;				// auskommentiert, weil in spaghettiCode verwurstet
	size_t num_locations = 2;					// spaghettiOpfer
	
	CGFloat locations[2]  = { 0.0, 1.0 };
	CGFloat components[8] = { 1.0, 1.0, 1.0, 0.2,	//start color
		1.0, 1.0, 1.0, 0.001 };	//end color
	
	rgbColorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);	
	
	CGPoint startPoint, endPoint;
	
	CGRect clippingRect = CGRectMake(2, rect.size.height / 2 - 1, rect.size.width-4, rect.size.height/2-1);
	CGContextClipToRect(myContext, clippingRect);
	
	gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
	
	startPoint.x = 0;
	startPoint.y = 40;
	endPoint.x   = 40;
	endPoint.y   = 0;
	
//	CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0); 
	
	
	CGContextEndTransparencyLayer(myContext);	
}

- (void) drawRect:(NSRect)dirtyRect
{	
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextBeginTransparencyLayer(myContext, NULL);
	//[self lockFocus];
	
	// Farbe Malen:
	[self drawColor:_secondaryColor inRect:CGRectMake(12, 12, 20, 20)];
	[self drawColor:_color inRect:CGRectMake(4, 4, 20, 20)];
		
//	CGContextSetFillColorWithColor(myContext, _secondaryColor);
//	CGContextFillRect        (myContext, CGRectMake(12, 12, 20, 20));
	
//	CGContextSetFillColorWithColor(myContext, _color);
//	CGContextFillRect        (myContext, CGRectMake(4, 4, 20, 20));
	
	// behinates 1.5-pixel-konstrukt : /
	
//	CGContextSetRGBStrokeColor   (myContext, 0.4392, 0.4392, 0.4392, 1.0);
//	CGContextStrokeRectWithWidth (myContext, CGRectMake(0, 0, dirtyRect.size.width, dirtyRect.size.height), 2.0);
//	CGContextSetRGBStrokeColor   (myContext, 0.1686, 0.1686, 0.1686, 1.0);
//	CGContextStrokeRectWithWidth (myContext, CGRectMake(1.5, 1.5, (NSInsetRect(dirtyRect, 1.5, 1.5)).size.width, (NSInsetRect(dirtyRect, 1.5, 1.5)).size.height), 1.0);
		
	
	// NERDY GLOSSY CODE
	
/*		CGGradientRef gradient;
		CGColorSpaceRef rgbColorSpace;				// auskommentiert, weil in spaghettiCode verwurstet
		size_t num_locations = 2;					// spaghettiOpfer
	
		CGFloat locations[2]  = { 0.0, 1.0 };
		CGFloat components[8] = { 1.0, 1.0, 1.0, 0.2,	//start color
			1.0, 1.0, 1.0, 0.001 };	//end color
	
		rgbColorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);	
		
		CGPoint startPoint, endPoint;
	
		CGRect clippingRect = CGRectMake(2, dirtyRect.size.height / 2 - 1, dirtyRect.size.width-4, dirtyRect.size.height/2-1);
		CGContextClipToRect(myContext, clippingRect);
	
		gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	

		startPoint.x = 0.0;
		startPoint.y = dirtyRect.size.height;
		endPoint.x   = 0.0;
		endPoint.y   = 0.0;

		CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0); */

	// NERDY GLODDY CODE ENDE!
	
	CGContextEndTransparencyLayer(myContext);	
	//[self unlockFocus];
}



- (BOOL)isOpaque
{
	// return [[self backgroundColor] alphaComponent] >= 1.0 ? YES : NO;
	return NO;
}

- (void)dealloc
{
	CGColorRelease(_swapColor);
	CGColorRelease(_color);
	CGColorRelease(_secondaryColor);
	
	[super dealloc];
}



@end
