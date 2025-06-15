#!/usr/bin/env python3


import os
from subprocess import call


def error(msg):
    print(msg)
    exit(1)



call(["notify-send","HELLO THERE","THIS IS THE MSG"])
