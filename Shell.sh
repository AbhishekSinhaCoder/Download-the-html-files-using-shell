cat 1.html | grep "<td" | grep href | cut -d '"' -f2 | sed  -E "s/\/products/https:\/\/www.spc.noaa.gov\/products/g" > links.txt