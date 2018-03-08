# 2018
Website for University of Washington: POLS 501 "Advanced Political Research Design and Analysis" (Winter 2018)


This website built using [blogdown](https://github.com/rstudio/blogdown) and [Hugo](https://gohugo.io/). See the blogdown instructions
for how to compile and build.

# Build

To build and serve site locally:
```r
blogdown:::serve_site()
```

# Miscellaneous

To check links of compiled HTML (requires [broken-link-checker](https://www.npmjs.com/package/broken-link-checker)),
and the site must be serving on port `4321`:
```console
make check-links
```

To check for errors in the compiled HTML (require [HTMLHint](https://github.com/yaniswang/HTMLHint))
```console
$ make check-html
```

To check the spelling of compiled HTML (requires hunspell)
```console
$ make check-spelling
```
