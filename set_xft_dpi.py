#!/usr/bin/python3

from subprocess import check_output, run
from math import sqrt
from os import environ
from sys import exit

def get_monitor_informations():
    xrandr_output = check_output(['xrandr']).decode('utf-8')

    search_str = 'connected primary'
    begining_dimensions = xrandr_output.find(search_str) + len(search_str)

    starts_with_dimensions = xrandr_output[begining_dimensions:-1]
    to_end_of_line = starts_with_dimensions.find('\n')

    return starts_with_dimensions[:to_end_of_line]

def get_screen_res(monitor_informations):
    end_of_resolution = monitor_informations.find('+')

    dimensions_as_str = monitor_informations[:end_of_resolution].strip().split('x')
    (width, height) = list(map(lambda x: int(x, 10), dimensions_as_str))

    return round(sqrt(width * width + height * height))

def get_inches(monitor_informations):
    last_parens = monitor_informations.find(')') + 1

    (width, height) = list(map(
        lambda s: round(int(s.replace('m', '').strip(), 10) / 10 / 2.54),
        monitor_informations[last_parens:-1].strip().split('x')))

    return round(sqrt(width * width + height * height))

monitor_informations = get_monitor_informations()
inches = get_inches(monitor_informations)
screen_resolution = get_screen_res(monitor_informations)
dpi = round(screen_resolution / inches)

if dpi < 180:
    xftdpi = "120"
else:
    xftdpi = "200"

xresources_location = environ['HOME'] + '/.Xresources'
ret = run(['sed', '-i', "s/\*Xft\.dpi\: [0-9]*/\*Xft\.dpi\: " + xftdpi + "/", xresources_location]).returncode

if ret != 0:
    print("could not update ~/.Xresources")
    exit(1)

ret = run(['xrdb', xresources_location]).returncode
exit(0)

