TCSH Cheat Sheet
=

Set an alias
-

    alias myalias ls -lah

Switch user to bash
-

In .tcsh_profile, just do:

/bin/bash -c '/bin/bash && source /homedir/pakey/.bash_profile'

for loop and if-then-else Examples
- 

    #!/bin/tcsh -f

    set val = 0
    foreach scen ( a b )
      echo $scen
      if ($scen == a) then
        echo $scen
      else
        echo $val
      endif
    end


