# Download-the-html-files-using-shell

Visit https://www.spc.noaa.gov/archive/ and enter start date as 23 Jan, 2003 (20201002) and today as the end date (20201002) under convective outlooks. When you press on Retrieve outlooks button, you are redirected to [this](https://www.spc.noaa.gov/cgi-bin-spc/getacrange.pl?date0=20030123&date1=20201002) page. Use wget to save the HTML (I called this 1.html)

Next run the following "command" to fetch all the download URLs.
```
cat 1.html | grep "<td" | grep href | cut -d '"' -f2 | sed  -E "s/\/products/https:\/\/www.spc.noaa.gov\/products/g" > links.txt
```

The explanation is given below
```
cat 1.html
```
This literally prints out the contents of the file to the terminal. The "|" character specifies the file contents (output) to be passed to the next "command" as an input.
```
grep "<td"
```
This will search for all HTML <td> elements i.e the rows of a table (some of these contain links to the required outlooks)
```
grep href
```
This is to filter the rows that contain "href" and therefore links to the outlooks.
```
cut -d '"' -f2
```
This is a tad tricky but here goes. Up until the previous "command" (grep href) rows like this are matched.
```
<tr><td><a href="/products/outlook/archive/2017/day3otlk_20171028_0730-shp.zip">day3otlk_20171028_0730-shp.zip</a></td></tr>
```
The cut command specifies the string to be split at the " character and print the second column. The output would thus be
```
/products/outlook/archive/2017/day3otlk_20171028_0730-shp.zip
```
The sed command changes the output above to

https://www.spc.noaa.gov/products/outlook/archive/2017/day3otlk_20171028_0730-shp.zip
This is written to output file (links.txt) using the redirect operator >

Finally I had to remove the first 3 lines because they were random URLs.

***

The above mentioned process is an fairly uncommon way of web scraping which takes advantage of standard UNIX utilities. Ofc, you could have used python or any random web scraping browser extension to do all this.
