//
//  SSButton.m
//  GFX_Edit_View
//
//  Created by Simoon on 21.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSButtonCell.h"
#import "SSConfig.h"

@implementation SSButtonCell


- (NSRect) drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView
{

	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextSetShouldAntialias(myContext, YES);
	
	NSRect nigger = NSInsetRect(frame, 2, 2);
	
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSFont fontWithName:@"Arial" size: nigger.size.height -1], NSFontAttributeName,
								[NSColor colorWithDeviceRed:1.0 green:1.0 blue:1.0 alpha:0.45], NSForegroundColorAttributeName,
								nil];
	NSAttributedString* _title = [[NSAttributedString alloc] initWithString:[title string] attributes: attributes];

	if([self isHighlighted])
	{
		[_title drawAtPoint:NSMakePoint((krueppelHilfe.size.width/2 - [_title size].width/2),
										(krueppelHilfe.size.height/2 - [title size].height/2))];
		CGContextSetShouldAntialias(myContext, NO);
	} else {
		[_title drawAtPoint:NSMakePoint((krueppelHilfe.size.width/2 - [_title size].width/2),
										(krueppelHilfe.size.height/2 - [title size].height/2)+1)];
		CGContextSetShouldAntialias(myContext, NO);
	}
	
	[_title dealloc];	
	return frame;
} 

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView
{
#if ShowSSStyle	
		krueppelHilfe = frame;
		
		CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
		CGContextSetShouldAntialias(myContext, NO);
		// outer white shit
		
		CGContextBeginTransparencyLayer(myContext, NULL);
		
			CGGradientRef gradient;
			CGColorSpaceRef rgbColorSpace;				// auskommentiert, weil in spaghettiCode verwurstet
			size_t num_locations = 2;					// spaghettiOpfer
		
			CGFloat locations[2]  = { 0.0, 1.0 };
			CGFloat components[8] = { 1.0, 1.0, 1.0, 0.01,	//start color
									  1.0, 1.0, 1.0, 0.1 };	//end color
		
			rgbColorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);	
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
		
			CGPoint startPoint, endPoint;
			startPoint.x = 0.0;
			startPoint.y = 0.0;
			endPoint.x   = 0.0;
			endPoint.y   = frame.size.height;
		
			CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
		
		// dark button coloer 
		
			CGContextSetRGBFillColor (myContext, 0.1718, 0.1718, 0.1718, 1.0);
			CGContextFillRect        (myContext, CGRectMake(1, 1, frame.size.width -2 , frame.size.height -2 ));
		
		CGContextEndTransparencyLayer(myContext);
		
		// color gradient
		
		CGContextBeginTransparencyLayer(myContext, NULL);
		
			CGRect clippingRect = CGRectMake(2, 2, frame.size.width-4, frame.size.height-4);
			CGContextClipToRect(myContext, clippingRect);
		
			components[0] = 0.07; // color1
			components[1] = 0.2578;
			components[2] = 0.2901;
			components[3] = 0.05;
		
			components[4] = 0.07; // color2
			components[5] = 0.2578;
			components[6] = 0.2901;
			components[7] = 0.4;
		
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
		
			startPoint.x = 0.0;
			startPoint.y = 0.0;
			endPoint.x   = 0.0;
			endPoint.y   = frame.size.height;
		
			CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
		
		CGContextEndTransparencyLayer(myContext);
		
		// inner black gradient
		
		CGContextBeginTransparencyLayer(myContext, NULL);
		
			clippingRect = CGRectMake(2, 2, frame.size.width-4, frame.size.height-4);
			CGContextClipToRect(myContext, clippingRect);
		
			components[0] = 0.0823; // color1
			components[1] = 0.0823;
			components[2] = 0.0823;
			components[3] = 0.01;
		
			components[4] = 0.0823; // color2
			components[5] = 0.0823;
			components[6] = 0.0823;
			components[7] = 0.5;
		
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
		
			startPoint.x = 0.0;
			startPoint.y = 0.0;
			endPoint.x   = 0.0;
			endPoint.y   = frame.size.height;
		
			CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
		
		CGContextEndTransparencyLayer(myContext);
				
		// **** InnerWhiteGradient:
		
		CGContextBeginTransparencyLayer(myContext, NULL);
		
			CGContextRef newRef = myContext;
			clippingRect = CGRectMake(2, 2, 1, frame.size.height-4);
		
			CGContextClipToRect(myContext, clippingRect);
		
			if([self isHighlighted])
			{
				components[0] = 1; // color1
				components[1] = 1;
				components[2] = 1;
				components[3] = 0.01;
		
				components[4] = 1; // color2
				components[5] = 1;
				components[6] = 1;
				components[7] = 0.2;
			
			} else {
			
				components[0] = 1; // color1
				components[1] = 1;
				components[2] = 1;
				components[3] = 0.2;
			
				components[4] = 1; // color2
				components[5] = 1;
				components[6] = 1;
				components[7] = 0.01;
			}
		
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
		
			startPoint.x = 0.0;
			startPoint.y = 0.0;
			endPoint.x   = 0.0;
			endPoint.y   = frame.size.height;
		
			CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
			
		CGContextEndTransparencyLayer(myContext);
		
		CGContextBeginTransparencyLayer(myContext, NULL);
		
			clippingRect = CGRectMake(frame.size.width-3, 2, 1, frame.size.height-4);
			CGContextClipToRect(newRef, clippingRect);
			CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
		
		CGContextEndTransparencyLayer(myContext);
		
		CGContextBeginTransparencyLayer(myContext, NULL);
		
			if([self isHighlighted])
			{		
				CGContextSetRGBFillColor (myContext, 1, 1, 1, 0.01);
				CGContextFillRect        (myContext, CGRectMake(3, 2, frame.size.width -6 , 1 ));
		
				CGContextSetRGBFillColor (myContext, 1, 1, 1, 0.2);
				CGContextFillRect        (myContext, CGRectMake(3, frame.size.height-3, frame.size.width -6 , 1 ));
			} else {
				CGContextSetRGBFillColor (myContext, 1, 1, 1, 0.01);
				CGContextFillRect        (myContext, CGRectMake(3, frame.size.height-3, frame.size.width -6 , 1 ));
			
				CGContextSetRGBFillColor (myContext, 1, 1, 1, 0.2);
				CGContextFillRect        (myContext, CGRectMake(3, 2, frame.size.width -6 , 1 ));
			}
		
		CGContextEndTransparencyLayer(myContext);

		//Glossy Effect!
		
		CGContextBeginTransparencyLayer(myContext, NULL);
		
			
		
		if([self isHighlighted])		//aendert je nach state den gloss-faktor :D
		{
			clippingRect = CGRectMake(2, 2, frame.size.width-4, frame.size.height/2-2);
			CGContextClipToRect(myContext, clippingRect);
			components[0] = 1; // color1
			components[1] = 1;
			components[2] = 1;
			components[3] = 0.16;
			
			components[4] = 0.8; // color2
			components[5] = 0.8;
			components[6] = 1;
			components[7] = 0.001;
		} else {
			clippingRect = CGRectMake(2, 2, frame.size.width-4, frame.size.height/2-1);
			CGContextClipToRect(myContext, clippingRect);
			
			components[0] = 1; // color1
			components[1] = 1;
			components[2] = 1;
			components[3] = 0.2;
			
			components[4] = 1; // color2
			components[5] = 1;
			components[6] = 1;
			components[7] = 0.001;
		}
		
			gradient = CGGradientCreateWithColorComponents(rgbColorSpace, components, locations, num_locations);	
		
			startPoint.x = 0.0;
			startPoint.y = 0.0;
			endPoint.x   = 0.0;
			endPoint.y   = frame.size.height;
		
			CGContextDrawLinearGradient( myContext, gradient, startPoint, endPoint, 0);
		
		CGContextEndTransparencyLayer(myContext);
		
	
