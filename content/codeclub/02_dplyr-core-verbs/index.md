---
title: "Session 2: dplyr core verbs"
subtitle: "Using select, filter, mutate, arrange, and summarize"
summary: "During this second session of Code Club, we will be learning how to use some of the most popular dplyr one-table functions, including filter, select, mutate, arrange, and summarize."  
authors: [jessica-cooperstone]
date: "2020-11-30"
output: hugodown::md_document
toc: true

image: 
  caption: "Artwork by @allison_horst"
  focal_point: ""
  preview_only: false

rmd_hash: 30e14b3d167e8e1d

---

<br> <br> <br>

------------------------------------------------------------------------

Prep homework
-------------

### Basic computer setup

-   If you didn't already do this, please follow the [Code Club Computer Setup](/codeclub-setup/) instructions, which also has pointers for if you're new to R or RStudio.

-   If you're able to do so, please open RStudio a bit before Code Club starts -- and in case you run into issues, please join the Zoom call early and we'll troubleshoot.

### New to dplyr?

If you've never used `dplyr` before (or even if you have), you may find [this cheat sheet](https://github.com/rstudio/cheatsheets/blob/master/data-transformation.pdf) useful.

<br>

------------------------------------------------------------------------

Getting Started
---------------

### Want to download an R script with the content from today's session?

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># directory for Code Club Session 2:</span>
<span class='nf'><a href='https://rdrr.io/r/base/files2.html'>dir.create</a></span><span class='o'>(</span><span class='s'>"S02"</span><span class='o'>)</span>

<span class='c'># directory for our script</span>
<span class='c'># ("recursive" to create two levels at once.)</span>
<span class='nf'><a href='https://rdrr.io/r/base/files2.html'>dir.create</a></span><span class='o'>(</span><span class='s'>"S02/scripts/"</span><span class='o'>)</span>

<span class='c'># save the url location for today's script</span>
<span class='nv'>todays_R_script</span> <span class='o'>&lt;-</span> <span class='s'>'https://raw.githubusercontent.com/biodash/biodash.github.io/master/content/codeclub/02_dplyr-core-verbs/2_Dplyr_one-table_verbs.R'</span>

<span class='c'># indicate the name of the new script file</span>
<span class='nv'>Session2_dplyr_core</span> <span class='o'>&lt;-</span> <span class='s'>"S02/scripts/Session2_script.R"</span>

<span class='c'># go get that file! </span>
<span class='nf'><a href='https://rdrr.io/r/utils/download.file.html'>download.file</a></span><span class='o'>(</span>url <span class='o'>=</span> <span class='nv'>todays_R_script</span>,
              destfile <span class='o'>=</span> <span class='nv'>Session2_dplyr_core</span><span class='o'>)</span>
</code></pre>

</div>

<br>

------------------------------------------------------------------------

1 - What is data wrangling?
---------------------------

