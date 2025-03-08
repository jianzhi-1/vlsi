* Title line (the first line is not run"
.lib '/home/.../model.lib.spice' 'tt'
.include '/home/.../model.spice'

.subckt sub D VGND VPWR Q
// ...
.ends

// global voltage variables
vvdd vdd 0 1.8
vgnd vss 0 0
vin a 0 0 PULSE(0 1.8 0 10p 10p 2n 4n)

// components
xsub a vss vdd y sub

// capacitors and resistors
C0 y vss 5E-16

// simulate
.tran 10p 4n
.ic y 1.8
// initial configurations

.probe v(a) v(y)
.meas tran tplh trig v(a) val='1.8/2' rise=1 targ v(y) val='1.8/2' fall=1
.meas tran vdd_power AVG power from=0ns to=4ns
.meas tran t_input_slew trig v(a) val='1.8*0.1' rise=1 targ v(a) val='1.8*0.9' rise=1

.END
