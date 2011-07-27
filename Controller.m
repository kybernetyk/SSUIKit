//
//  Controller.m
//  GFX_Edit_View
//
//  Created by Simoon on 19.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Quartz/Quartz.h>
#import <QuartzCore/QuartzCore.h>

#import "Controller.h"
#import "SSImageEdit.h"
#import "SSView.h"
#import "SSButtonCell.h"
#import "SSBox.h"
#import "SSStatusBar.h"
#import "SSLoupe.h"
#import "vecLibSample.h"

@implementation Controller
@synthesize image;

-(void)awakeFromNib {
	NSLog(@"Controller: ...");
	[_colorWell setColorWithRed:0.1 green:0.1 blue:0.1];


//	CFURLRef url = CFURLCreateFromFileSystemRepresentation (kCFAllocatorDefault, "/1.png", strlen("/1.png"), NO);
	//CFURLRef url = CFURLCreateFromFileSystemRepresentation (kCFAllocatorDefault, "/test.png", strlen("/test.png"), NO);
	[self setImage: [NSImage imageNamed: @"test.png"]];
	
	//maybe add a datasource to loupe view and co so they can request the current image when needed?
	[_imageEdit setImage: [self image]];
	[_loupeView setImage: [self image]];
	
//	[_imageEdit registerColorWell: [_colorWell getID]];
//	[_imageEdit registerLoupeView: [_loupeView getID]];
	[_imageEdit setDelegate: self];
	
	[_niggerButton setShowsBorderOnlyWhileMouseInside:YES];
}

-(IBAction)setImageEditZoom: (id)sender
{
	float nigger = [_IMGzoomTextX floatValue];
	float nogger = [_IMGzoomTextY floatValue];
	[_imageEdit setZoomX:nigger];
	[_imageEdit setZoomY:nogger];
}
	
-(IBAction)setAnotherMousePosition: (id)sender {
	
		float nigger = [_zoomText floatValue];
		[_loupeView setZoomFactor:nigger];
		[_zoomText releaseGState]; 
	}

-(IBAction)registerShit: (id)sender {
	[_colorWell swapColor];
//	vecLibSample* vecSample = [vecLibSample alloc];
//	[vecSample doShit];	
//	[vecSample release];
//	[vecSample dealloc];
}

// toolbar shit

-(IBAction)selectToolMouse: (id)sender
{
/*	double frequency = 2000.0f;
	
	struct Simple_AIFF_File {
		unsigned int formID;
		int formChunkSize;
		unsigned int formType;
		
	unsigned int commID;
		int commChunkSize;
		short numChannels;
		unsigned int numSampleFrames;
		short sampleSize;
		extended80 sampleRate;
		
		// SND chunk
		unsigned int ssndID;
		int ssndChunkSize;
		unsigned int offset;
		unsigned int blockSize;
		int soundData[];
	}__attribute__((__packed__));
	
	const unsigned int sampleRate = 48000;
	const unsigned int channels = 1;
	const unsigned int bytesPerFrame = channels * sizeof(struct Simple_AIFF_File);
	const unsigned int seconds = 4;
	
	const unsigned int dataSize = seconds * sampleRate * channels * bytesPerFrame;
	const unsigned int totalSize = dataSize + sizeof(struct Simple_AIFF_File);
	
	unsigned int i;
	
	struct Simple_AIFF_File* aiff = malloc(totalSize);
	if(!aiff){
		NSLog(@"Out of memory allocating %lu bytes!", totalSize);
		return EXIT_FAILURE;
	}
	
	aiff->commID = 'COMM';
	aiff->commChunkSize=18;
	aiff->numChannels=1;
	aiff->numSampleFrames = seconds * sampleRate;
	aiff->sampleSize = 32;
	
	double sampleRateDouble = (double)sampleRate;
	dtox80(&sampleRateDouble, &aiff->sampleRate);
	
	aiff->ssndID = 'SSND';
	aiff->ssndChunkSize = dataSize + 8;
	aiff->offset=0;
	aiff->blockSize=0;
	
	for(i=0; i<seconds * sampleRate * channels; i++)
	{
		aiff->soundData[i] = INT_MAX * sin(i * M_PI * 2 * (frequency/(double)sampleRate));
	}
	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	NSData *data = [[NSData alloc]initWithBytesNoCopy:aiff length:totalSize];
	
	NSSound *sound = [[NSSound alloc] initWithData:data];
	CFURLRef url2 = CFURLCreateFromFileSystemRepresentation (kCFAllocatorDefault, "/test3.aiff", strlen("/test3.aiff"), NO);
	[data writeToURL: url2 atomically:YES];
	[data release];
	[sound play];
	sleep(seconds);
	[sound release];
	[pool release];
	
*/	
}


-(IBAction)selectToolSelect: (id)sender
{

	
}

-(IBAction)selectToolCrop: (id)sender
{

}

-(IBAction)selectToolPickColor: (id)sender
{

	
}

-(IBAction)selectToolPencil: (id)sender
{

}

-(IBAction)selectToolFill: (id)sender
{
	
	
}

-(IBAction)selectToolEraser: (id)sender
{
	
}

-(IBAction)selectToolNote: (id)sender
{
	
}

-(IBAction)selectToolZoom: (id)sender
{

	
}


#pragma mark - ImageEditView delegate
- (void)imageEditView: (SSImageEdit *) view mouseClickedAtPoint: (NSPoint) point
{
	//if (selectedTool == picker)
	[_colorWell setColor: [_imageEdit colorAtPoint: point]];
}

- (void)imageEditView: (SSImageEdit *) view mouseMouseMovedToPoint: (NSPoint) point
{
	[_loupeView setMousePosition: point];
}
@end
