//
//  controller.m
//  dummesRumprobieren
//
//  Created by Simoon on 28.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "controller.h"


@implementation controller

- (void)awakeFromNib
{
	sound = [soundfile alloc];
}

- (IBAction) button:(id) sender
{
	[sound Beep];
}

- (IBAction) button1:(id) sender
{
	[sound Boop];
}

@end
