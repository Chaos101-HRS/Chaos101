globals [sigma rho beta ]
turtles-own [extra-cor]

;The position of the turtles is altert.
to click
  if mouse-inside? and mouse-down? [
    clear-drawing
    if not any? turtles [create]
    ask turtles [
      pu
      set xcor mouse-xcor
      set ycor mouse-ycor
      set extra-cor ycor
      xyz<-- (x + who * 0.1)  y  z
      pd
    ]
  ]
end

;creates the turtles.
to create
  clear-all
  ifelse compare-trajectories
  [ crt 2
    ask turtle 1 [set color violet]
  ]
  [ crt 1]
  ask turtle 0 [set color green]
  reset-ticks
end

to setup
  clear-all
  create
  ;all turtles are initiated at a standard coordinate.
  ask turtles [
    setxy 1 1
    set shape "circle" set size 0.1 pd
    set extra-cor ycor
    xyz<-- (x + who * 0.1)  y  z
  ]
  ;set of parameters, that make different attractors.
  (ifelse
    parameter-setting = "Classic" [
      set sigma 10
      set beta 8 / 3
      set rho 28]
    parameter-setting = "Stretch" [
      set sigma 5.7
      set beta 5.07
      set rho 35.5]
        parameter-setting = "Fixed" [
      set sigma 5.7
      set beta 5.07
      set rho 0.5]
    [
      set sigma 20
      set rho 18.9
      set beta 0.91
  ])
end

;the lorenz equation is applied iteratively.
to run-simulation
  if not any? turtles[setup]
  ask turtles
   [xyz<-- x + (  sigma * (y - x)    ) / 100 ;; small step size: fine lines
           y + (  x * (rho - z) - y  ) / 100
           z + (  x * y - beta * z   ) / 100 ]
  wait 0.02
   tick
end

;simplified syntax, and scaling to use fewer patches

to-report x report xcor * 10 end
to-report z report ycor * 10 end
to-report y report extra-cor * 10 end

to   xyz<-- [new-x new-y new-z]
  setxy new-x / 10    new-z / 10
  set extra-cor new-y / 10
end
@#$#@#$#@
GRAPHICS-WINDOW
255
10
747
503
-1
-1
69.143
1
10
1
1
1
0
1
1
1
-3
3
0
6
0
0
1
ticks
30.0

BUTTON
10
10
250
60
Setup
setup
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
10
310
250
343
Run simulation
run-simulation
T
1
T
OBSERVER
NIL
R
NIL
NIL
1

SWITCH
10
120
250
153
compare-trajectories
compare-trajectories
0
1
-1000

BUTTON
10
180
250
215
Choose initial coordinates on mouse click
click
T
1
T
OBSERVER
NIL
C
NIL
NIL
1

CHOOSER
10
240
250
285
parameter-setting
parameter-setting
"Classic" "Stretch" "Fixed" "Periodic"
0

TEXTBOX
15
60
245
105
Press setup after you have selected new values. Setup does not have to be pressed after selecting initial variables on the screen. 
11
0.0
1

@#$#@#$#@
## WHAT IS IT?

This model shows the evolutionary trajectory of the lorenz attractor. With only three equations, lorenz made a model of rolling fluid convection, which is essentially the way hot air interacts with cold air.

The equations he came up with are:

(1) dx/dt = sigma * (y - x)

(2) dy/dt = x * (rho - z) - y

(3) dz/dt = x * y - beta * z

Here sigma represents the ratio of fluid viscosity to thermal conductivity, rho represents the difference in temperature between the top and bottom of the system and beta is the ratio of box width to box height. These three parameters are fixed. The variables that change over time are x, y and z. Thay represent the convective motion, temperature difference and temperature distortion, respectively.

## HOW IT WORKS

The Lorenz system, is an example of a flow, which means that time
and space is continuous in the system, rather than discrete. Flows are given by differential equations of the form dx/dt = f(t). Given a state xt at time t, the state at time t + ???t is x(t+???t) = xt + ???t * dx/dt

## HOW TO USE IT

1. Turn the 'compare-trajectories' function on, to see what happens to two starting points with slightly differerent initial coordinates.
2.  Now select the ???Choose initial coordinates on mouse click??? button. This enables you to place the white ball anywhere on the screen. As long as ???Choose initial coordinates on mouse click??? is selected, you can keep placing the white circle somewhere on the screen.
3. Choose one of the pre-made parameter settings. This will intantiate sigma, rho and beta parameters.
4. Press the ???Setup??? button, to save all settings.
5. Press ???Run simulation??? to see a visualisation of how the lorenz equations evolve over time.

## THINGS TO NOTICE

Although it may look like a trajectory crosses at certain points, it actually goes over or under itself, which would be visible in a 3D model. If a trajectory were to cross itself at some point, it would make a periodic motion. Since the rules are completely deterministic, each input has a unique output. For a map, this is not an issue since the system only operates in discrete time steps and thus never crosses its own trajectory, as long as it never returns to a previously visited state. For a flow, however, this is more problematic. For one- and two-dimensional flows, the only possibility to satisfy this criterion is to keep diverging away from its own trajectory. But then the system would disobey the criterion of ergodicity. Thus, the only way a flow can be chaotic is if it has three or more dimensions. So, the 'real' lorenz attractor has three dimensions, x, y and z. However, in this model only the bahavior along the x-axis and z-axis is shown, for practical reasons. The y coordinate is still calculated each time, because it influences the x and z value, as can be seen in equations (1) and (3). When choosing the initial coordinates, by clicking on the screen, the y-coordinate is set the same as the z-coordinate. 

Furthermore, some combinations of settings make that the trajectory leaves the screen and returns through the other side. This is because the screen wraps around it self. Meaning that the top and bottom are connected, as well as the left and the right.

There are a few fixed values, that the user cannot change: 

- The intial difference between the two starting points, when 'compare-trajectories' is turned on is 0.1 along the x-axis. An even smaller difference would also work, but is would take longer to see the trajectories diverging. 
- There are 4 pre-made sets of parameter values. 
	- Classic shows the well known chaotic lorenz attractor. The parameter values are: sigma = 10; beta = 8 / 3; rho = 28
	- Stretch shows a stretched version of the chaotic attractor, the overall shape can still be recognised. The parameter values are: sigma = 5.7; beta = 5.07; rho = 35.5
	- Fixed shows a fixed point attractor. The parameter values are: sigma = 5.7; beta = 5.07; rho = 0.5
	- Periodic shows a periodic attractor. The parameter values are: sigma = 120; beta = 18.9; rho = 0.91

## THINGS TO TRY

You may have seen that when you start the simulation with two slightly different starting points, two totally differnt trajectories appear. Now try the 'compare trajectories' function in combination with the periodic parameter setting. What do you notice now?

## CREDITS AND REFERENCES

Iapascurta, V. Lorenz Attractor 3D -- NetLogo Modeling Commons. Modelingcommons. http://modelingcommons.org/browse/one_model/5260#model_tabs_browse_info

Moler, C. (2014). Periodic Solutions to the Lorenz Equations. Cleve??s Corner: Cleve Moler on Mathematics and Computing. https://blogs.mathworks.com/cleve/2014/04/28/periodic-solutions-to-the-lorenz-equations/

Flake, G. W. (2000). The Computational Beauty of Nature (New edition). Amsterdam University 
Press.


---

This model was based on the Lorenz Attractor model by the Santa Fe Institute's Complexity explorer, and then adapted to fit the purposes of our project. You can find the Netlogo3D file of the Complexity Explorer model at https://www.complexityexplorer.org/explore/virtual-laboratory/127-lorenz-attractor.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
