//
//  HelloWorldAppDelegate.m
//  OpenGLFireworks
//
//  Created by Jack Shultz on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelloWorldAppDelegate.h"

@implementation HelloWorldAppDelegate

@synthesize window = _window;

- (void)awakeFromNib {
    
    rootLayer = [CALayer layer];
    
    rootLayer.bounds = CGRectMake(0, 0, 640, 480);
    CGColorRef color = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 1);
    rootLayer.backgroundColor = color;
    CGColorRelease(color);
    
    const char* fileName = [[[NSBundle mainBundle] pathForResource:@"spark" ofType:@"png"] UTF8String];
    CGDataProviderRef dataProvider = CGDataProviderCreateWithFilename(fileName);
    id img = (__bridge id)CGImageCreateWithPNGDataProvider(dataProvider, NULL, NO, kCGRenderingIntentDefault);
    
    mortor = [CAEmitterLayer layer];
    mortor.emitterPosition = CGPointMake(320, 0);
    mortor.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell *rocket = [CAEmitterCell emitterCell];
    rocket.emissionLongitude = M_PI / 2;
    rocket.emissionLatitude = 0;
    rocket.lifetime = 1.6;
    rocket.birthRate = 1;
    rocket.velocity = 400;
    rocket.velocityRange = 100;
    rocket.yAcceleration = -250;
    rocket.emissionRange = M_PI / 4;
    color = CGColorCreateGenericRGB(0.5, 0.5, 0.5, 0.5);
    rocket.color = color;
    CGColorRelease(color);
    rocket.redRange = 0.5;
    rocket.greenRange = 0.5;
    rocket.blueRange = 0.5;
    
    CAEmitterCell *flare = [CAEmitterCell emitterCell];
    flare.contents = img;
    flare.emissionLongitude = (4 * M_PI) / 2;
    flare.scale = 0.4;
    flare.velocity = 100;
    flare.birthRate = 45;
    flare.lifetime = 1.5;
    flare.yAcceleration = -350;
    flare.emissionRange = M_PI / 7;
    flare.alphaSpeed = -0.7;
    flare.scaleSpeed = -0.1;
    flare.scaleRange = 0.1;
    flare.beginTime = 0.01;
    flare.duration = 0.7;
    
    CAEmitterCell *firework = [CAEmitterCell emitterCell];
    firework.contents = img;
    firework.birthRate = 9999;
    firework.scale = 0.6;
    firework.velocity = 130;
    firework.lifetime = 2;
    firework.alphaSpeed = -0.2;
    firework.yAcceleration = -80;
    firework.beginTime = 1.5;
    firework.duration = 0.1;
    firework.emissionRange = 2 * M_PI;
    firework.scaleSpeed = -0.1;
    firework.spin = 2;
    
    CAEmitterCell *preSpark = [CAEmitterCell emitterCell];
    preSpark.birthRate = 80;
    preSpark.velocity = firework.velocity * 0.70;
    preSpark.lifetime = 1.7;
    preSpark.yAcceleration = firework.yAcceleration * 0.85;
    preSpark.beginTime = firework.beginTime - 0.2;
    preSpark.emissionRange = firework.beginTime - 0.2;
    preSpark.greenSpeed = 100;
    preSpark.blueSpeed = 100;
    preSpark.redSpeed = 100;
    CAEmitterCell *spark = [CAEmitterCell emitterCell];
    spark.contents = img;
    spark.lifetime = 0.05;
    spark.yAcceleration = -250;
    spark.beginTime = 0.8;
    spark.scale = 0.4;
    spark.birthRate = 10;
    
    preSpark.emitterCells = [NSArray arrayWithObjects:spark, nil];
    rocket.emitterCells = [NSArray arrayWithObjects:flare, firework, preSpark, nil];
    mortor.emitterCells = [NSArray arrayWithObjects:rocket, nil];
    [rootLayer addSublayer:mortor];
    
    [theView setLayer:rootLayer];
    [theView setWantsLayer:YES];
    [theView setNeedsDisplay:YES];
}

@end
