(scoop export) | sls '^([\w\._-]+) .* \[(.*)\]$' |% { "$($_.matches.groups[2])/$($_.matches.groups[1])" } > scoop.lock

