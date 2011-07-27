//
//  SonogramSharedData.h
//  GFX_Edit_View
//
//  Created by Simoon on 27.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreAudio/CoreAudioTypes.h>

#define kMaxNumAnalysisFrames	512
#define kMaxNumBins				512
#define kMaxSonogramLatency		512


/*
typedef SInt64 SampleTime;

struct SonogramOverview
{
	UInt32			mChannel;
	UInt32			mNumSlices;
	AudioTimeStamp	mFetchStamp;
	
	UInt32			mNumBins;
	Float32			mMaxAmp;
	Float32			mMinAmp;
	
	Float32			mOverview[1];
};
typedef struct SonogramOverview SonogramOverview;

*/
 
@protocol SonogramSharedData


@end
