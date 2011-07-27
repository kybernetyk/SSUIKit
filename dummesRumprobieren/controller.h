//
//  controller.h
//  dummesRumprobieren
//
//  Created by Simoon on 28.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "soundfile.h"

@interface controller : NSObject {
	soundfile* sound;
}

- (IBAction) button:(id)sender;
- (IBAction) button1:(id) sender;

@end
