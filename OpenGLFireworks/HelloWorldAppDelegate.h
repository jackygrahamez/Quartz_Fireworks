//
//  HelloWorldAppDelegate.h
//  OpenGLFireworks
//
//  Created by Jack Shultz on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>

@interface HelloWorldAppDelegate : NSObject {
    
    IBOutlet NSView *theView;
    CALayer *rootLayer;
    CAEmitterLayer *mortor;
}

@property (assign) IBOutlet NSWindow *window;

@end
