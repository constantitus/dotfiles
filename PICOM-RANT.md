### The ethernal question. Which compositor ?
\*me ranting about X11 compositors, mostly picom forks\*

## TLDR
None of them are any good. Just use wayland.

## About X11 compositors
If you only care about transparency and a bit of bluring or just straight up doing nothing unless some app asks for transparency, then you should be fine with the vanilla [picom](https://github.com/yshui/picom). But if you want animations, that's when being on X11 is a curse. Unless there's some window manager with a compositor built in, then you're going to have to run a sepparate compositor with animations implemented.
What's wrong with that ? The idea of having the compositor and the window manager as two sepparate programs is flawed. The compositor has to constantly 'guess' what the WM is doing and generate animations based on it's guess, which it sometimes ends up misinterpreting. One thing it cannot figure out is in which direction the workspace you're switching to is. On wayland, if the workspace you're switching to is to the left of the one you're in, the compositor knows that and shows the windows sliding from left to right. Other visual glitches and artifacts happen when you're freely moving a floating window. Animations don't play well with floating windows at all.
A way to fix these issues this is having the WM and compositor somehow communicate or just making the WM and compositor as a single program, just like on wayland.

## Which picom forks have animations
- [jonaburg/picom](https://github.com/jonaburg/picom)\
    Has some very basic animations, but they aren't enough.
    Some other forks have the same animations, but they're mostly the same.
- dccsillag/picom, the [implement-window-animation](https://github.com/dccsillag/picom/tree/implement-window-animations) branch\
    Still very few animations. Nothing special, but it's going to be relevant for the next fork.
- [pijulius/picom](https://github.com/pijulius/picom)\
    This is a fork of dccsillag/picom which has animations for spawning windows, killing windows, changing workspace, flipping, switching, pretty much everything.
    A big issue is that, with the most optimal configuration, it's still very glitchy and doesn't play well with floating windows.
    It also has some issues with rounded corners and borders.
    The fork is pretty much unmentained at this point.
- [kiosion/picom](https://github.com/kiosion/picom)\
    This is forked from pijulius/picom and it has quite a few updates. It doesn't seem to have issues with rounded corners too.
    This seems to be the most up-to-date fork with good animations, so I'm going to stick with this one.

I'm going to update this if I find a better fork or an alternative.
