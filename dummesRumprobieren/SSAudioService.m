//
//  SSAudioService.m
//  dummesRumprobieren
//
//  Created by Simoon on 28.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SSAudioService.h"
//#import "CAStreamBasicDescription.h"
#import <CoreAudio/CoreAudio.h>
#import <AudioToolbox/AudioToolbox.h>



@implementation SSAudioService

- (void)loadAudioFileWithChar: (char*)URLString
{
	AudioFileID audioFile;
	
	CFURLRef theURL = CFURLCreateFromFileSystemRepresentation(kCFAllocatorDefault,
															 (UInt8*)URLString,
															  strlen(URLString),
															  false);

	AudioFileOpenURL(theURL, kAudioFileReadPermission, 0, &audioFile);

	// get the number of channels of the file:
	
	AUGraph theGraph;
	CAAudioUnit fileAU;
}

@end
