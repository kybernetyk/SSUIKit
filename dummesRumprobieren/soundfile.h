//
//  soundfile.h
//  dummesRumprobieren
//
//  Created by Simoon on 28.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface soundfile : NSObject {
	NSSound *sound;
	NSData  *soundData;
}

- (void)Beep;

@end
