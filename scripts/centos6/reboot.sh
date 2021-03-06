#!/bin/bash

printf "Updates have been applied.\n"
printf "Rebooting onto the newly installed kernel of popcorn. Yummy.\n"

# If the network interface doesn't properly shutdown, the provisioner may hang, 
# so we stop the interface manually.  
#service network stop

# Schedule a reboot, but give the computer time to cleanly shutdown the 
# network interface first.
$(shutdown -r +1) &

# To prevent the next provisioning script from launching during the reboot
# process a sleep directive is issued blocking the return of this script.
# sleep 300
