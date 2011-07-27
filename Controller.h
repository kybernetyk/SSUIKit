//
//  Controller.h
//  GFX_Edit_View
//
//  Created by Simoon on 19.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import <QuartzCore/QuartzCore.h>
#import "SSImageEdit.h"
#import "SSView.h"
#import "SSButtonCell.h"
#import "SSBox.h"
#import "SSStatusBar.h"
#import "SSLoupe.h"
#import "SSColorWell.h"

@interface Controller : NSObject <SSImageEditDelegate> {


// TestCrap:
		
// UI-Elements:
	
	IBOutlet SSImageEdit* _imageEdit;
	IBOutlet SSLoupe* _loupeView;
	IBOutlet SSColorWell* _colorWell;

	IBOutlet NSTextField* _zoomText;
	IBOutlet NSTextField* _IMGzoomTextX;
	IBOutlet NSTextField* _IMGzoomTextY;
	
	IBOutlet NSButton* _niggerButton;
	
// toolbar - nachher den shit mal mit dem notification-center realisieren:
	
	IBOutlet NSButton* _toolMouse;
	IBOutlet NSButton* _toolSelect;
	IBOutlet NSButton* _toolCrop;
	IBOutlet NSButton* _toolPickColor;
	IBOutlet NSButton* _toolPencil;
	IBOutlet NSButton* _toolFill;
	IBOutlet NSButton* _toolEraser;
	IBOutlet NSButton* _toolNote;
	IBOutlet NSButton* _toolZoom;
	
//	IBOutlet NSImageView;
	
	NSImage *image;
}
@property (readwrite, retain) NSImage *image;
// toolbar-select Tool
	
-(IBAction)selectToolMouse: (id)sender;
-(IBAction)selectToolSelect: (id)sender;
-(IBAction)selectToolCrop: (id)sender;
-(IBAction)selectToolPickColor: (id)sender;
-(IBAction)selectToolPencil: (id)sender;
-(IBAction)selectToolFill: (id)sender;
-(IBAction)selectToolEraser: (id)sender;
-(IBAction)selectToolNote: (id)sender;
-(IBAction)selectToolZoom: (id)sender;



-(IBAction)setImageEditZoom: (id)sender;
-(IBAction) setAnotherMousePosition: (id)sender;
-(IBAction)registerShit: (id)sender;




@end
