These simulations were an attempt to create equilibrated liquid water at 300K using the mW potential. **These simulations are not considered successful or useful**

I began initializing atoms on a diamond lattice, but the lattice would never "melt" no matter how energetic I made the system.
I did however find that slight adjustments to the initial lattice density would alter the pressure of the system accordingly.

I then switched to a bcc lattice which easily melts due to the unfavorable configuration.
However, with this method I found the system to form a liquid-like structure according to the radial distribution function, but it remained in a glassy state as indicated by the lack of change in the mean square displacement of molecules once the system reached 300K.

There are two suggested paths forward:
(1) Try using a nvt thermostate rather than nve, this was suggested because as I am attempting an energy minimization of the system, I should let the energy be free to relax rather than keeping it at a fixed value. This will be carried out in the directory titled "nvt_Thermostat"

(2) Figure out how to add random jitter to the diamond lattice to encourage melting