#else
		
		[super drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView];
		
#endif
}

//***********************************************************************************************************

//- (CGImageRef) convertNSImageToCGImage:(NSImage *)image
//{
//	NSData* nsImageData   = [NSBitmapImageRep TIFFRepresentationOfImageRepsInArray: [image representations]];
//	CFDataRef cfImageData = (CFDataRef)nsImageData;
//	CGImageSourceRef imageSourceRef = CGImageSourceCreateWithData(cfImageData, NULL);
//	_cgImage = CGImageSourceCreateImageAtIndex(imageSourceRef, 0, NULL);
//	return _cgImage;	
//}

//***********************************************************************************************************

- (void)drawImage:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView
{	
	// pruefung ob bild vorhanden ist muss rein!
	// ausserdem muessen die bilder mal geflippt werden
	// und so shit fuer disabled, gerade am start und normal muss rein
	// ausserdem das color mal aendern auf das miese hellblau was ich eig. nutzen will
	
#if ShowSSStyle	
	NSGraphicsContext *ctx = [NSGraphicsContext currentContext];
	CGContextRef contextRef = [ctx graphicsPort];
	 
	 NSData *data = [image TIFFRepresentation];
	 CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)data, NULL);
	 if(source) {
		 CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
		 CFRelease(source);
		 
		 CGContextSaveGState(contextRef);
		 {
		//	 NSRect rect = NSOffsetRect(frame, 0.0f, 1.0f);
		//	 CGFloat white = [self isHighlighted] ? 1.0f : 0.85f;
		//	 CGContextClipToMask(contextRef, NSRectToCGRect(rect), imageRef);
		//	 [[NSColor colorWithDeviceWhite:0.4f alpha:1.0f] setFill];
		//	 NSRectFill(rect);
		}
		 CGContextRestoreGState(contextRef);
		 
		// Draw Image
		 
		CGContextSaveGState(contextRef);
		 {

			 NSRect rect = frame;
			 CGContextClipToMask(contextRef, NSRectToCGRect(rect), imageRef);
			 if ([self isHighlighted]) {
				[[NSColor colorWithDeviceWhite:0.55f alpha:1.0f] setFill]; 
			 } else {
			 [[NSColor colorWithDeviceWhite:0.4f alpha:1.0f] setFill];
			 }
			 NSRectFill(rect);
		 }
		 CGContextRestoreGState(contextRef);
		 CFRelease(imageRef);
	 }
#else
		[super drawImage:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView];
#endif
	
}

- (BOOL)isOpaque
{
	// return [[self backgroundColor] alphaComponent] >= 1.0 ? YES : NO;
	return NO;
}

@end
