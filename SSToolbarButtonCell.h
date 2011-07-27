//
//  SSToolbarButton.h
//  GFX_Edit_View
//
//  Created by Simoon on 25.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SSToolbarButtonCell : NSButtonCell {

	BOOL _doesntShowsBorder;
	BOOL _isSelected;
	NSRect _frame;
	
	NSTrackingArea *myTrackingArea;
}

- (void)setIsHighlighted:(BOOL)YesOrNo;

@end