It has been estimated that the process of getting your data into the appropriate formats takes about 80% of the total time of analysis. We will talk about formatting as tidy data (e.g., such that each column is a single variable, each row is a single observation, and each cell is a single value, you can learn more about tidy data [here](https://r4ds.had.co.nz/tidy-data.html)) in a future session of Code Club.

The package [`dplyr`](https://dplyr.tidyverse.org/), as part of the [`tidyverse`](https://www.rdocumentation.org/packages/tidyverse/versions/1.3.0) has a number of very helpful functions that will help you get your data into a format suitable for your analysis.

<br>

<div class="alert alert-note">

<div>

**What will we go over today**

These five core `dplyr()` verbs will help you get wrangling.

-   [`select()`](https://dplyr.tidyverse.org/reference/select.html) - picks variables (i.e., columns) based on their names
-   [`filter()`](https://dplyr.tidyverse.org/reference/filter.html) - picks observations (i.e., rows) based on their values
-   [`mutate()`](https://dplyr.tidyverse.org/reference/mutate.html) - makes new variables, keeps existing columns
-   [`arrange()`](https://dplyr.tidyverse.org/reference/arrange.html) - sorts rows based on values in columns
-   [`summarize()`](https://dplyr.tidyverse.org/reference/summarise.html) - reduces values down to a summary form

</div>

</div>

<br>

------------------------------------------------------------------------

2 - Get ready to wrangle
------------------------

**Let's get set up and grab some data so that we can get familiar with these verbs**

-   You can do this locally, or at OSC. You can find instructions if you are having trouble [here](/codeclub-setup/).

First load your libraries.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='http://tidyverse.tidyverse.org'>tidyverse</a></span><span class='o'>)</span>

<span class='c'>#&gt; ── <span style='font-weight: bold;'>Attaching packages</span><span> ─────────────────────────────────────── tidyverse 1.3.0 ──</span></span>

<span class='c'>#&gt; <span style='color: #00BB00;'>✔</span><span> </span><span style='color: #0000BB;'>ggplot2</span><span> 3.3.2     </span><span style='color: #00BB00;'>✔</span><span> </span><span style='color: #0000BB;'>purrr  </span><span> 0.3.4</span></span>
<span class='c'>#&gt; <span style='color: #00BB00;'>✔</span><span> </span><span style='color: #0000BB;'>tibble </span><span> 3.0.4     </span><span style='color: #00BB00;'>✔</span><span> </span><span style='color: #0000BB;'>dplyr  </span><span> 1.0.2</span></span>
<span class='c'>#&gt; <span style='color: #00BB00;'>✔</span><span> </span><span style='color: #0000BB;'>tidyr  </span><span> 1.1.2     </span><span style='color: #00BB00;'>✔</span><span> </span><span style='color: #0000BB;'>stringr</span><span> 1.4.0</span></span>
<span class='c'>#&gt; <span style='color: #00BB00;'>✔</span><span> </span><span style='color: #0000BB;'>readr  </span><span> 1.4.0     </span><span style='color: #00BB00;'>✔</span><span> </span><span style='color: #0000BB;'>forcats</span><span> 0.5.0</span></span>

<span class='c'>#&gt; ── <span style='font-weight: bold;'>Conflicts</span><span> ────────────────────────────────────────── tidyverse_conflicts() ──</span></span>
<span class='c'>#&gt; <span style='color: #BB0000;'>✖</span><span> </span><span style='color: #0000BB;'>dplyr</span><span>::</span><span style='color: #00BB00;'>filter()</span><span> masks </span><span style='color: #0000BB;'>stats</span><span>::filter()</span></span>
<span class='c'>#&gt; <span style='color: #BB0000;'>✖</span><span> </span><span style='color: #0000BB;'>dplyr</span><span>::</span><span style='color: #00BB00;'>lag()</span><span>    masks </span><span style='color: #0000BB;'>stats</span><span>::lag()</span></span>
</code></pre>

</div>

Then let's access the [iris](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/iris.html) dataset that comes pre-loaded in base R. We will take that data frame and assign it to a new object called `iris_data`. Then we will look at our data.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_data</span> <span class='o'>&lt;-</span> <span class='nv'>iris</span>

<span class='c'># look at the first 6 rows, all columns</span>
<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>iris_data</span><span class='o'>)</span>

<span class='c'>#&gt;   Sepal.Length Sepal.Width Petal.Length Petal.Width Species</span>
<span class='c'>#&gt; 1          5.1         3.5          1.4         0.2  setosa</span>
<span class='c'>#&gt; 2          4.9         3.0          1.4         0.2  setosa</span>
<span class='c'>#&gt; 3          4.7         3.2          1.3         0.2  setosa</span>
<span class='c'>#&gt; 4          4.6         3.1          1.5         0.2  setosa</span>
<span class='c'>#&gt; 5          5.0         3.6          1.4         0.2  setosa</span>
<span class='c'>#&gt; 6          5.4         3.9          1.7         0.4  setosa</span>


<span class='c'># check the structure of iris_data</span>
<span class='nf'>glimpse</span><span class='o'>(</span><span class='nv'>iris_data</span><span class='o'>)</span>

<span class='c'>#&gt; Rows: 150</span>
<span class='c'>#&gt; Columns: 5</span>
<span class='c'>#&gt; $ Sepal.Length <span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4, 4.6, 5.0, 4.4, 4.9, 5.4, 4…</span></span>
<span class='c'>#&gt; $ Sepal.Width  <span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1, 3.7, 3…</span></span>
<span class='c'>#&gt; $ Petal.Length <span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.5, 1.4, 1.5, 1.5, 1…</span></span>
<span class='c'>#&gt; $ Petal.Width  <span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0…</span></span>
<span class='c'>#&gt; $ Species      <span style='color: #555555;font-style: italic;'>&lt;fct&gt;</span><span> setosa, setosa, setosa, setosa, setosa, setosa, setosa, …</span></span>
</code></pre>

</div>

This dataset contains the measurements (in cm) of `Sepal.Length`, `Sepal.Width`, `Petal.Length`, and `Petal.Width` for three different `Species` of iris, *setosa*, *versicolor*, and *virginica*.

<br>

------------------------------------------------------------------------

3 - Using `select()`
--------------------

`select()` allows you to pick certain columns to be included in your data frame.

We will create a dew data frame called iris\_petals\_species that includes the columns `Species`, `Petal.Length` and `Petal.Width`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_petals_species</span> <span class='o'>&lt;-</span> <span class='nv'>iris_data</span> <span class='o'>%&gt;%</span>
  <span class='nf'>select</span><span class='o'>(</span><span class='nv'>Species</span>, <span class='nv'>Petal.Length</span>, <span class='nv'>Petal.Width</span><span class='o'>)</span>
</code></pre>

</div>

What does our new data frame look like?

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>iris_petals_species</span><span class='o'>)</span>

<span class='c'>#&gt;   Species Petal.Length Petal.Width</span>
<span class='c'>#&gt; 1  setosa          1.4         0.2</span>
<span class='c'>#&gt; 2  setosa          1.4         0.2</span>
<span class='c'>#&gt; 3  setosa          1.3         0.2</span>
<span class='c'>#&gt; 4  setosa          1.5         0.2</span>
<span class='c'>#&gt; 5  setosa          1.4         0.2</span>
<span class='c'>#&gt; 6  setosa          1.7         0.4</span>
</code></pre>

</div>

**Note - look what happened to the order of the columns!**

<div class="alert alert-note">

**This is not the only way to select columns.**

You could also subset by indexing with the square brackets, but you can see how much more readable using `select()` is. It's nice not to have to refer back to remember what column is which index.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_data_indexing</span> <span class='o'>&lt;-</span> <span class='nv'>iris_data</span><span class='o'>[</span>,<span class='m'>3</span><span class='o'>:</span><span class='m'>5</span><span class='o'>]</span>

<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>iris_data_indexing</span><span class='o'>)</span>

<span class='c'>#&gt;   Petal.Length Petal.Width Species</span>
<span class='c'>#&gt; 1          1.4         0.2  setosa</span>
<span class='c'>#&gt; 2          1.4         0.2  setosa</span>
<span class='c'>#&gt; 3          1.3         0.2  setosa</span>
<span class='c'>#&gt; 4          1.5         0.2  setosa</span>
<span class='c'>#&gt; 5          1.4         0.2  setosa</span>
<span class='c'>#&gt; 6          1.7         0.4  setosa</span>
</code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_data_c</span> <span class='o'>&lt;-</span> <span class='nv'>iris_data</span><span class='o'>[</span>,<span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Petal.Length"</span>, <span class='s'>"Petal.Width"</span>, <span class='s'>"Species"</span><span class='o'>)</span><span class='o'>]</span>

<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>iris_data_c</span><span class='o'>)</span>

<span class='c'>#&gt;   Petal.Length Petal.Width Species</span>
<span class='c'>#&gt; 1          1.4         0.2  setosa</span>
<span class='c'>#&gt; 2          1.4         0.2  setosa</span>
<span class='c'>#&gt; 3          1.3         0.2  setosa</span>
<span class='c'>#&gt; 4          1.5         0.2  setosa</span>
<span class='c'>#&gt; 5          1.4         0.2  setosa</span>
<span class='c'>#&gt; 6          1.7         0.4  setosa</span>
</code></pre>

</div>

</div>

<br>

------------------------------------------------------------------------

4 - Using [`filter()`](https://rdrr.io/r/stats/filter.html)
--------------------

<p align="center">
<img src=https://raw.githubusercontent.com/allisonhorst/stats-illustrations/master/rstats-artwork/dplyr_filter.jpg width="95%">
<figcaption>
Artwork by <a href="https://github.com/allisonhorst/stats-illustrations">Allison Horst</a>.
</figcaption>
</p>

[`filter()`](https://rdrr.io/r/stats/filter.html) allows you to pick certain observations (i.e, rows) based on their values to be included in your data frame.

We will create a new data frame that only includes information about the irises where their `Species` is *setosa*.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_setosa</span> <span class='o'>&lt;-</span> <span class='nv'>iris_data</span> <span class='o'>%&gt;%</span>
  <span class='nf'><a href='https://rdrr.io/r/stats/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>Species</span> <span class='o'>==</span> <span class='s'>"setosa"</span><span class='o'>)</span>
</code></pre>

</div>

Let's check the dimensions of our data frame. Remember, our whole data set is 150 observations, and we are expecting 50 observations per `Species`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'><a href='https://rdrr.io/r/base/dim.html'>dim</a></span><span class='o'>(</span><span class='nv'>iris_setosa</span><span class='o'>)</span>

<span class='c'>#&gt; [1] 50  5</span>
</code></pre>

</div>

<br>

------------------------------------------------------------------------

5 - Using `mutate()`
--------------------

<p align="center">
<img src=https://raw.githubusercontent.com/allisonhorst/stats-illustrations/master/rstats-artwork/dplyr_mutate.png width="95%">
<figcaption>
Artwork by <a href="https://github.com/allisonhorst/stats-illustrations">Allison Horst</a>.
</figcaption>
</p>

`mutate()` allows you to make new variables, while keeping all your existing columns.

Let's make a new column that is the ratio of `Sepal.Length`/`Sepal.Width`

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_sepal_length_to_width</span> <span class='o'>&lt;-</span> <span class='nv'>iris_data</span> <span class='o'>%&gt;%</span>
  <span class='nf'>mutate</span><span class='o'>(</span>Sepal.Length_div_Sepal.Width <span class='o'>=</span> <span class='nv'>Sepal.Length</span><span class='o'>/</span><span class='nv'>Sepal.Width</span><span class='o'>)</span>
</code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>iris_sepal_length_to_width</span><span class='o'>)</span>

<span class='c'>#&gt;   Sepal.Length Sepal.Width Petal.Length Petal.Width Species</span>
<span class='c'>#&gt; 1          5.1         3.5          1.4         0.2  setosa</span>
<span class='c'>#&gt; 2          4.9         3.0          1.4         0.2  setosa</span>
<span class='c'>#&gt; 3          4.7         3.2          1.3         0.2  setosa</span>
<span class='c'>#&gt; 4          4.6         3.1          1.5         0.2  setosa</span>
<span class='c'>#&gt; 5          5.0         3.6          1.4         0.2  setosa</span>
<span class='c'>#&gt; 6          5.4         3.9          1.7         0.4  setosa</span>
<span class='c'>#&gt;   Sepal.Length_div_Sepal.Width</span>
<span class='c'>#&gt; 1                     1.457143</span>
<span class='c'>#&gt; 2                     1.633333</span>
<span class='c'>#&gt; 3                     1.468750</span>
<span class='c'>#&gt; 4                     1.483871</span>
<span class='c'>#&gt; 5                     1.388889</span>
<span class='c'>#&gt; 6                     1.384615</span>
</code></pre>

</div>

**Note -- see the new column location**

<br>

------------------------------------------------------------------------

6 - Using `arrange()`
---------------------

Very often you will want to order your data frame by some values. To do this, you can use `arrange()`.

Let's arrange the values in our `iris_data` by `Sepal.Length`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_data_sort_Sepal.Length</span> <span class='o'>&lt;-</span> <span class='nv'>iris_data</span> <span class='o'>%&gt;%</span>
  <span class='nf'>arrange</span><span class='o'>(</span><span class='nv'>Sepal.Length</span><span class='o'>)</span>

<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>iris_data_sort_Sepal.Length</span><span class='o'>)</span>

<span class='c'>#&gt;   Sepal.Length Sepal.Width Petal.Length Petal.Width Species</span>
<span class='c'>#&gt; 1          4.3         3.0          1.1         0.1  setosa</span>
<span class='c'>#&gt; 2          4.4         2.9          1.4         0.2  setosa</span>
<span class='c'>#&gt; 3          4.4         3.0          1.3         0.2  setosa</span>
<span class='c'>#&gt; 4          4.4         3.2          1.3         0.2  setosa</span>
<span class='c'>#&gt; 5          4.5         2.3          1.3         0.3  setosa</span>
<span class='c'>#&gt; 6          4.6         3.1          1.5         0.2  setosa</span>
</code></pre>

</div>

What if we want to arrange by `Sepal.Length`, but within `Species`? We can do that using the helper [`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_data</span> <span class='o'>%&gt;%</span>
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>Species</span><span class='o'>)</span> <span class='o'>%&gt;%</span>
  <span class='nf'>arrange</span><span class='o'>(</span><span class='nv'>Sepal.Length</span><span class='o'>)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 150 x 5</span></span>
<span class='c'>#&gt; <span style='color: #555555;'># Groups:   Species [3]</span></span>
<span class='c'>#&gt;    Sepal.Length Sepal.Width Petal.Length Petal.Width Species</span>
<span class='c'>#&gt;           <span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span>       </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span>        </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span>       </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span> </span><span style='color: #555555;font-style: italic;'>&lt;fct&gt;</span><span>  </span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 1</span><span>          4.3         3            1.1         0.1 setosa </span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 2</span><span>          4.4         2.9          1.4         0.2 setosa </span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 3</span><span>          4.4         3            1.3         0.2 setosa </span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 4</span><span>          4.4         3.2          1.3         0.2 setosa </span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 5</span><span>          4.5         2.3          1.3         0.3 setosa </span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 6</span><span>          4.6         3.1          1.5         0.2 setosa </span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 7</span><span>          4.6         3.4          1.4         0.3 setosa </span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 8</span><span>          4.6         3.6          1           0.2 setosa </span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 9</span><span>          4.6         3.2          1.4         0.2 setosa </span></span>
<span class='c'>#&gt; <span style='color: #555555;'>10</span><span>          4.7         3.2          1.3         0.2 setosa </span></span>
<span class='c'>#&gt; <span style='color: #555555;'># … with 140 more rows</span></span>
</code></pre>

</div>

<br>

------------------------------------------------------------------------

7 - Using `summarize()`
-----------------------

By using `summarize()`, you can create a new data frame that has the summary output you have requested.

We can calculate the mean `Sepal.Length` across our dataset.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_data</span> <span class='o'>%&gt;%</span>
  <span class='nf'>summarize</span><span class='o'>(</span>mean <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/mean.html'>mean</a></span><span class='o'>(</span><span class='nv'>Sepal.Length</span><span class='o'>)</span><span class='o'>)</span>

<span class='c'>#&gt;       mean</span>
<span class='c'>#&gt; 1 5.843333</span>
</code></pre>

</div>

What if we want to calculate means for each `Species`?

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_data</span> <span class='o'>%&gt;%</span>
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>Species</span><span class='o'>)</span> <span class='o'>%&gt;%</span>
  <span class='nf'>summarize</span><span class='o'>(</span>mean <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/mean.html'>mean</a></span><span class='o'>(</span><span class='nv'>Sepal.Length</span><span class='o'>)</span><span class='o'>)</span>

<span class='c'>#&gt; `summarise()` ungrouping output (override with `.groups` argument)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 3 x 2</span></span>
<span class='c'>#&gt;   Species     mean</span>
<span class='c'>#&gt;   <span style='color: #555555;font-style: italic;'>&lt;fct&gt;</span><span>      </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span><span> setosa      5.01</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span><span> versicolor  5.94</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>3</span><span> virginica   6.59</span></span>
</code></pre>

</div>

We can integrate some helper functions into our code to simply get out a variety of outputs. We can use [`across()`](https://dplyr.tidyverse.org/reference/across.html) to apply our summary aross a set of columns. I really like this function.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_data</span> <span class='o'>%&gt;%</span>
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>Species</span><span class='o'>)</span> <span class='o'>%&gt;%</span>
  <span class='nf'>summarize</span><span class='o'>(</span><span class='nf'>across</span><span class='o'>(</span><span class='nf'>where</span><span class='o'>(</span><span class='nv'>is.numeric</span><span class='o'>)</span>, <span class='nv'>mean</span><span class='o'>)</span><span class='o'>)</span>

<span class='c'>#&gt; `summarise()` ungrouping output (override with `.groups` argument)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 3 x 5</span></span>
<span class='c'>#&gt;   Species    Sepal.Length Sepal.Width Petal.Length Petal.Width</span>
<span class='c'>#&gt;   <span style='color: #555555;font-style: italic;'>&lt;fct&gt;</span><span>             </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span>       </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span>        </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span>       </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span><span> setosa             5.01        3.43         1.46       0.246</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span><span> versicolor         5.94        2.77         4.26       1.33 </span></span>
<span class='c'>#&gt; <span style='color: #555555;'>3</span><span> virginica          6.59        2.97         5.55       2.03</span></span>
</code></pre>

</div>

This can also be useful for counting observations per group. Here, how many iris observations do we have per `Species`?

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>iris_data</span> <span class='o'>%&gt;%</span>
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>Species</span><span class='o'>)</span> <span class='o'>%&gt;%</span>
  <span class='nf'>tally</span><span class='o'>(</span><span class='o'>)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 3 x 2</span></span>
<span class='c'>#&gt;   Species        n</span>
<span class='c'>#&gt;   <span style='color: #555555;font-style: italic;'>&lt;fct&gt;</span><span>      </span><span style='color: #555555;font-style: italic;'>&lt;int&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span><span> setosa        50</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span><span> versicolor    50</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>3</span><span> virginica     50</span></span>


<span class='nv'>iris_data</span> <span class='o'>%&gt;%</span>
  <span class='nf'>count</span><span class='o'>(</span><span class='nv'>Species</span><span class='o'>)</span>

<span class='c'>#&gt;      Species  n</span>
<span class='c'>#&gt; 1     setosa 50</span>
<span class='c'>#&gt; 2 versicolor 50</span>
<span class='c'>#&gt; 3  virginica 50</span>


<span class='nv'>iris_data</span> <span class='o'>%&gt;%</span>
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>Species</span><span class='o'>)</span> <span class='o'>%&gt;%</span>
  <span class='nf'>summarize</span><span class='o'>(</span>n <span class='o'>=</span> <span class='nf'>n</span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>

<span class='c'>#&gt; `summarise()` ungrouping output (override with `.groups` argument)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 3 x 2</span></span>
<span class='c'>#&gt;   Species        n</span>
<span class='c'>#&gt;   <span style='color: #555555;font-style: italic;'>&lt;fct&gt;</span><span>      </span><span style='color: #555555;font-style: italic;'>&lt;int&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span><span> setosa        50</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span><span> versicolor    50</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>3</span><span> virginica     50</span></span>
</code></pre>

</div>

<br>

------------------------------------------------------------------------

8 - Breakout rooms!
-------------------

### Read in data

Now you try! We are going to use the Great Backyard Birds dataset we downloaded two weeks ago and you will apply the functions we have learned above to investigate this dataset.

If you weren't here for [Session 1](/codeclub/01_backyard-birds/), get the birds data set.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># create a directory called S02</span>
<span class='nf'><a href='https://rdrr.io/r/base/files2.html'>dir.create</a></span><span class='o'>(</span><span class='s'>'S02'</span><span class='o'>)</span>

<span class='c'># within S02, create a directory called data, within, a directory called birds</span>
<span class='nf'><a href='https://rdrr.io/r/base/files2.html'>dir.create</a></span><span class='o'>(</span><span class='s'>'data/birds/'</span>, recursive <span class='o'>=</span> <span class='kc'>TRUE</span><span class='o'>)</span>
</code></pre>

</div>

Download the file from the internet.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># set the location of the file</span>
<span class='nv'>birds_file_url</span> <span class='o'>&lt;-</span> <span class='s'>'https://raw.githubusercontent.com/biodash/biodash.github.io/master/assets/data/birds/backyard-birds_Ohio.tsv'</span>

<span class='c'># set the path for the downloaded file</span>
<span class='nv'>birds_file</span> <span class='o'>&lt;-</span> <span class='s'>'data/birds/backyard-birds_Ohio.tsv'</span>

<span class='c'># download </span>
<span class='nf'><a href='https://rdrr.io/r/utils/download.file.html'>download.file</a></span><span class='o'>(</span>url <span class='o'>=</span> <span class='nv'>birds_file_url</span>, destfile <span class='o'>=</span> <span class='nv'>birds_file</span><span class='o'>)</span>
</code></pre>

</div>

If you were here for [Session 1](/codeclub/01_backyard-birds/), join back in! Let's read in our data.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>birds_file</span> <span class='o'>&lt;-</span> <span class='s'>'data/birds/backyard-birds_Ohio.tsv'</span>
<span class='nv'>birds</span> <span class='o'>&lt;-</span> <span class='nf'>read_tsv</span><span class='o'>(</span><span class='nv'>birds_file</span><span class='o'>)</span>

<span class='c'>#&gt; </span>
<span class='c'>#&gt; <span style='color: #00BBBB;'>──</span><span> </span><span style='font-weight: bold;'>Column specification</span><span> </span><span style='color: #00BBBB;'>────────────────────────────────────────────────────────</span></span>
<span class='c'>#&gt; cols(</span>
<span class='c'>#&gt;   class = <span style='color: #BB0000;'>col_character()</span><span>,</span></span>
<span class='c'>#&gt;   order = <span style='color: #BB0000;'>col_character()</span><span>,</span></span>
<span class='c'>#&gt;   family = <span style='color: #BB0000;'>col_character()</span><span>,</span></span>
<span class='c'>#&gt;   genus = <span style='color: #BB0000;'>col_character()</span><span>,</span></span>
<span class='c'>#&gt;   species = <span style='color: #BB0000;'>col_character()</span><span>,</span></span>
<span class='c'>#&gt;   locality = <span style='color: #BB0000;'>col_character()</span><span>,</span></span>
<span class='c'>#&gt;   stateProvince = <span style='color: #BB0000;'>col_character()</span><span>,</span></span>
<span class='c'>#&gt;   decimalLatitude = <span style='color: #00BB00;'>col_double()</span><span>,</span></span>
<span class='c'>#&gt;   decimalLongitude = <span style='color: #00BB00;'>col_double()</span><span>,</span></span>
<span class='c'>#&gt;   eventDate = <span style='color: #0000BB;'>col_datetime(format = "")</span><span>,</span></span>
<span class='c'>#&gt;   species_en = <span style='color: #BB0000;'>col_character()</span><span>,</span></span>
<span class='c'>#&gt;   range = <span style='color: #BB0000;'>col_character()</span></span>
<span class='c'>#&gt; )</span>
</code></pre>

</div>

### Exercises

Below you can find our breakout room exercises for today.

### Exercise 1

<div class="alert puzzle">

<div>

Investigate the structure of the birds dataset.

<details>

<summary> Solution (click here) </summary>

<br>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>glimpse</span><span class='o'>(</span><span class='nv'>birds</span><span class='o'>)</span>

<span class='c'>#&gt; Rows: 311,441</span>
<span class='c'>#&gt; Columns: 12</span>
<span class='c'>#&gt; $ class            <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> "Aves", "Aves", "Aves", "Aves", "Aves", "Aves", "Ave…</span></span>
<span class='c'>#&gt; $ order            <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> "Passeriformes", "Passeriformes", "Passeriformes", "…</span></span>
<span class='c'>#&gt; $ family           <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> "Corvidae", "Corvidae", "Corvidae", "Corvidae", "Cor…</span></span>
<span class='c'>#&gt; $ genus            <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> "Cyanocitta", "Cyanocitta", "Cyanocitta", "Cyanocitt…</span></span>
<span class='c'>#&gt; $ species          <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> "Cyanocitta cristata", "Cyanocitta cristata", "Cyano…</span></span>
<span class='c'>#&gt; $ locality         <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> "44805 Ashland", "45244 Cincinnati", "44132 Euclid",…</span></span>
<span class='c'>#&gt; $ stateProvince    <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> "Ohio", "Ohio", "Ohio", "Ohio", "Ohio", "Ohio", "Ohi…</span></span>
<span class='c'>#&gt; $ decimalLatitude  <span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span> 40.86166, 39.10666, 41.60768, 39.24236, 39.28207, 41…</span></span>
<span class='c'>#&gt; $ decimalLongitude <span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span> -82.31558, -84.32972, -81.50085, -84.35545, -84.4688…</span></span>
<span class='c'>#&gt; $ eventDate        <span style='color: #555555;font-style: italic;'>&lt;dttm&gt;</span><span> 2007-02-16, 2007-02-17, 2007-02-17, 2007-02-19, 200…</span></span>
<span class='c'>#&gt; $ species_en       <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> "Blue Jay", "Blue Jay", "Blue Jay", "Blue Jay", "Blu…</span></span>
<span class='c'>#&gt; $ range            <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …</span></span>
</code></pre>

</div>

</details>

</div>

</div>

------------------------------------------------------------------------

### Exercise 2

<div class="alert puzzle">

<div>

Create a new data frame that removes the column `range`.

<details>

<summary> Hints (click here) </summary>

<br> Try using select(). Remember, you can tell select() what you want to keep, and what you want to remove. <br>
</details>
<details>

<summary> Solutions (click here) </summary>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>birds_no_range</span> <span class='o'>&lt;-</span> <span class='nv'>birds</span> <span class='o'>%&gt;%</span>
  <span class='nf'>select</span><span class='o'>(</span><span class='o'>-</span><span class='nv'>range</span><span class='o'>)</span>

<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>birds_no_range</span><span class='o'>)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 6 x 11</span></span>
<span class='c'>#&gt;   class order family genus species locality stateProvince decimalLatitude</span>
<span class='c'>#&gt;   <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>  </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>   </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>    </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>                   </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span><span> Aves  Pass… Corvi… Cyan… Cyanoc… 44805 A… Ohio                     40.9</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span><span> Aves  Pass… Corvi… Cyan… Cyanoc… 45244 C… Ohio                     39.1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>3</span><span> Aves  Pass… Corvi… Cyan… Cyanoc… 44132 E… Ohio                     41.6</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>4</span><span> Aves  Pass… Corvi… Cyan… Cyanoc… 45242 C… Ohio                     39.2</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>5</span><span> Aves  Pass… Corvi… Cyan… Cyanoc… 45246 C… Ohio                     39.3</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>6</span><span> Aves  Pass… Corvi… Cyan… Cyanoc… 44484 W… Ohio                     41.2</span></span>
<span class='c'>#&gt; <span style='color: #555555;'># … with 3 more variables: decimalLongitude </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span style='color: #555555;'>, eventDate </span><span style='color: #555555;font-style: italic;'>&lt;dttm&gt;</span><span style='color: #555555;'>,</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>#   species_en </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span></span>
</code></pre>

</div>

</details>

<br>

</div>

</div>

------------------------------------------------------------------------

### Exercise 3

<div class="alert puzzle">

<div>

How many unique species of birds have been observed?.

<details>

<summary> Hints (click here) </summary>

Try using `summarize()` with a `group_by()` helper. <br>
</details>
<details>

<summary> Solutions (click here) </summary>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># using a combo of group_by() and summarize()</span>
<span class='nv'>unique_birds</span> <span class='o'>&lt;-</span> <span class='nv'>birds</span> <span class='o'>%&gt;%</span>
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>species_en</span><span class='o'>)</span> <span class='o'>%&gt;%</span>
  <span class='nf'>summarize</span><span class='o'>(</span><span class='o'>)</span>

<span class='c'>#&gt; `summarise()` ungrouping output (override with `.groups` argument)</span>


<span class='nf'><a href='https://rdrr.io/r/base/dim.html'>dim</a></span><span class='o'>(</span><span class='nv'>unique_birds</span><span class='o'>)</span> <span class='c'># question - are there really 170 different birds observed?  take a look at this summary</span>

<span class='c'>#&gt; [1] 170   1</span>


<span class='c'># a one line, base R approach</span>
<span class='nf'><a href='https://rdrr.io/r/base/length.html'>length</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/unique.html'>unique</a></span><span class='o'>(</span><span class='nv'>birds</span><span class='o'>$</span><span class='nv'>species_en</span><span class='o'>)</span><span class='o'>)</span>

<span class='c'>#&gt; [1] 170</span>


<span class='c'># another base R approach using distinct() and nrow()</span>
<span class='nv'>birds</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>distinct</span><span class='o'>(</span><span class='nv'>species_en</span><span class='o'>)</span> <span class='o'>%&gt;%</span> <span class='c'># find distinct occurences</span>
  <span class='nf'><a href='https://rdrr.io/r/base/nrow.html'>nrow</a></span><span class='o'>(</span><span class='o'>)</span> <span class='c'># counts rows</span>

<span class='c'>#&gt; [1] 170</span>


<span class='c'># using n_distinct()</span>
<span class='nv'>birds</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>summarize</span><span class='o'>(</span><span class='nf'>n_distinct</span><span class='o'>(</span><span class='nv'>species_en</span><span class='o'>)</span><span class='o'>)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 1 x 1</span></span>
<span class='c'>#&gt;   `n_distinct(species_en)`</span>
<span class='c'>#&gt;                      <span style='color: #555555;font-style: italic;'>&lt;int&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span><span>                      170</span></span>
</code></pre>

</div>

</details>

<br>

</div>

</div>

------------------------------------------------------------------------

### Exercise 4

<div class="alert puzzle">

<div>

How many times have Bald Eagles been observed?.

<details>

<summary> Hints (click here) </summary>

Try using filter(). Remember the syntax you need to use to indicate you are looking for a Bald Eagle. <br>

</details>
<details>

<summary> Solutions (click here) </summary>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>birds_bald_eagle</span> <span class='o'>&lt;-</span> <span class='nv'>birds</span> <span class='o'>%&gt;%</span>
  <span class='nf'><a href='https://rdrr.io/r/stats/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>species_en</span> <span class='o'>==</span> <span class='s'>"Bald Eagle"</span><span class='o'>)</span>

<span class='nf'><a href='https://rdrr.io/r/base/dim.html'>dim</a></span><span class='o'>(</span><span class='nv'>birds_bald_eagle</span><span class='o'>)</span>

<span class='c'>#&gt; [1] 381  12</span>
</code></pre>

</div>

</details>

<br>

</div>

</div>

------------------------------------------------------------------------

### Exercise 5

<div class="alert puzzle">

<div>

How many times have any kind of eagle been observed?. Group hint: there are only Bald Eagle and Golden Eagle in this dataset.

<details>

<summary> Hints (click here) </summary>

There is a way to denote OR within filter(). <br>
</details>
<details>

<summary> More Hints (click here) </summary>

You denote OR by using the vertical bar. <br>
</details>
<details>

<summary> Solutions (click here) </summary>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>birds_alleagles</span> <span class='o'>&lt;-</span> <span class='nv'>birds</span> <span class='o'>%&gt;%</span>
  <span class='nf'><a href='https://rdrr.io/r/stats/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>species_en</span> <span class='o'>==</span> <span class='s'>"Bald Eagle"</span> <span class='o'>|</span> <span class='nv'>species_en</span> <span class='o'>==</span> <span class='s'>"Golden Eagle"</span><span class='o'>)</span>

<span class='nf'><a href='https://rdrr.io/r/base/dim.html'>dim</a></span><span class='o'>(</span><span class='nv'>birds_alleagles</span><span class='o'>)</span>

<span class='c'>#&gt; [1] 386  12</span>
</code></pre>

</div>

</details>

<br>

</div>

</div>

------------------------------------------------------------------------

### Exercise 6

<div class="alert puzzle">

<div>

What is the northern most location of the bird observations in Ohio?

<details>

<summary> Hints (click here) </summary>

Try using arrange(). You can arrange in both ascending and descending order. You can also use your Ohio knowledge to check if you've done this correctly. <br>

</details>
<details>

<summary> Solutions (click here) </summary>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>birds_sort_lat</span> <span class='o'>&lt;-</span> <span class='nv'>birds</span> <span class='o'>%&gt;%</span>
  <span class='nf'>arrange</span><span class='o'>(</span><span class='o'>-</span><span class='nv'>decimalLatitude</span><span class='o'>)</span>

<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>birds_sort_lat</span><span class='o'>)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 6 x 12</span></span>
<span class='c'>#&gt;   class order family genus species locality stateProvince decimalLatitude</span>
<span class='c'>#&gt;   <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>  </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span> </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>   </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>    </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>                   </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span><span> Aves  Pass… Cardi… Card… Cardin… Conneaut Ohio                     41.9</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span><span> Aves  Pass… Ember… Zono… Zonotr… Conneaut Ohio                     41.9</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>3</span><span> Aves  Colu… Colum… Zena… Zenaid… Conneaut Ohio                     41.9</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>4</span><span> Aves  Pici… Picid… Dend… Dendro… Conneaut Ohio                     41.9</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>5</span><span> Aves  Anse… Anati… Anas  Anas p… Conneaut Ohio                     41.9</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>6</span><span> Aves  Pass… Turdi… Sial… Sialia… Conneaut Ohio                     41.9</span></span>
<span class='c'>#&gt; <span style='color: #555555;'># … with 4 more variables: decimalLongitude </span><span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span style='color: #555555;'>, eventDate </span><span style='color: #555555;font-style: italic;'>&lt;dttm&gt;</span><span style='color: #555555;'>,</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>#   species_en </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span style='color: #555555;'>, range </span><span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span></span>
</code></pre>

</div>

</details>

<br>

</div>

</div>

------------------------------------------------------------------------

Bonus time!
-----------

### Bonus 1

<div class="alert puzzle">

<div>

What is the most commonly observed bird in Ohio?

<details>

<summary> Hints (click here) </summary>

Try using tally() and a little helper term.

</details>
<details>

<summary> Solutions (click here) </summary>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>unique_birds_tally</span> <span class='o'>&lt;-</span> <span class='nv'>birds</span> <span class='o'>%&gt;%</span>
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>species_en</span><span class='o'>)</span> <span class='o'>%&gt;%</span>
  <span class='nf'>tally</span><span class='o'>(</span>sort <span class='o'>=</span> <span class='kc'>TRUE</span><span class='o'>)</span>

<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>unique_birds_tally</span><span class='o'>)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 6 x 2</span></span>
<span class='c'>#&gt;   species_en            n</span>
<span class='c'>#&gt;   <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>             </span><span style='color: #555555;font-style: italic;'>&lt;int&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span><span> Northern Cardinal </span><span style='text-decoration: underline;'>23</span><span>064</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span><span> Mourning Dove     </span><span style='text-decoration: underline;'>19</span><span>135</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>3</span><span> Dark-eyed Junco   </span><span style='text-decoration: underline;'>18</span><span>203</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>4</span><span> Downy Woodpecker  </span><span style='text-decoration: underline;'>17</span><span>196</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>5</span><span> House Sparrow     </span><span style='text-decoration: underline;'>15</span><span>939</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>6</span><span> Blue Jay          </span><span style='text-decoration: underline;'>15</span><span>611</span></span>


<span class='c'># another option</span>
<span class='nv'>birds</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>count</span><span class='o'>(</span><span class='nv'>species_en</span>, sort <span class='o'>=</span> <span class='kc'>TRUE</span><span class='o'>)</span> 

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 170 x 2</span></span>
<span class='c'>#&gt;    species_en                 n</span>
<span class='c'>#&gt;    <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>                  </span><span style='color: #555555;font-style: italic;'>&lt;int&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 1</span><span> Northern Cardinal      </span><span style='text-decoration: underline;'>23</span><span>064</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 2</span><span> Mourning Dove          </span><span style='text-decoration: underline;'>19</span><span>135</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 3</span><span> Dark-eyed Junco        </span><span style='text-decoration: underline;'>18</span><span>203</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 4</span><span> Downy Woodpecker       </span><span style='text-decoration: underline;'>17</span><span>196</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 5</span><span> House Sparrow          </span><span style='text-decoration: underline;'>15</span><span>939</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 6</span><span> Blue Jay               </span><span style='text-decoration: underline;'>15</span><span>611</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 7</span><span> American Goldfinch     </span><span style='text-decoration: underline;'>14</span><span>732</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 8</span><span> House Finch            </span><span style='text-decoration: underline;'>14</span><span>551</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 9</span><span> Tufted Titmouse        </span><span style='text-decoration: underline;'>14</span><span>409</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>10</span><span> Black-capped Chickadee </span><span style='text-decoration: underline;'>13</span><span>471</span></span>
<span class='c'>#&gt; <span style='color: #555555;'># … with 160 more rows</span></span>
</code></pre>

</div>

</details>

<br>

</div>

</div>

------------------------------------------------------------------------

### Bonus 2

<div class="alert puzzle">

<div>

What is the least commonly observed bird (or birds) in Ohio?

<details>

<summary> Hints (click here) </summary>

Try using the data frame you've created in the previous exercise. <br>

</details>
<details>
<summary> Solutions (click here) </summary>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>unique_birds_tally</span> <span class='o'>%&gt;%</span>
  <span class='nf'>arrange</span><span class='o'>(</span><span class='nv'>n</span><span class='o'>)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 170 x 2</span></span>
<span class='c'>#&gt;    species_en               n</span>
<span class='c'>#&gt;    <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>                </span><span style='color: #555555;font-style: italic;'>&lt;int&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 1</span><span> Arctic Redpoll           1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 2</span><span> Clay-colored Sparrow     1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 3</span><span> Dickcissel               1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 4</span><span> Eurasian Wigeon          1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 5</span><span> Great Egret              1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 6</span><span> Green Heron              1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 7</span><span> Grey Partridge           1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 8</span><span> Harris's Sparrow         1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 9</span><span> Lesser Yellowlegs        1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>10</span><span> Lincoln's Sparrow        1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'># … with 160 more rows</span></span>

  
<span class='c'># or, if you knew the rarest was those observed only once  </span>
<span class='nv'>unique_birds_tally</span> <span class='o'>%&gt;%</span>
  <span class='nf'><a href='https://rdrr.io/r/stats/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>n</span> <span class='o'>==</span> <span class='m'>1</span><span class='o'>)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 19 x 2</span></span>
<span class='c'>#&gt;    species_en                        n</span>
<span class='c'>#&gt;    <span style='color: #555555;font-style: italic;'>&lt;chr&gt;</span><span>                         </span><span style='color: #555555;font-style: italic;'>&lt;int&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 1</span><span> Arctic Redpoll                    1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 2</span><span> Clay-colored Sparrow              1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 3</span><span> Dickcissel                        1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 4</span><span> Eurasian Wigeon                   1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 5</span><span> Great Egret                       1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 6</span><span> Green Heron                       1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 7</span><span> Grey Partridge                    1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 8</span><span> Harris's Sparrow                  1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 9</span><span> Lesser Yellowlegs                 1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>10</span><span> Lincoln's Sparrow                 1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>11</span><span> Loggerhead Shrike                 1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>12</span><span> Nelson's Sparrow                  1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>13</span><span> Northern Rough-winged Swallow     1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>14</span><span> Orchard Oriole                    1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>15</span><span> Prairie Falcon                    1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>16</span><span> Red-throated Loon                 1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>17</span><span> Ross's Goose                      1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>18</span><span> Warbling Vireo                    1</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>19</span><span> Western Osprey                    1</span></span>
</code></pre>

</div>

</details>

<br>

</div>

</div>

------------------------------------------------------------------------

### Bonus 3

<div class="alert puzzle">

<div>

In what year were the most Bald Eagles observed?

<details>
<summary> Hints (click here) </summary> You may want to convert your date column to a more simplified year-only date. Check out the package lubridate. <br>
</details>
<details>

<summary> Solutions (click here) </summary>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://lubridate.tidyverse.org'>lubridate</a></span><span class='o'>)</span>

<span class='c'>#&gt; </span>
<span class='c'>#&gt; Attaching package: 'lubridate'</span>

<span class='c'>#&gt; The following objects are masked from 'package:base':</span>
<span class='c'>#&gt; </span>
<span class='c'>#&gt;     date, intersect, setdiff, union</span>

<span class='nv'>birds_bald_eagle_year</span> <span class='o'>&lt;-</span> <span class='nv'>birds_bald_eagle</span> <span class='o'>%&gt;%</span>
  <span class='nf'>mutate</span><span class='o'>(</span>year <span class='o'>=</span> <span class='nf'><a href='http://lubridate.tidyverse.org/reference/year.html'>year</a></span><span class='o'>(</span><span class='nv'>eventDate</span><span class='o'>)</span><span class='o'>)</span> <span class='o'>%&gt;%</span> <span class='c'># year() takes a date and outputs only year</span>
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>year</span><span class='o'>)</span> <span class='o'>%&gt;%</span>
  <span class='nf'>tally</span><span class='o'>(</span><span class='o'>)</span>

<span class='nf'>arrange</span><span class='o'>(</span><span class='nv'>birds_bald_eagle_year</span>, <span class='o'>-</span><span class='nv'>n</span><span class='o'>)</span>

<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 11 x 2</span></span>
<span class='c'>#&gt;     year     n</span>
<span class='c'>#&gt;    <span style='color: #555555;font-style: italic;'>&lt;dbl&gt;</span><span> </span><span style='color: #555555;font-style: italic;'>&lt;int&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 1</span><span>  </span><span style='text-decoration: underline;'>2</span><span>008    81</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 2</span><span>  </span><span style='text-decoration: underline;'>2</span><span>006    66</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 3</span><span>  </span><span style='text-decoration: underline;'>2</span><span>009    58</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 4</span><span>  </span><span style='text-decoration: underline;'>2</span><span>007    40</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 5</span><span>  </span><span style='text-decoration: underline;'>2</span><span>005    30</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 6</span><span>  </span><span style='text-decoration: underline;'>2</span><span>004    26</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 7</span><span>  </span><span style='text-decoration: underline;'>2</span><span>000    23</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 8</span><span>  </span><span style='text-decoration: underline;'>2</span><span>001    23</span></span>
<span class='c'>#&gt; <span style='color: #555555;'> 9</span><span>  </span><span style='text-decoration: underline;'>2</span><span>003    15</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>10</span><span>  </span><span style='text-decoration: underline;'>2</span><span>002    14</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>11</span><span>  </span><span style='text-decoration: underline;'>1</span><span>999     5</span></span>
</code></pre>

</div>

</details>

<br>

</div>

</div>

<br> <br> <br> <br>

