//
//  SSLoupe.h
//  GFX_Edit_View
//
//  Created by Simoon on 22.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface SSLoupe : NSView {
//	float zoom;

	NSImage *image;
	
//	NSImage*    _nsImage;
//	CGImageRef  _cgImage;
//	CGImageRef  _cgZoomedImage;
	
//	NSImage* _zImage;
//	NSImage* _image;
	CGPoint  _zPosition;
	float    _zFactor;
}
@property (readwrite, retain) NSImage *image;
- (id) getID;

-(void)setMousePosition:(CGPoint)position;
-(void)setZoomFactor:(float)zoom;
//- (void)setImage:(CGImageRef)image;

@end
