//
//  SSImageEdit.h
//
//  Created by Simoon on 19.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SSConfig.h"
#import "SSLoupe.h"

//TODO: decople loupe view and image edit view by using notifications

@interface SSImageEdit : NSView {
  // ids fuer upzudatende Views
	id			_colorWell;
	SSLoupe 	*_loupeView;
	
  // interne Variablen
@private
	NSImage*    image;
	float       _zoomX;
	float       _zoomY;
    CGColorRef  _currentColor;
	
	NSTrackingArea *myTrackingArea;
}

@property (retain)   CIFilter* filter;
@property (readwrite, retain) NSImage *image;

#if 0
@property (readonly) NSImage* _orgImage;
#endif 

- (void)setImageFromFile: (NSURL *) url;
- (void)setZoomX:(float)xZoom;
- (void)setZoomY:(float)yZoom;

- (void)registerColorWell:(id)colorWell;
- (void)setLoupeImage;



@end
