//
//  SSLoupe.m
//  GFX_Edit_View
//
//  Created by Simoon on 22.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSLoupe.h"
#import <Quartz/Quartz.h>
#import <QuartzCore/QuartzCore.h>

@interface SSLoupe()
- (void) zoomImage;

@end

@implementation SSLoupe
@synthesize image;

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	
	if (self) {
		_zPosition = NSMakePoint(0, 0);
		_zFactor = 1.0f;
		
		// [self setMousePositionWithX:50 Y:60];
		//	_image = [[NSImage alloc] initWithContentsOfFile:@"/1.png"];
		//	[self setImage];
	}
	
	return self;
	
}

//- (void) setImage: (NSImage*)image
//{
/*	NSData *originalData = [image TIFFRepresentation];
	float resizeWidth  = [self bounds].size.width;
	float resizeHeight = [self bounds].size.height;
	
	NSImage *sourceImage  = [[NSImage alloc] initWithData:originalData];
	NSImage *resizedImage = [[NSImage alloc] initWithSize: NSMakeSize(resizeWidth, resizeHeight)];
	
	NSSize originalSize = [sourceImage size];
	
	[resizedImage lockFocus];
	[sourceImage drawInRect: NSMakeRect(0, 0, resizeWidth, resizeHeight)
				   fromRect: NSMakeRect(0, 0, originalSize.width, originalSize.height)
				  operation: NSCompositeSourceOver fraction: 1.0];
	[resizedImage unlockFocus];
	
	[resizedImage dissolveToPoint:(NSMakePoint(0, 0)) fraction:1.0];
	
	[sourceImage release];
	[resizedImage release]; */
//}

- (id)getID
{
	return self;
}

- (void) loadImage: (NSString*)aPath
{
//	NSImage *image = [[NSImage alloc] initWithContentsOfFile:aPath];
//	
	
//	[image release];
//	return imageData; 
}

//- (void) initWithFrame:(NSRect)frameRect
//{
//	zoomedImage = [[NSImage alloc] initWithData:[self loadImage:@"/test.png"]];
//}


//- (void)setImage:(CGImageRef)image
//{
//	_cgImage = CGImageCreateCopy(image);
//	
//		NSLog(@"image in loupe set");
//	[self setNeedsDisplay: YES];
////	[self zoomImage];
//}

-(void)setZoomFactor:(float)zoom
{
	if(zoom == 0)
	{
		zoom = 1.0f;
	}
	
	if(zoom > 80)
	{
		zoom = 80.0f;
	}
	
	_zFactor = zoom;
	
	[self zoomImage];
	[self setNeedsDisplay: YES];
}

-(void)setMousePosition:(CGPoint)position
{
	_zPosition = position;
	[self setNeedsDisplay: YES];
}

- (void) drawZoomedImage
{
	
	// ***** ALLES SCHEISSE - DIE TAGE MAL KOMPLETT NEU MACHEN!
	
	// Geplanter ablauf 
	// _cgImage entsprechend zoomen
	// dann ein 128x128 großes dingsie ausschneiden
	// und dieses anzeigen
	CGImageRef _cgImage = [[self image] CGImageForProposedRect: NULL context: NULL hints: nil];
	CGRect imageRect;
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextBeginTransparencyLayer(myContext, NULL);
	CGContextSetShouldAntialias(myContext, NO);
	
	float x = _zPosition.x  - [self bounds].size.width/2 /_zFactor;
	if(x < 0)
		x=0;
	if((x + ([self bounds].size.width) / _zFactor) > (CGImageGetWidth(_cgImage)))
	{
		x = (CGImageGetWidth(_cgImage) - ([self bounds].size.width) / _zFactor);   
	}
	
	float y = (CGImageGetHeight(_cgImage) - _zPosition.y - ([self bounds].size.width/2) / _zFactor);
	if((y + [self bounds].size.height / _zFactor) > (CGImageGetHeight(_cgImage)))
		y = CGImageGetHeight(_cgImage) - [self bounds].size.height / _zFactor;
	if(y < 0)
		y= 0; 
	
	CGImageRef zoomedImage = CGImageCreateWithImageInRect(_cgImage, CGRectMake(x, y, [self bounds].size.width, [self bounds].size.height));
	imageRect = CGRectMake(0, 0, [self bounds].size.width, [self bounds].size.height);	
	
	CGContextScaleCTM(myContext, _zFactor, _zFactor);
	CGContextDrawImage(myContext, [self bounds],  zoomedImage);
	CGImageRelease(zoomedImage);	
	
	CGContextSetShouldAntialias(myContext, YES);
	CGContextEndTransparencyLayer(myContext);	
}

- (void) zoomImage
{
		
}

- (void) drawRect:(NSRect)dirtyRect
{	
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];

	// HinterGrundFarbe Malen:
	
	CGContextBeginTransparencyLayer(myContext, NULL);

	// HIER NE IF-aBFRAGE ob ein image existiert, weil dann is es unnuetz den hintergrund zu malen
	
		CGContextSetRGBFillColor (myContext, 0.2431, 0.2431, 0.2431, 1.0);
		CGContextFillRect        (myContext, CGRectMake(0, 0, dirtyRect.size.width, dirtyRect.size.height));
	
	CGContextEndTransparencyLayer(myContext);
	
	// image zeichnen

	[self drawZoomedImage];
	
	// rahmen ziehen:
	CGContextBeginTransparencyLayer(myContext, NULL);
	
	// behinates 1.5-pixel-konstrukt : /
	
		CGContextSetRGBStrokeColor   (myContext, 0.4392, 0.4392, 0.4392, 1.0);
		CGContextStrokeRectWithWidth (myContext, CGRectMake(0, 0, dirtyRect.size.width, dirtyRect.size.height), 2.0);
		CGContextSetRGBStrokeColor   (myContext, 0.1686, 0.1686, 0.1686, 1.0);
		CGContextStrokeRectWithWidth (myContext, CGRectMake(1.5, 1.5, (NSInsetRect(dirtyRect, 1.5, 1.5)).size.width, (NSInsetRect(dirtyRect, 1.5, 1.5)).size.height), 1.0);

	CGContextSetRGBFillColor   (myContext, 1, 1 , 1, 0.5);
	CGContextFillRect(myContext, CGRectMake(dirtyRect.size.width/2, 8, 1, dirtyRect.size.height - 16));
	CGContextFillRect(myContext, CGRectMake(8, dirtyRect.size.height/2, dirtyRect.size.width - 16, 1 ));
	
	CGContextEndTransparencyLayer(myContext);	
}

- (BOOL)isOpaque
{
	return YES;
}

- (void) dealloc {
	[self setImage: nil];
	[super dealloc];
	
}
@end
