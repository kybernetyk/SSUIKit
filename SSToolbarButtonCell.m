//
//  SSToolbarButton.m
//  GFX_Edit_View
//
//  Created by Simoon on 25.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSToolbarButtonCell.h"


@implementation SSToolbarButtonCell

- (id) initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	_isSelected = NO;
	_doesntShowsBorder = NO;
	return self;
}

- (BOOL) showsBorderOnlyWhileMouseInside
{
	if(_doesntShowsBorder == YES)
	{
		return NO;
	} else {
		return YES;	
	}
}

- (void)setIsHighlighted:(BOOL)YesOrNo
{
	_isSelected = YesOrNo;
}

- (BOOL)isHighlighted
{
	if (_isSelected==YES)
	{
		return YES;
	} else {
		return [super isHighlighted];
	}
}

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView
{
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextSetShouldAntialias(myContext, NO);
		
			CGGradientRef gradient;
			CGColorSpaceRef rgbColorSpace;				// auskommentiert, weil in spaghettiCode verwurstet
			size_t num_locations = 2;					// spaghettiOpfer
			
			CGFloat locations[2]  = { 0.0, 1.0 };
			CGFloat components[8] = { 1.0, 1.0, 1.0, 0.02,	//start color
									  1.0, 1.0, 1.0, 0.2 };	//end color
			
			rgbColorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);	
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
			
			CGPoint startPoint, endPoint;
			startPoint.x = 0.0;
			startPoint.y = 0.0;
			endPoint.x   = 0.0;
			endPoint.y   = frame.size.height;
	
			CGRect clippingRect;
			
	if([self showsBorderOnlyWhileMouseInside] || [self isHighlighted] || _isSelected)
	{
	
			CGContextBeginTransparencyLayer(myContext, NULL);
	
				clippingRect = CGRectMake(0, 0, 1, frame.size.height);
				CGContextClipToRect(myContext, clippingRect);
	
				CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
			
			CGContextEndTransparencyLayer(myContext);
			CGContextBeginTransparencyLayer(myContext, NULL);
	
				clippingRect = CGRectMake(frame.size.width-1, 0, 1, frame.size.height);
				CGContextClipToRect(myContext, clippingRect);
	
				CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
	
			CGContextEndTransparencyLayer(myContext);
			CGContextBeginTransparencyLayer(myContext, NULL);
	
				CGContextSetRGBFillColor (myContext, 1, 1, 1, 0.025);
				CGContextFillRect        (myContext, CGRectMake(1, 0, frame.size.width -2, 1 ));
	
				CGContextSetRGBFillColor (myContext, 1, 1, 1, 0.25);
				CGContextFillRect        (myContext, CGRectMake(1, frame.size.height-1, frame.size.width -2, 1 ));
			
			CGContextEndTransparencyLayer(myContext);
	
	// inner black:
	
			components[0] = 0.0823; // color1
			components[1] = 0.0823;
			components[2] = 0.0823;
			components[3] = 0.1;
	
			components[4] = 0.0823; // color2
			components[5] = 0.0823;
			components[6] = 0.0823;
			components[7] = 0.5;
			
	
			startPoint.x = 0.0;
			startPoint.y = frame.size.height;
			endPoint.x   = 0.0;
			endPoint.y   = 0.0;
			
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);
		
			CGContextBeginTransparencyLayer(myContext, NULL);
			
				clippingRect = CGRectMake(1, 1, 1, frame.size.height-2);
				CGContextClipToRect(myContext, clippingRect);
			
				CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
			
			CGContextEndTransparencyLayer(myContext);
			CGContextBeginTransparencyLayer(myContext, NULL);
			
				clippingRect = CGRectMake(frame.size.width-2, 1, 1, frame.size.height-2);
				CGContextClipToRect(myContext, clippingRect);
			
				CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0); 
			
			CGContextEndTransparencyLayer(myContext);
			CGContextBeginTransparencyLayer(myContext, NULL);
			
				CGContextSetRGBFillColor (myContext, 0, 0, 0, 0.5);
				CGContextFillRect        (myContext, CGRectMake(1, 0, frame.size.width -2, 1 ));
			
				CGContextSetRGBFillColor (myContext, 0, 0, 0, 0.1);
				CGContextFillRect        (myContext, CGRectMake(1, frame.size.height-2, frame.size.width -2, 1 ));
			
			CGContextEndTransparencyLayer(myContext); 
	
	// inner white:
	if(![self isHighlighted])
	{
			components[0] = 1.0; // color1
			components[1] = 1.0;
			components[2] = 1.0;
			components[3] = 0.1;
	
			components[4] = 1.0; // color2
			components[5] = 1.0;
			components[6] = 1.0;
			components[7] = 0.3;
		
	} else {
			components[0] = 1.0; // color1
			components[1] = 1.0;
			components[2] = 1.0;
			components[3] = 0.3;
		
			components[4] = 1.0; // color2
			components[5] = 1.0;
			components[6] = 1.0;
			components[7] = 0.1;
	}
	
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);
	
			CGContextBeginTransparencyLayer(myContext, NULL);
	
				clippingRect = CGRectMake(2, 2, 1, frame.size.height-4);
				CGContextClipToRect(myContext, clippingRect);
	
				CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
	
			CGContextEndTransparencyLayer(myContext);
			CGContextBeginTransparencyLayer(myContext, NULL);
	
				clippingRect = CGRectMake(frame.size.width-3, 2, 1, frame.size.height-4);
				CGContextClipToRect(myContext, clippingRect);
	
				CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0); 
	
			CGContextEndTransparencyLayer(myContext);
			CGContextBeginTransparencyLayer(myContext, NULL);
	
				CGContextSetRGBFillColor (myContext, 1, 1, 1, components[7]);
				CGContextFillRect        (myContext, CGRectMake(2, 1, frame.size.width -4, 1 ));
	
				CGContextSetRGBFillColor (myContext, 1, 1, 1, components[3]);
				CGContextFillRect        (myContext, CGRectMake(3, frame.size.height-3, frame.size.width -6, 1 ));
	
			CGContextEndTransparencyLayer(myContext); 
	}
	
	// inner black gradient: 

			if([self isHighlighted])
			{
				components[0] = 0.0; // color1
				components[1] = 0.0;
				components[2] = 0.0;
				components[3] = 0.05;
	
				components[4] = 0.0; // color2
				components[5] = 0.0;
				components[6] = 0.0;
				components[7] = 0.2;
	
		
				gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);
	
				CGContextBeginTransparencyLayer(myContext, NULL);
	
					clippingRect = CGRectMake(1, 1, frame.size.width-2, frame.size.height-2);
					CGContextClipToRect(myContext, clippingRect);
					CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0); 
	
				CGContextEndTransparencyLayer(myContext); 
			}	
}
/*
- (void)myAddTrackingArea
{
	[self myRemoveTrackingArea];
	NSTrackingAreaOptions trackingOptions =
	NSTrackingCursorUpdate | NSTrackingEnabledDuringMouseDrag |  NSMouseMoved |
	NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp;
	//note: NSTrackingActiveInActiveApp flags turns off the cursor updating feature;
	
	myTrackingArea = [[NSTrackingArea alloc] 
					  initWithRect: _frame
					  options: trackingOptions
					  owner: self
					  userInfo: nil];
	
	[self addTrackingArea:myTrackingArea];
}

- (void)mouseMoved:(NSEvent *)theEvent
{
	isHovered = YES;
	NSLog(@"mouse has moves");
	[self setNeedsDisplay:YES];
}

- (void)setIsSelected:(BOOL)IsIt
{
	isSelected = IsIt;
	[self setNeedsDisplay:YES];
}

- (void)mouseEntered:(NSEvent *)theEvent
{
	NSLog(@"mouse has entered");
	isHovered = YES;
	[self setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)theEvent
{
	NSLog(@"mouse has exited");
//	isHovered = NO;
	[self setNeedsDisplay:YES];
}

- (void) myRemoveTrackingArea
{
	if(myTrackingArea)
	{
		[self removeTrackingArea: myTrackingArea];
		[myTrackingArea release];
		myTrackingArea = nil;
	}
}
*/
- (BOOL)isOpaque
{
	// return [[self backgroundColor] alphaComponent] >= 1.0 ? YES : NO;
	return NO;
}

- (void)dealloc
{
// 	[self myRemoveTrackingArea];
	[super dealloc];
}

@end
