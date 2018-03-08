# Software

## R packages

We'll use two packages for interacting with git and GitHub through R.

- [gh](https://github.com/r-lib/gh): is a thin-wrapper around the [GitHub API](https://developer.github.com/v3/). This is used to query and update anything on GitHub.
- [git2r](https://github.com/ropensci/git2r) is a package for working with git repositories directly in R, e.g. cloning, pulling, pushing, commiting.

## Tokens

Tokens can be used instead of passwords. You should use one token per application.
Unlike the password to your account, you can give different tokens different permissions
and also revoke them.

- [Instructions for setting up a token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)


- Navigate to [Settings > Developer Settings > Personal access tokens](https://github.com/settings/tokens)
- Click on [Generate new token](https://github.com/settings/tokens/new)
- Give the token an informative description - e.g. "R on my laptop"
- Select the necessary scopes. Generally, security advice is to select the least 
    number of things you'll need to use the token for. In particular, avoid
    giving unnessary ability to delete/edit things unless you need it. If you 
    find you need a scope in the future, you can always edit
- Copy the token. It will be a long string of random numbers and letters.
    **YOU WILL ONLY BE SHOWN THE TOKEN ONCE** After that, all
    you can do is edit the scopes or delete it.
- The proper place to store the token for R is in the `GITHUB_PAT` environment variable,  
    preferrably set in the `.Renviron` file.
    The `.Renviron` file sets environment variables before R is started.
    See `?Startup` or [Efficient R Programming](https://csgillespie.github.io/efficientR/r-startup.html#the-location-of-startup-files) for more details on `.Renviron` and the other files R loads at startup.
    After either locating or creating the `.Renviron` file in the proper location should add a line like the follwing (but with your token):
    ```
    GITHUB_PAT="whatever_the_token_is"
    ```
    *Note* you can use the function `edit_r_environ` in the **usethis** package to
    find and open your `.Renviron` file.
    
- **DO NOT UNDER ANY CIRCUSTANCE COMMIT A PERSONAL ACCESS TOKEN TO GIT** It is 
    like sharing a password. Someone will steal it, and bad things will happen.

## SSH Keys

It'll can also be useful to use a SSH key to access GitHub instead of a password.

1. Got https://github.com/settings/keys
