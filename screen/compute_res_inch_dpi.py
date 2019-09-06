#!/usr/bin/python3

import math
import sys

(r_w, r_h) = list(map(lambda x: int(x, 10), sys.argv[1].split(' ')))
screen_resolution = round(math.sqrt(r_w * r_w + r_h * r_h))

screen_size_mm = list(map(lambda s: int(s.strip(), 10), list(filter(lambda s: len(s) > 0, sys.argv[2].split(' ')))))

(i_w, i_h) = list(map(lambda x: x / 10 / 2.54, screen_size_mm))
inches = round(math.sqrt(i_w * i_w + i_h * i_h))

dpi = round(screen_resolution / inches)

print("""{}px
{}inch
{}dpi""".format(screen_resolution, inches, dpi))

