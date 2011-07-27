//
//  SSImageEdit.h
//
//  Created by Simoon on 19.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SSConfig.h"

@interface SSImageEdit : NSView {


  // ids fuer upzudatende Views
	
	id			_colorWell;
	id			_loupeView;
	
  // interne Variablen
	
	NSImage*    _nsImage;
	//CGImageRef  _cgImage;
	float       _zoomX;
	float       _zoomY;
    CGColorRef  _currentColor;
	
	NSTrackingArea *myTrackingArea;
	
	
}

@property (retain)   CIFilter* filter;
@property (readonly) NSImage* _orgImage;

@property (readwrite, retain) NSImage *_nsImage;

- (CGImageRef) getImage;
- (void) setImage;
- (void)setImageFromFile: (NSURL *) url;
- (void)setZoomX:(float)xZoom;
- (void)setZoomY:(float)yZoom;

- (void)updateLoupeView: (CGPoint)position;
- (void)registerColorWell:(id)colorWell;
- (void)setLoupeImage;
- (void)updateLoupeView;



@end
