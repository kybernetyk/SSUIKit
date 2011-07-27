//
//  SSImageEdit.m
//
//  Created by Simoon on 19.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSImageEdit.h"
#import "SSConfig.h"
#import "SSColorWell.h"
#import "SSLoupe.h"


@interface SSImageEdit () //private category to get rid of warnings
- (void)myAddTrackingArea;
- (void)myRemoveTrackingArea;
@end

@implementation SSImageEdit
@synthesize image;
@synthesize filter;
@synthesize delegate;

- (id)initWithFrame:(NSRect)frameRect {
	self = [super initWithFrame:frameRect];
	if (self) {
		_currentColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 1.0);
		_zoomX = 1.0;
		_zoomY = 1.0;
		[self myAddTrackingArea];
	}
	
	return self;
}

- (void) setImage:(NSImage*)_image
{	
	[image release];
	image = [_image retain];
	[self setNeedsDisplay: YES];
}

- (void) resetCursorRects
{
	[super resetCursorRects];
	[self addCursorRect: [self bounds] cursor: [NSCursor crosshairCursor]];
	
}


- (NSColor *) colorAtPoint: (NSPoint) point
{
	if(!CGRectContainsPoint(CGRectMake(0, 0, [self bounds].size.width, [self bounds].size.height), point)) {
		return [NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:1.0];
	}
	
	CGImageRef cgImage = [[self image] CGImageForProposedRect: NULL context: NULL hints: nil];
	NSUInteger width  = CGImageGetWidth(cgImage);
	NSUInteger height = CGImageGetHeight(cgImage);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();	
	
	int bytesPerPixel = 4;
	int bytesPerRow = bytesPerPixel * 1;
	
	NSUInteger bitsPerComponent = 8;
	unsigned char pixelData[4] = { 0, 0, 0, 0};
	CGContextRef context = CGBitmapContextCreate(pixelData,
												 1,
												 1,
												 bitsPerComponent,
												 bytesPerRow,
												 colorSpace,
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	CGColorSpaceRelease(colorSpace);
	CGContextSetBlendMode(context, kCGBlendModeCopy);
	
	// Draw the Pixel we are interested in onto the bitmap context
	CGContextTranslateCTM(context, -point.x, -point.y);
	CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
	
	// convert color values [0...255] to floats [0.0 ... 1.0]
	CGFloat red    = (CGFloat)pixelData[0] / 255.0f;
	CGFloat green  = (CGFloat)pixelData[1] / 255.0f;
	CGFloat blue   = (CGFloat)pixelData[2] / 255.0f;
	CGFloat alpha  = (CGFloat)pixelData[3] / 255.0f;
	
	//return CGColorCreateGenericRGB(red, green, blue, alpha);
	return [NSColor colorWithDeviceRed: red green: green blue: blue alpha: alpha];
}

- (void)showImage
{
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextBeginTransparencyLayer(myContext, NULL);
	CGImageRef _image = [[self image] CGImageForProposedRect: NULL context: NULL hints: nil];
		CGRect imageRect;
		imageRect = CGRectMake(0.0, 0.0, CGImageGetWidth(_image), CGImageGetHeight(_image));
	
		CGContextScaleCTM(myContext, _zoomX, _zoomY);
		CGContextDrawImage(myContext, imageRect, _image);
	
	CGContextEndTransparencyLayer(myContext);
}
 

- (void)drawRect:(NSRect)dirtyRect {
	[[NSColor colorWithDeviceRed: 0.2431 green: 0.2431 blue: 0.2431 alpha: 1.0] set];
	NSRectFill(dirtyRect);
	[self showImage];
	[[NSColor colorWithDeviceRed:0.4392    green:0.4392    blue:0.4392    alpha: 1] set];
	NSFrameRect(dirtyRect);
	[[NSColor colorWithDeviceRed:0.1686 green:0.1686 blue:0.1686 alpha: 1.0] set]; //sets dark stroke color
	NSFrameRect((NSInsetRect(dirtyRect, 1, 1))); 		

}

//// ************ zoomFunktionen

- (void)setZoomX:(float)xZoom
{
	_zoomX = xZoom;
	[self setNeedsDisplay: YES];
}
- (void)setZoomY:(float)yZoom
{
	_zoomY = yZoom;
	[self setNeedsDisplay: YES];
}

//// ************ USERINTERACTION SHIT:

- (void)mouseDown: (NSEvent *)event
{
	CGPoint clickLocation;
	clickLocation = [self convertPoint: [event locationInWindow] fromView: nil];
	NSLog(@"x:%f, y:%f", clickLocation.x, clickLocation.y);	
	//[self updateColorWells: [self pickColorAtPointX:clickLocation.x Y:clickLocation.y]];
//	[self updateLoupeView: CGPointMake(clickLocation.x/_zoomX, clickLocation.y/_zoomY)];
	[delegate imageEditView: self mouseClickedAtPoint: clickLocation];
}

- (void)myAddTrackingArea
{
	[self myRemoveTrackingArea];
	NSTrackingAreaOptions trackingOptions =
		NSTrackingCursorUpdate | NSTrackingEnabledDuringMouseDrag | NSTrackingMouseMoved | 
		NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp;
	//note: NSTrackingActiveInActiveApp flags turns off the cursor updating feature;
	
	myTrackingArea = [[NSTrackingArea alloc] 
					  initWithRect: [self bounds]
					  options: trackingOptions
					  owner: self
					  userInfo: nil];
	
	[self addTrackingArea:myTrackingArea];
}

- (void)mouseMoved:(NSEvent *)theEvent
{
	NSPoint p = [theEvent locationInWindow];
	NSPoint motionPoint = [self convertPoint:p fromView:nil];
	//[self updateLoupeView: CGPointMake(motionPoint.x / _zoomX, motionPoint.y / _zoomY)];
	[delegate imageEditView: self mouseMouseMovedToPoint: motionPoint];
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


// **** BULLSHIT DER GEBRAUCHT WIRD 
- (BOOL)acceptsFirstResponder
{
	return YES;
}

- (BOOL)isOpaque
{
	// return [[self backgroundColor] alphaComponent] >= 1.0 ? YES : NO;
	return YES;
}

- (void) dealloc {
	[self myRemoveTrackingArea];
	[self setImage: nil];
	[super dealloc];
}


@end
