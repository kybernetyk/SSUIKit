//
//  vecLibSample.m
//  GFX_Edit_View
//
//  Created by Simoon on 27.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "vecLibSample.h"


@implementation vecLibSample

- (void)doShit
{
	NSLog(@"doint vecLibShit: \n");
	NSLog(@"**************************************************");
	NSLog(@"      Use of VecLib simple function such as       ");
	NSLog(@"     vector addition, substruction, multiply,     ");
	NSLog(@"             square dot product. \n               ");
	NSLog(@"**************************************************");
	
	float *inputOne, *inputTwo, *result, dotProduct;
	int32_t strideOne, strideTwo, resultStride;
	uint32_t i, size;
	
	size = 1024; 
	NSLog(@"size: %i", size);
	
	inputOne = (float*)malloc(size*sizeof(float));
	inputTwo = (float*)malloc(size*sizeof(float));
	result   = (float*)malloc(size*sizeof(float));
	
	NSLog(@"inputOne: %f, inputTwo:%f, result:%f", inputOne, inputTwo, result);
	
	if (inputOne == NULL || inputTwo == NULL || result == NULL)
	{
		NSLog(@"malloc failed to allocate memory : /");
		return;
	} else {
		NSLog(@"everything's ok with memory allocating"); 
	}
	
	NSLog(@"Set the input arguments of length 'size' to:");
	NSLog(@"[1, ... ,1] and [2, ..., 2]");
	NSLog(@"\n");
	
	for (i = 0; i < size; i++)
	{
		inputOne[i] = 1.0;
		inputTwo[i] = 2.0;
		
		NSLog(@"inputOne[%i] = %f", i, inputOne);
		NSLog(@"inputTwo[%i] = %f", i, inputTwo);
	}
	
	strideOne = strideTwo = resultStride = 1;
	NSLog(@"strideOne: %i, strideTwo: %i, resultStride: %i", strideOne, strideTwo, resultStride);
	
	NSLog(@"\n Add the inputvectors 'inputOne' and 'inputTwo'");
	NSLog(@"The result is returned in teh vector 'result");
	
	vDSP_vadd(inputOne, strideOne, inputTwo, strideTwo, result, resultStride, size);
	
	NSLog(@"\n the result of the substruction is: ");
	for(i=0; i< size; i++)
	{
		NSLog(@"%f \n", result[i]);
	}
	
}

- (void)release
{
	NSLog(@"zomg, i'm dying! \n");
	[super release];
}

-(void)dealloc
{
	NSLog(@"zomg, i'm dead! \n");
	[super dealloc];
}
@end
