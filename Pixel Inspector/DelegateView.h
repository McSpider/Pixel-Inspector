//
//  DelegateView.h
//  Pixel Inspector
//
//  Created by Ben K on 12/06/19.
//  All code is provided under the New BSD license.
//

#import <Cocoa/Cocoa.h>

@protocol DelegateViewDelegate
@optional

- (void)closeColorWindow;
- (void)changeViewColor:(uint)key;

@end

@interface DelegateView : NSView {
  IBOutlet id delegate;
}

@property (nonatomic, assign) id delegate;

@end
