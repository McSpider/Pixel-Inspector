//
//  Pixel_InspectorAppDelegate.m
//  Pixel Inspector
//
//  Created by Ben K on 2011/08/12.
//  All code is provided under the New BSD license.
//

#import "Pixel_InspectorAppDelegate.h"

@implementation Pixel_InspectorAppDelegate

@synthesize window;

- (void)awakeFromNib
{  
  hue = 8;
  saturation = 4;
  colorMode = NO;
  [[self window] center];
  [[self window] setFrameOrigin:NSMakePoint(self.window.frame.origin.x, [[NSScreen mainScreen] frame].size.height * 0.4)];
  //[[self window] setLevel:NSNormalWindowLevel];
  
  fullWindow = [[TransparentWindow alloc] initWithContentRect:[[NSScreen mainScreen] frame]
                                                     styleMask:NSBorderlessWindowMask
                                                       backing:NSBackingStoreBuffered
                                                         defer:NO screen:[NSScreen mainScreen]];
  
  [fullWindow setLevel:NSScreenSaverWindowLevel];
  [fullWindow setIsMovable:NO];

  [fullView setWantsLayer:YES];
  [fullView setDelegate:self];
  
  [fullWindow setContentView:fullView];
  [fullWindow setAlphaValue:0.0f];
  [fullWindow orderFront:nil];
  [fullWindow setDelegate:self];  
  
  //[self.window makeKeyAndOrderFront:self];
}

- (void)dealloc
{
  [fullWindow release];
  [super dealloc];
}


- (void)windowDidResignKey:(NSNotification *)notification
{
  if ([notification object] == fullWindow && [fullWindow alphaValue] == 1.0f) {
    [self closeColorWindow];
  }
}

- (void)applicationDidResignActive:(NSNotification *)notification
{
  if ([fullWindow alphaValue] == 1.0f) {
    [self closeColorWindow];
  }
}


- (IBAction)testColor:(id)sender
{
  [infoMessage setHidden:YES];
  
  int tag = (int)[sender tag];
  if (tag == 0) {
    [fullWindow setBackgroundColor:[NSColor redColor]];
  }
  else if (tag == 1) {
    [fullWindow setBackgroundColor:[NSColor greenColor]];
  }
  else if (tag == 2) {
    [fullWindow setBackgroundColor:[NSColor blueColor]];
  }
  else if (tag == 3) {
    [fullWindow setBackgroundColor:[NSColor whiteColor]];
  }
  else if (tag == 4) {
    [fullWindow setBackgroundColor:[NSColor blackColor]];
  }
  else if (tag == 5) {
    if ([infoMessage alphaValue] != 0.0f) {
      [infoMessage setHidden:NO];
      [self performSelector:@selector(hideInfoMessage) withObject:nil afterDelay:4];
    }
    [fullWindow setBackgroundColor:[NSColor colorWithDeviceHue:hue / 16.0f saturation:saturation / 4.0f brightness:1.0 alpha:1.0]];
    colorMode = YES;
  }

  [fullWindow makeKeyAndOrderFront:self];
  [[fullWindow animator] setAlphaValue:1.0f];
  [fullView becomeFirstResponder];
  [NSCursor hide];
}

- (void)closeColorWindow;
{
  [NSCursor unhide];
  [[fullWindow animator] setAlphaValue:0.0f];
  colorMode = NO;
}

- (void)hideInfoMessage
{
  [[infoMessage animator] setAlphaValue:0.0f];
}

- (void)changeViewColor:(uint)color;
{
  if (!colorMode)
    return;
  
  if (color == 1) {
    saturation = saturation - 1;
    if (saturation <= 0)
      saturation = 0;
  }
  else if (color == 2) {
    saturation = saturation + 1;
    if (saturation >= 4)
      saturation = 4;
  }
  else if (color == 3) {
    hue = (hue - 1) % 16;
    if (hue < 0)
      hue = 16;
  }
  else if (color == 4) {
    hue = (hue + 1) % 16;
  }
  
  [fullWindow setBackgroundColor:[NSColor colorWithDeviceHue:hue / 16.0f saturation:saturation / 4.0f brightness:1.0 alpha:1.0]];
}


#pragma mark -
#pragma mark Delegate View Messages

- (void)viewKeyUp:(NSEvent *)theEvent
{
  uint key = 0;
  
  NSString *character = [theEvent charactersIgnoringModifiers];
  unichar code = [character characterAtIndex:0];
  
  switch (code)  {
    case NSUpArrowFunctionKey: {
      key = 1;
      break;
    }
    case NSDownArrowFunctionKey: {
      key = 2;
      break;
    }
    case NSLeftArrowFunctionKey: {
      key = 3;
      break;
    }
    case NSRightArrowFunctionKey: {
      key = 4;
      break;
    }
    case 27: { // Escape key
      if ([fullWindow alphaValue] == 1.0f)
        [self closeColorWindow];
      break;
    }
  }
  
  if (key != 0)
    [self changeViewColor:key];
}

- (void)viewMouseUp:(NSEvent *)theEvent
{
  [self closeColorWindow];
}


@end
