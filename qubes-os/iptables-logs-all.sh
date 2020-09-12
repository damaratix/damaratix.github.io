#!/bin/bash
# from qubes-users

function addLogRules
{
  table="unknown"
  while read line
  do
    if [[ $line =~ ^\*([a-zA-Z_\-]*)$ ]]
    then
      echo "$line"
      table=${BASH_REMATCH[1]}
    elif [[ $line =~ ^-A\ ([a-zA-Z_\-]*)(\ .*)?\ -j\ (LOG|REJECT|DROP|ACCEPT).*$ ]]
    then
      chain=${BASH_REMATCH[1]}
      rule=${BASH_REMATCH[2]}
      action=${BASH_REMATCH[3]}
      if [ "$action" != "LOG" ]
      then
        echo "-A ${chain}${rule} -j LOG --log-prefix \"${table}-${chain}-${action}: \""
        echo "$line"
      fi
    else
      echo "$line"
    fi
  done
}
