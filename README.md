RSPOPPickerSheet
================

Fullscreen pop-able and block-able picker sheet.

#### Control gif video (not clear enough, better try the sample :))
![screenshot](https://raw.githubusercontent.com/yeahdongcn/RSPOPPickerSheet/master/video.gif)

##PROBLEM

In one of my working projects, I need to show a picker view in a UITableViewController's tableView, so I add a picker view as a subview of the tableView. The result is this picker view will be scrolled together with the tableView.

##HOW TO SOLVE THIS

We need a control which can show like modal and block actions, so here comes `UIActionSheet`. And we have to customize the `UIActionSheet` to show the picker view.

As we all know, the `UIActionSheet` can't be dragged into a empty xib, but `UIView` can. so we start with an `UIView` and do the layout and then change the class name of the `UIView` to `UIActionSheet`. That works fine for some `UIView` based controls. 

##MAKE IT POP-ABLE

Use [pop](https://github.com/facebook/pop).

##MAKE IT BLOCK-ABLE

Provide a new `showInView` and `DO NOT` forget to call `[super showInView:view]`

    - (void)showInView:(UIView *)view doneEvent:(ActionEvent)doneEvent cancelEvent:(ActionEvent)cancelEvent
    {
        self.cancel.click = ^(id sender) {
            if (cancelEvent) {
                cancelEvent(self);
            }
            [self dismiss];
        };
        self.done.click = ^(id sender) {
            if (doneEvent) {
                doneEvent(self);
            }
            [self dismiss];
        };
        [super showInView:view];
    }


##License

    The MIT License (MIT)

    Copyright (c) 2012-2014 P.D.Q.

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
    the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
