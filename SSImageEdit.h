//
//  SSImageEdit.h
//
//  Created by Simoon on 19.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SSConfig.h"
#import "SSLoupe.h"

@class SSImageEdit;
@protocol SSImageEditDelegate
- (void)imageEditView: (SSImageEdit *) view mouseClickedAtPoint: (NSPoint) point;
- (void)imageEditView: (SSImageEdit *) view mouseMouseMovedToPoint: (NSPoint) point;
@end

@interface SSImageEdit : NSView {
  // ids fuer upzudatende Views
	id			_colorWell;
//	SSLoupe 	*_loupeView;
	
  // interne Variablen
@private
	NSImage*    image;
	float       _zoomX;
	float       _zoomY;
    CGColorRef  _currentColor;
	
	NSTrackingArea *myTrackingArea;
	
	id <SSImageEditDelegate> delegate;
}

@property (retain) CIFilter* filter;
@property (readwrite, retain) NSImage *image;

@property (readwrite, assign) id delegate;

- (void)setZoomX:(float)xZoom;
- (void)setZoomY:(float)yZoom;

- (NSColor *) colorAtPoint: (NSPoint) point;

@end
