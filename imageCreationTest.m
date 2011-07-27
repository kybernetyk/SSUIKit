//
//  imageCreationTest.m
//  GFX_Edit_View
//
//  Created by Simoon on 27.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "imageCreationTest.h"

/* 
#define NSRectToCGRect(r) CGRectMake(r.origin.x, r.origin.y, r.size.width, r.size.height)

typedef struct{
	float red;
	float green;
	float blue;
} ColorTriplet;

@implementation imageCreationTest

- (void) createColormap: (UInt32) mapSize			// hier werden die abstufungen der farben definiert
{													// bei gelegenheit durch eigenen shit ersetzen <3
	colormapSize = mapSize;
	if(_colormap) free(_colormap);
	_colormap = (Float32*)calloc(3*mapSize, sizeof(Float32));
	
	Float32 bRed    = [_backgroundColor redComponent];
	Float32 bGreen  = [_backgroundColor greenComponent];
	Float32 bBlue   = [_backgroundColor blueComponent];
	
	Float32 fRed    = [_lineColor redComponent];
	Float32 fGreen  = [_lineColor greenComponent];
	Float32 fBlue   = [_lineColor blueComponent];
	
	Float32 incrRed   = (fRed - bRed)/mapSize;
	Float32 incrGreen = (fGreen - bGreen)/mapSize;
	Float32 incrBlue  = (fBlue - bBlue)/mapSize;
	
	UInt32 index;
	for (UInt32 i = 0; i < mapSize; i++)
	{
		index = i*3;
		_colormap[index]   = bRed;
		_colormap[index+1] = bGreen;
		_colormap[index+2] = bBlue;
		
		bRed    += incrRed;
		bGreen  += incrGreen;
		bBlue   += incrBlue;
	}
}

- (UInt32) skewColor: (Float32) x
{
	UInt32 pos = (UInt32)(x * (colormapSize-1));
	return(pos);
}

- (UInt32) getIndex:(Float32)value withMin:(Float32)minD andMax:(Float32)maxD andScale:(Float32)scale
{
	if(maxD < .001) return 0;
	
	value /= scale; //value = value / scale
	
	Float32 maxDB = 20.0 * log10(1.0 + maxD);		//dB sind eine logarythmische skala ...
	Float32 minDB = 20.0 * log10(1.0 + minD);		//deshalb der unverständliche shit
	Float32 inDB  = 20.0 * log10(1.0 + value);
	
	Float32 db;
	db = (inDB <= minDB) ? minDB : inDB; // if (inDB <= minDB) { inDB = minDB } else { inDB = inDB };
	db = (inDB >= maxDB) ? maxDB : inDB; // bei diesen beiden zeilen wird anscheinend "clipping" durchgefuehrt
	
	Float32 ratio = (db/maxDB);			// ratio ist anscheinend die angabe wo der entsprechende db wert auf der 
										// farbskala liegt ... bzw. eher die vorstufe davon, wenn du mir folgen kannst
	UInt32 j = [self skewColor: ratio]; // hier bekommen wir die "farb-position"
	
	return j;
}

- (ColorTriplet) getColorWithIndex: (UInt32) j
{
	ColorTriplet c;
	UInt32 index = j*3;		// wieso * 3?
	c.red    = _colormap[index];
	c.green  = _colormap[index+1];
	c.blue   = _colormap[index+2];
	return c;
}

// ** ab hier wird initialisiert

- (void) InitializeBuffers
{
	[self createColormap: mNumBins];
	UInt32 numBytesPerFrame = mNumBins*4*sizeof(unsigned char); //rgba
	
//	if(mRingBuffer) delete(mRingBuffer);
//	mRingBuffer = new CARingBuffer();
//	mRingBuffer->Allocate(1, numBytesPerFrame, mNumSlicesTotal);
	
//	mRingBufferCounter = 0;
	mRenderCounter = 0;
	
	UInt32 numTotalBytes = numBytesPerFrame*mNumSlicesTotal;
	
//	CAStreamBasicDescription	bufClientDesc;
//	bufClientDesc.SetCanonical(1, false);
//	if(mFetchingBufferList) {
//		mFetchingBufferList->DeallocateBuffers();
//		delete(mFetchingBufferList);
//	}
//	mFetchingBufferList = CABufferList::New("fetch buffer", bufClientDesc);
//	mFetchingBufferList->AllocateBuffers(numTotalBytes);
	
//	if(mStoringBufferList) {
//		mStoringBufferList->DeallocateBuffers();
//		delete(mStoringBufferList);
//	}
	
//	mStoringBufferList = CABufferList::New("store buffer", bufClientDesc);
//	mStoringBufferList->AllocateBuffers(numTotalBytes);
	
	storing = false;
}

- (NSRect) frame
{
	return _frame;
}

- (void) Initialize 
{
	_frame = NSMakeRect(0, 0, 800, 600);
	_backgroundColor = [[NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1]retain];
	_lineColor       = [[NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 1]retain];
	
	mNumSlicesTotal = (UInt32) ([self frame].size.width);
	mNumBinsTotal   = (UInt32) ([self frame].size.height);
	
//	mRingBufferCounter = 0;
	mRenderCounter = 0;
	
	[self InitializeBuffers];
}

- (void) dealloc
{
	if (_backgroundColor) [_backgroundColor release];
	if (_lineColor)		  [_lineColor release];
	if (_colormap) free(_colormap);;
	
//	if (mRingBuffer) delete(mRingBuffer);
//	if (mFetchingBufferList) delete(mFetchingBufferList);
//	if (mStoringBufferList) delete(mStoringBufferList);
	
	[super dealloc];
}

// niggerActions

- (void) setLineColor:(NSColor*) color
{
	if (color != _lineColor ) {
		[color retain];
		[_lineColor release];
		_lineColor = color;
	}
	
	[self createColormap: mNumBins];
}

- (void) setBackgroundColor:(NSColor*) color
{
	if ( color != _backgroundColor ) {
		[color retain];
        [_backgroundColor release];
        _backgroundColor =  color;
    }
	[self createColormap: mNumBins];
}

- (bool) storing
{
	return storing;
}

// *** NIGGER DRAWING!!!
- (void) storeSlices: (SonogramOverview*) data
{
	storing = true;
	
	if(mNumBins != data->mNumBins){
		mNumBins = data->mNumBins;
		[self InitializeBuffers];
	}
	
	mNumSlices = data ->mNumSlices;
	
	Float32 linmin = data->mMinAmp;
	Float32 linmax = data->mMaxAmp;
	
	UInt32 numBytesPerRow = mNumBins*4*sizeof(unsigned char); //rgba
	
//	AudioBufferList* mStoringList = &mStoringBufferList->GetModifiableBufferList(); 
//	unsigned char* bitmapImageSliceBits = (unsigned char*) mStoringList->mBuffers[data->mChannel].mData;
	
	Float32 linmag;
	UInt32 index, index1, index2;
	ColorTriplet c;
	
	for (UInt32 j = 0; j < mNumSlices; j++) {
		for (UInt32 i = 0; i < mNumBins; i++) {
			
			index1 = i + j *mNumBins;
			linmag = data->mOverview[index1];
			
			if (isnan(linmag)) linmag = 0.0;
			
			index = [self getIndex: linmag withMin: linmin andMax: linmax andScale: 1.0];
			c = [self getColorWithIndex: index];
			
			index2 = i*4 + j*numBytesPerRow;
			
//			bitmapImageSliceBits[index2  ] = 255;
//			bitmapImageSliceBits[index2+1] = (unsigned char) (255*c.red);
//			bitmapImageSliceBits[index2+2] = (unsigned char) (255*c.green);
//			bitmapImageSliceBits[index2+3] = (unsigned char) (255*c.blue);
		}
	}
	
	//store
	
//	mRingBuffer->Store(mStoringList, mNumSlices, mRingBufferCounter);
	
	storing = false;
}

- (void)drawRect: (NSRect)rect
{
	
	if (!mRingBuffer) return;
	AudioBufferList* fetchBufferList = &mFetchingBufferList->GetModifiableBufferList(); 
	
	// fetch	
	SInt64 newNum = mRingBufferCounter-mRenderCounter;
	mRingBuffer->Fetch(fetchBufferList, mNumSlicesTotal, mRingBufferCounter, true);
	if (!isStaticView)
		mRenderCounter += newNum;
	
	unsigned char* bitmapImageBits = (unsigned char*) fetchBufferList->mBuffers[0].mData;
	
	UInt32 numBytesPerRow = mNumBins*4*sizeof(unsigned char); 
	UInt32 numTotalBytes = mNumSlicesTotal*numBytesPerRow;
	
	NSData* bitmapData = [[NSData alloc] initWithBytesNoCopy:bitmapImageBits length:numTotalBytes freeWhenDone:NO];															
	CIImage* mSpectrumImage = [[CIImage alloc] initWithBitmapData : bitmapData
													  bytesPerRow : numBytesPerRow 
															 size :  CGSizeMake( (Float32) mNumSlicesTotal, (Float32) mNumBins)
														   format : kCIFormatARGB8
													   colorSpace : CGColorSpaceCreateDeviceRGB()];
	
	NSRect drawRect = rect;
	
	// affine transform
	NSRect sonogramImageRect = NSMakeRect(0, 0, mNumSlicesTotal, mNumBins);	
	
	NSAffineTransform* yFlip = [NSAffineTransform transform];
	[yFlip rotateByDegrees: 90];
	[yFlip translateXBy: 0.0 yBy: -sonogramImageRect.size.height];
	
	CIFilter* flipYTransform = [CIFilter filterWithName: @"CIAffineTransform"];	
    [flipYTransform setValue: yFlip forKey: @"inputTransform"];	
    [flipYTransform setValue: mSpectrumImage forKey: @"inputImage"];	
	CIImage* affineOutputImage = [flipYTransform valueForKey: @"outputImage"];
	
	if ([myDistortionButton selectedRow] == 1){		
		CIFilter* bumpDistortion = [CIFilter filterWithName: @"CIBumpDistortion"];
		[bumpDistortion setValue: affineOutputImage forKey: @"inputImage"];
		[bumpDistortion setValue: [CIVector vectorWithX:512 Y:0] forKey: @"inputCenter"];
		[bumpDistortion setValue: [NSNumber numberWithFloat: 512] forKey: @"inputRadius"];
		[bumpDistortion setValue: [NSNumber numberWithFloat: 0.60] forKey: @"inputScale"];
		CIImage* bumpOutputImage = [bumpDistortion valueForKey: @"outputImage"];
		
		[bumpOutputImage drawInRect: drawRect 
						   fromRect:  sonogramImageRect
						  operation: NSCompositeCopy
						   fraction: 1.0];
	}
	else if ([myDistortionButton selectedRow] == 2){ // only on Leopard 
		CIFilter* bumpDistortion = [CIFilter filterWithName: @"CIBumpDistortionLinear"];
		[bumpDistortion setValue: affineOutputImage forKey: @"inputImage"];
		[bumpDistortion setValue: [CIVector vectorWithX:512 Y:0] forKey: @"inputCenter"];
		[bumpDistortion setValue: [NSNumber numberWithFloat: 1024] forKey: @"inputRadius"];
		[bumpDistortion setValue: [NSNumber numberWithFloat: 0.30] forKey: @"inputScale"];
		[bumpDistortion setValue: [NSNumber numberWithFloat: M_PI * 0.5] forKey: @"inputAngle"];
		CIImage* bumpOutputImage = [bumpDistortion valueForKey: @"outputImage"];
		
		[bumpOutputImage drawInRect: drawRect 
						   fromRect:  sonogramImageRect
						  operation: NSCompositeCopy
						   fraction: 1.0];	
	}
	else {
		[affineOutputImage drawInRect: drawRect 
							 fromRect:  sonogramImageRect
							operation: NSCompositeCopy 
							 fraction: 1.0];
	}
	
	[bitmapData release];
	[mSpectrumImage release];
	

}


@end
*/	