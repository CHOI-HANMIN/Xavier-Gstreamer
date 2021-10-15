#!/bin/bash

gst-launch-1.0 \
v4l2src device=/dev/video2 \
! video/x-raw,format=UYVY ! videoconvert ! videoscale method=0 ! video/x-raw,width=640,height=480 ! alpha alpha=1.0 \
! videobox border-alpha=0 top=0 left=0  \
! compositor name=mix \
sink_0::xpos=0 sink_0::ypos=0 sink_0::alpha=1 sink_0::zorder=0 \
sink_1::xpos=640 sink_1::ypos=0 sink_1::alpha=1 sink_1::zorder=1 \
sink_2::xpos=0 sink_2::ypos=480 sink_2::alpha=1 sink_2::zorder=2 \
sink_3::xpos=640 sink_3::ypos=480 sink_3::alpha=1 sink_3::zorder=3 \
! xvimagesink force-aspect-ratio=false \
v4l2src device=/dev/video3 \
! video/x-raw,format=UYVY ! videoconvert  ! videoscale method=0 ! video/x-raw,width=640,height=480 ! alpha alpha=1.0 \
! videobox border-alpha=0 top=0 left=-0 ! mix.sink_1 \
v4l2src device=/dev/video4 \
! video/x-raw,format=UYVY ! videoconvert  ! videoscale method=0 ! video/x-raw,width=640,height=480 ! alpha alpha=1.0 \
! videobox border-alpha=0 top=-0 left=0 ! mix.sink_2 \
v4l2src device=/dev/video5 \
! video/x-raw,format=UYVY ! videoconvert  ! videoscale method=0 ! video/x-raw,width=640,height=480 ! alpha alpha=1.0 \
! videobox border-alpha=0 top=0 left=0 ! mix.sink_3 
