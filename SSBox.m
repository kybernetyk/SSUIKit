//
//  SSBox.m
//  GFX_Edit_View
//
//  Created by Simoon on 21.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSBox.h"
#import "SSConfig.h"

@implementation SSBox


- (void)drawRect:(NSRect)dirtyRect {
	
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	
#if ShowSSStyle	
	[self lockFocus];
		// **** aeusserer weisser gradient:
		
		CGContextBeginTransparencyLayer(myContext, NULL);
		
			CGGradientRef gradient;
			CGColorSpaceRef rgbColorSpace;				// auskommentiert, weil in spaghettiCode verwurstet
			size_t num_locations = 2;					// spaghettiOpfer
		
			CGFloat locations[2]  = { 0.0, 1.0 };
			CGFloat components[8] = { 1.0, 1.0, 1.0, 0.15,	//start color
							      1.0, 1.0, 1.0, 0.05 };	//end color
			
			rgbColorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);	
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
		
			CGPoint startPoint, endPoint;
			startPoint.x = 0.0;
			startPoint.y = 0.0;
			endPoint.x   = 0.0;
			endPoint.y   = [self bounds].size.height;
		
			CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
		
		
		
		// **** innerer schwarzer gradient:
		
		
				
			CGRect clippingRect = CGRectMake(1, 1, [self bounds].size.width-2, [self bounds].size.height-2);
			CGContextClipToRect(myContext, clippingRect);
		
			components[0] = 0.0; // color1
			components[1] = 0.0;
			components[2] = 0.0;
			components[3] = 0.9;
		
			components[4] = 0.0; // color2
			components[5] = 0.0;
			components[6] = 0.0;
			components[7] = 0.4;
		
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
				
			startPoint.x = 0.0;
			startPoint.y = [self bounds].size.height;
			endPoint.x   = 0.0;
			endPoint.y   = 0.0;
		
			CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
		
		
		
		// **** inner grey color:
		
		
		
			CGContextSetRGBFillColor (myContext, 0.2431, 0.2431, 0.2431, 1.0);
			CGContextFillRect        (myContext, CGRectMake(2, 2, [self bounds].size.width -4 , [self bounds].size.height -4 ));

		
		
		// **** colouring gradient:
			
		
		
			clippingRect = CGRectMake(2, 2, [self bounds].size.width-4, [self bounds].size.height-4);
			CGContextClipToRect(myContext, clippingRect);
		
			components[0] = 0.07; // color1
			components[1] = 0.2578;
			components[2] = 0.2901;
			components[3] = 0.1;
		
			components[4] = 0.07; // color2
			components[5] = 0.2578;
			components[6] = 0.2901;
			components[7] = 0.01;
		
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
		
			startPoint.x = 0.0;
			startPoint.y = 0.0;
			endPoint.x   = 0.0;
			endPoint.y   = [self bounds].size.height;
		
			CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
		
		CGContextEndTransparencyLayer(myContext);
		
		// **** InnerWhiteGradient:
		
		CGContextBeginTransparencyLayer(myContext, NULL);

			CGContextRef newRef = myContext;
			clippingRect = CGRectMake(2, 2, 1, [self bounds].size.height-4);
	
			CGContextClipToRect(myContext, clippingRect);
		
			components[0] = 1; // color1
			components[1] = 1;
			components[2] = 1;
			components[3] = 0.1;
		
			components[4] = 1; // color2
			components[5] = 1;
			components[6] = 1;
			components[7] = 0.2;
		
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
		
			startPoint.x = 0.0;
			startPoint.y = 0.0;
			endPoint.x   = 0.0;
			endPoint.y   = [self bounds].size.height;
		
			CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
		
		CGContextEndTransparencyLayer(myContext);
		
		CGContextBeginTransparencyLayer(myContext, NULL);
		
			clippingRect = CGRectMake([self bounds].size.width-3, 2, 1, [self bounds].size.height-4);
			CGContextClipToRect(newRef, clippingRect);
			CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
		
		CGContextEndTransparencyLayer(myContext);
		
		CGContextBeginTransparencyLayer(myContext, NULL);
		
			CGContextSetRGBFillColor (myContext, 1, 1, 1, 0.1);
			CGContextFillRect        (myContext, CGRectMake(3, 2, [self bounds].size.width -6 , 1 ));
		
			CGContextSetRGBFillColor (myContext, 1, 1, 1, 0.2);
			CGContextFillRect        (myContext, CGRectMake(3, [self bounds].size.height-3, [self bounds].size.width -6 , 1 ));

		CGContextEndTransparencyLayer(myContext);
				
		CGContextBeginTransparencyLayer(myContext, NULL);
		
			clippingRect = CGRectMake(2, [self bounds].size.height/2, [self bounds].size.width-4, [self bounds].size.height/2 -2);
			CGContextClipToRect(myContext, clippingRect);
		
			components[0] = 1; // color1
			components[1] = 1;
			components[2] = 1;
			components[3] = 0.01;
		
			components[4] = 1; // color2
			components[5] = 1;
			components[6] = 1;
			components[7] = 0.1;
		
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
		
			startPoint.x = 0.0;
			startPoint.y = 0.0;
			endPoint.x   = 0.0;
			endPoint.y   = [self bounds].size.height;
		
		CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
		
		
		CGContextEndTransparencyLayer(myContext);
		
		[self unlockFocus];
		
#else
		[super drawRect:dirtyRect];
#endif
}

- (BOOL)isOpaque
{
	// return [[self backgroundColor] alphaComponent] >= 1.0 ? YES : NO;
	return YES;
}

@end
