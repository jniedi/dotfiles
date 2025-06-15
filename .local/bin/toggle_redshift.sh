#!/usr/bin/env zsh


TFILE=~/.cache/redshift_toggle

if [ -f $TFILE ]; then 
     redshift -PO 3500
     rm $TFILE
 else
     redshift -PO 2500
     touch $TFILE
fi

