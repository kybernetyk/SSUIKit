//
//  soundfile.m
//  dummesRumprobieren
//
//  Created by Simoon on 28.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "soundfile.h"


@implementation soundfile

- (void)Initialize
{
			 
}

- (void)Beep
{
	NSBeep();
	NSSound *_sound = [[NSSound alloc] initWithContentsOfFile: @"/test3.aiff" byReference: NO];	
	[_sound play];
}

- (void)Boop
{
	NSBeep();
	NSData *_songData = [[NSData alloc] initWithContentsOfFile: @"/test1.wav" byReference: NO];
	NSSound *nigger = [[NSSound alloc] initWithData:_songData];
//	[_songData dealloc]
	[nigger play];
}
@end
