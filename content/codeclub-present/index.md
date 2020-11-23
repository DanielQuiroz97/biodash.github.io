---
toc: true
---

# Code Club: <br/> Information for Presenters

----

<br>

## Introduction

- Each Code Club session should be represented by one post on the website at <https://biodash.github.io/codeclub/>.

- Regular presenters will be given direct access to the [Github repository](https://github.com/biodash/biodash.github.io)
  and will be able to push a new post to the website directly.

- Occasional presenters can either send their material directly to [Jelmer](mailto:poelstra.1@osu.edu)
  or create a "pull request" with their new post.

- Content should be written in R Markdown (`.Rmd`) or "plain" Markdown (`.md`).
  If you write in `.Rmd`, you need to render to `.md` locally.
  Conversion of `.md` to an HTML file suitable for the website will be done
  automatically upon pushing the master branch of the repository. 

- Make sure to get the session materials onto the website *at least several days before the session*. 
  
<br>

----

## Getting your files onto the site

### 1: Get the repo

You only need to do this if you want to create a pull request or push your content to the website
directly. If you want to send your (R) Markdown file by email, skip this and continue to Step 2.

The following assumes you have git installed (if not, see [these instructions](https://github.com/git-guides/install-git)),
and a Github account (if not, sign up [here](https://github.com/join)).

- Go to a dir that you would like to be the parent dir of the Biodash/Codeclub repo:
  ```sh
  cd my-dir
  ```

- Clone the repo:
  ```sh
  git clone git@github.com:biodash/biodash.github.io.git
  ```

- Move into the newly downloaded repo dir:
  ```sh
  cd biodash
  ```

- Create a new branch (by way of example called "my-branch") and switch to it:
  ```sh
  git checkout -b my-branch
  ```

<br>

----

### 2: Create a post

- Here, we'll use the *hugodown* package to create a Markdown skeleton for our post,
  and below we'll also use *hugodown* to preview the site.
  
  <div class="alert alert-note">
  Note that you can easily bypass <i>hugodown</i> by simply copying the YAML header from
  the first code club session
  (see <a href="https://raw.githubusercontent.com/biodash/biodash.github.io/master/content/codeclub/01_backyard-birds/index.Rmd">here</a>
  for the <code>.Rmd</code> file) into a new file and taking it from there.
  </div>

  If you don't have the *hugodown* package installed, install it:
  ```r
  remotes::install_github("r-lib/hugodown") # Or equivalently, use devtools::install_githhub()
  ```

- A *post bundle* is a separate folder for a post which will hold the R Markdown file
  that contains the post, as well as associated images and so on.
  To create a post bundle along with a R Markdown file that already has many useful YAML header tags:
  ```r
  hugodown::use_post('codeclub/<session-number>_<short-title>')
  # An example would be: hugodown::use_post('codeclub/01_intro-to-R')
  ```
  The `<session-number>` is the actual Code Club session number,
  and `<short-title>` is a short title that you would like to give the post,
  which will be used for links and the folder name.

- Fill out some of the YAML, such as the `title`, `subtitle`, `authors` (in kebab-case, e.g. john-doe,
  to link to your author profile; note that Jelmer's name here is "admin"),
  and optionally `tags` and summary (this will appear on Biodash's front page;
  the default "summary" there can be awkward as it combines headers and paragraphs).

- Write the contents of your Code Club session that you would like to share with participants, in R Markdown format.
  For formatting tips, see [below](/codeclub-present/#format).

- *If you want participants to load an R Markdown file or script:*   
  An easy solution is to place the file in the same directory as your post, and include it in your git commit,
  so it will be uploaded to Github. In that case, the URL to the file for direct downloads for participants will be:
  `https://raw.githubusercontent.com/biodash/biodash.github.io/master/docs/codeclub/<session-number>_<short-title>/<filename>`.   
  
  In your post, include a function call like `file.download(<script-URL>)` for participants to get the file --
  this will work both for participants working locally and those working in an OSC RStudio Server instance.

- *If your session contains a dataset:*   
  Like for the markdown/script, place the file(s) in the same directory as your post.
  If you have a markdown/script for participants, include `file.download(<dataset-URL>)` in this file,
  otherwise include it directly in your post.

- **Convert your `.Rmd` (R Markdown) file to a `.md` (Markdown) file.**   
  
  <div class="alert alert-note">
  Hugo renders <code>.md</code> but not <code>.Rmd</code> to HTML,
  so we have to always render to <code>.md</code> first when writing in <code>.Rmd</code>.
  </div>
  
  Since your output is specified as `hugodown::md_document`,
  this is done most easily by "knitting" your post in RStudio by clicking `Knit` in the top bar,
  or by pressing `Ctrl + Shift + K`.
  
<br>

----

### 3: Preview your post or build the website (optional) {#preview-build}

You can do this in two ways, from RStudio or from the command line.

#### Option A: In RStudio

- Install Hugo:
  ```r
  hugodown::hugo_install("0.66.0")
  ```

- Preview the website:
  ```r
  hugodown::hugo_start()
  ```

#### Option B: From the command line

- Install Hugo using [these instructions](https://gohugo.io/getting-started/installing/).

- Serve the website locally:
  ```sh
  hugo serve
  ```
  You will see a message that includes "*Web Server is available at [...]*".
  Click the link or copy and paste the address into a browser, and you will see the rendered website.
  
  <div class="alert alert-note">
  The server will keep running and will update whenever you save changes in a file
  that is within the website directory, until you stop it using <code>Ctrl + C</code>.
  </div>

#### Side note: Building the website

Note that you don't need to *build* the website,
because it will be built automatically from Markdown files whenever you push to
(the master branch of) the Github repo.

But as background info, or in case automatic builds fail,
here is how you *would* build the site:

- Using Hugo from the shell:
  ```sh
  hugo -d docs/
  ```

- Using *hugodown* in R:  
  ```r
  hugodown::hugo_build(dest = "docs")
  ```

The entire rendered website is in the `docs/` dir; HTML files rendered from Markdown
files will be placed there, any images and other files will be copied there, and so on.

<br>

----

### 4: Commit

- Add the files from your post:
  ```sh
  git add codeclub/<your-post-name>/*
  
  ## Or, e.g. if you added files elswehere too, or have built the site:
  # git add *
  ```

- Check if all your changes and new files have been staged:

  ```sh
  git status
  ```

- Commit:
  ```sh
  git commit -m "Add CodeClub session <session-nr> by <your-name>"
  ```

<br>

----

### 5: Push or submit pull request

Your Markdown (`.md`) file(s) will be built along with the rest of the website by Hugo. 
Using Github Actions, this will be done automatically upon pushing to the master branch on Github,
which is all we need to do.
Note that the built website will be committed by Github Actions not to the master
branch but to the *gh-actions* branch.

#### Option A: Create a pull request

When you create a *pull request*, you are asking the maintainers of a repository
to *pull* your changes into their repository. 

- Push to your branch:
  ```sh
  git push origin my-branch
  ```

- Create the pull request:
  1. Go to the Pull requests page of our repo at <https://github.com/biodash/biodash.github.io/pulls>.
  2. Click the green button on the right that says `New pull request`.
  3. In the grey bar on top, in the button that says `Compare: <branch>`, make sure the branch specified is your branch,
    which we've named `my-branch` in these instructions.
  4. Enter a **title** (e.g. "*New Post: Session 6*") and **description** (say a little more about the post) for the pull request.
  5. Click the green button `Send pull request`.

#### Option B: Push to the site repo (direct access required)

- Merge your branch with the main (master) branch:
  ```sh
  git checkout master       # Move to the master branch prior to merging
  git merge my-branch       # Merge into master (assuming your branch was named "my-branch")
  ```

- Push to the master branch:
  ```sh
  git push origin master
  ```

<br>

----

### 6: Install packages at OSC (optional)

Many R packages are already installed at OSC (nearly 200 for R 4.0.2), including the *tidyverse*.
You can check which packages have been installed by typing, in an R session at OSC:
```r
library()
```

This will list packages by library, which should include two locations available to all
OSC users (starting with `/usr/local/R`), your personal library, and the Code Club library
(`/fs/ess/PAS1838/CODECLUB/Rpkgs`).

If you want to make another package available to Code Club participants, you can do so
as follows in an RStudio Server session at OSC:

```r
install.packages("<pkg-name>", lib = "/fs/ess/PAS1838/CODECLUB/Rpkgs")
```

This library is available to all members of the Code Club OSC classroom project.
To check specifically which packages are available in this library -- and whether your newly
installed package has indeed been installed here, type:

```r
library(lib.loc = "/fs/ess/PAS1838/CODECLUB/Rpkgs")
```

Alternatively, you can let participants working at OSC install the packages themselves,
like participants that work locally will have to do.

<br>

----

## Formatting tips {#format}

### Miscellaneous

- If you want a **Table of Contents** (TOC) for your file, add a line `toc: true` to the `YAML`
  (*not* indented, as it is not an option of the output format).

- ~~Add a line that reads `source_extension: '.Rmd'` (not indented) to your R Markdown,
  which will ensure that there is a link to the source document at the top of your post.~~   
  *EDIT: I have removed these source links for now.
  They were also visible in the "Recent Posts" widget on the home page,
  and some people clicked on that link rather than the website link.
  Then, they ended up on in the Github repo but didn't even know they were
  in the wrong place since the contents of the post is present.*

- To add an image, put it in the same directory as the markdown file,
  and refer to it without prepending a path.

<br>

### Hidden sections

It can be useful to provide solutions to small challenges in the file,
but to hide them by default. This can be done with a little HTML:

````{html}
<details>
<summary>
Solution (click here)
</summary>

<br>
... Your solution - this can be a long section including a code block...
```{r}
install.packages("tidyverse")
```
</details>
````
This is rendered as:
<details>
<summary>
Solution (click here)
</summary>

<br>

... Your solution - this can be a long section including a code block...
  ```{r}
install.packages("tidyverse")
```
</details>

<br>

### Info/alert notes

To produce boxes to draw attention to specific content,
you can use two classes specific to the [Hugo Academic Theme](https://themes.gohugo.io/academic/)
(now branded as ["Wowchemy"](https://wowchemy.com/)).

- `alert-note` for a blue box with an info symbol:

  ```{HTML}
  <div class="alert alert-note">
  This is an alert note.
  </div>
  ```
  
  Which is rendered as:
  
  <div class="alert alert-note">
  This is an alert note.
  </div>

- `alert-warning` for a red box with a warning symbol:
  
   ```{HTML}
  <div class="alert alert-warning">
  This is an alert warning.
  </div>
  ```

  Which is rendered as:

  <div class="alert alert-warning">
  This is an alert warning.
  </div>

- I also added a custom class, "puzzle":
  
  ```{HTML}
  <div class="alert puzzle">
  This is a puzzle div, for do-it-yourself challenges.
  </div>
  ```

  <div class="puzzle">
  This is a puzzle div, for do-it-yourself challenges.
  </div>

  Custom classes and other custom formatting can be written in CSS
  in the `assets/scss/custom.scss` file.

- All of these classes can also be called using pandoc's `:::` notation
  when you're writing in `.Rmd` (but not if you're writing in `.md`), e.g.:

  ```
  :::puzzle
  This is a puzzle div, for do-it-yourself challenges.
  :::
  ```

<br>

### Code highlighting

<div class="alert alert-warning">
<div>
Code highlighting doesn't work with out of the box with <code>.Rmd</code> files.
But it should be possible to get it to work, stay tuned!
</div>
</div>

Hugo supports the highlighting of specific lines of code
using the syntax below in `md` documents:

````
```r {hl_lines=[1,"3-4"]}
library("tidyverse")
weight_df %>%
  mutate(mean_weight = mean(weight)) %>%
  select(mean_weight, everything())
dim(weight_df)
```
````

```r {hl_lines=[1,"3-4"]}
library("tidyverse")
weight_df %>%
  mutate(mean_weight = mean(weight)) %>%
  select(mean_weight, everything())
dim(weight_df)
```

### Shortcodes

<div class="alert alert-warning">
<div>
Like code highlighting, shortcodes only work with <code>.md</code> files.
The <i>blogdown</i> package has a <code>shortcode()</code> function to support them
(see <a href="https://bookdown.org/yihui/blogdown/content.html#shortcode">here</a>,
but <i>hugodown</i> does not support them.
</div>
</div>

Hugo shortcodes are little code snippets for specific content.
Some of these are specific to Wowchemy,
and others are available for any Hugo site.

#### Highlight text

You can highlight text as follows:

```bash
Here is some {{</* hl */>}}highlighted text{{</* /hl */>}}.
```

This will render as:

Here is some {{< hl >}}highlighted text{{< /hl >}}.

#### Icons

Wowchemy supports shortcodes for icons, for instance: 

{{< icon name="r-project" pack="fab" >}}
```bash
{{</* icon name="r-project" pack="fab" */>}}
```

{{< icon name="python" pack="fab" >}}  
```bash
{{</* icon name="python" pack="fab" */>}}
```

{{< icon name="terminal" pack="fas" >}}
```bash
{{</* icon name="terminal" pack="fas" */>}}
```

#### General Hugo shortcodes

- To embed a Youtube video, use the following, replacing "videoID" by the actual ID
  (https://www.youtube.com/watch?v=ID) in 
  ```{bash}
  {{</* youtube ID */>}}
  ```

- To embed a Tweet, use the following, replacing "tweetID" by the actual ID
  (https://twitter.com/user/status/ID): 
    ```{bash}
  {{</* tweet ID */>}}
  ```

For more info and more shortcodes,
see the [Hugo documentation on shortcodes](https://gohugo.io/content-management/shortcodes/).

<br/> <br/> <br/> <br/>
