---
title: "Code Club S02E10: An introduction to ggpubr"
summary: "In this session, we will be exploring one of the most powerful ggplot extensions, ggpubr. We will take a look at how to add statistical results to a comparison plot."  
authors: [Daniel Quiroz]
date: "2021-11-03"
lastmod: "2021-11-03"
output: hugodown::md_document
toc: true
rmd_hash: d28a6c312827c55a

---

<br>

# Learning objectives

> -   Understand what is a *ggplot* extension
> -   Define what is *ggpubr*
> -   Recognize the advantages and drawback of *ggpubr*
> -   Create a density plot with *ggpubr*
> -   Add statistical results to density plots

<br>

------------------------------------------------------------------------

## Understand what is a *ggplot* extension

A *ggplot* extension is a set of functions that helps in the automation of a given task. In the case of *ggplot* extensions, there are 102 registered extensions up today.

*ggplot*'s extensions are developed based on the core of *ggplot* and help to create a customized plot with certain features such as animation, specific color scales, or to produce a ready to publish figure.

The [*ggplot* extensions website](https://exts.ggplot2.tidyverse.org/) has an overview of the available extensions:

<div class="highlight">

<iframe src="https://exts.ggplot2.tidyverse.org/gallery/" width="100%" height="400px" data-external="1">
</iframe>

</div>

<br>

------------------------------------------------------------------------

## Define what is *ggpubr*

*ggpubr* is an R package that produces ggplot-based plots with a more elegant aesthetic. Although *ggpubr* has default figures themes, plots usually require some formatting before sending them for publication.

<br>

------------------------------------------------------------------------

## Getting everything ready

First, we can take a look at the data that we are going to use. In this case, since we are already familiar with *palmerpenguins* dataset, we are going to continue using this data.

To remember the data structure, we can use the `glimpse` function.

<div class="alert alert-warning">

<div>

If you do not have installed the palmergenguins library, you can do it with this line. If you already have it, skip this line.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'><a href='https://rdrr.io/r/utils/install.packages.html'>install.packages</a></span><span class='o'>(</span><span class='s'>"palmerpenguins"</span><span class='o'>)</span></code></pre>

</div>

To install the ggpubr package for the first time, you can use this command.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'><a href='https://rdrr.io/r/utils/install.packages.html'>install.packages</a></span><span class='o'>(</span><span class='s'>"ggpubr"</span><span class='o'>)</span></code></pre>

</div>

</div>

</div>

------------------------------------------------------------------------

### Loading all required packages

<div class="alert alert-note">

<div>

A good programming style is to load all necessary packages at the very beginning of the script.

</div>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://tidyverse.tidyverse.org'>tidyverse</a></span><span class='o'>)</span>      <span class='c'># To load all packages including in the tidyverse</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://allisonhorst.github.io/palmerpenguins/'>palmerpenguins</a></span><span class='o'>)</span> <span class='c'># Load the example data</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://rpkgs.datanovia.com/ggpubr/'>ggpubr</a></span><span class='o'>)</span>         <span class='c'># Create ready to publish figures</span></code></pre>

</div>

### Remembering the palmer penguins data

![](./culmen_depth.png)

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>glimpse</span><span class='o'>(</span><span class='nv'>penguins</span><span class='o'>)</span>
<span class='c'>#&gt; Rows: 344</span>
<span class='c'>#&gt; Columns: 8</span>
<span class='c'>#&gt; $ species           <span style='color: #555555; font-style: italic;'>&lt;fct&gt;</span> Adelie, Adelie, Adelie, Adelie, Adelie, Adelie, Adel…</span>
<span class='c'>#&gt; $ island            <span style='color: #555555; font-style: italic;'>&lt;fct&gt;</span> Torgersen, Torgersen, Torgersen, Torgersen, Torgerse…</span>
<span class='c'>#&gt; $ bill_length_mm    <span style='color: #555555; font-style: italic;'>&lt;dbl&gt;</span> 39.1, 39.5, 40.3, NA, 36.7, 39.3, 38.9, 39.2, 34.1, …</span>
<span class='c'>#&gt; $ bill_depth_mm     <span style='color: #555555; font-style: italic;'>&lt;dbl&gt;</span> 18.7, 17.4, 18.0, NA, 19.3, 20.6, 17.8, 19.6, 18.1, …</span>
<span class='c'>#&gt; $ flipper_length_mm <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span> 181, 186, 195, NA, 193, 190, 181, 195, 193, 190, 186…</span>
<span class='c'>#&gt; $ body_mass_g       <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span> 3750, 3800, 3250, NA, 3450, 3650, 3625, 4675, 3475, …</span>
<span class='c'>#&gt; $ sex               <span style='color: #555555; font-style: italic;'>&lt;fct&gt;</span> male, female, female, NA, female, male, female, male…</span>
<span class='c'>#&gt; $ year              <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span> 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007…</span></code></pre>

</div>

For the downstream example, we are going to contrast the bill depth of the female vs male penguins of the Adelie species found on the island of Biscoe.

Therefore, we need to filter based on `species == Adelie` and `island == Biscoe`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># Filter by species and island</span>
<span class='nv'>penguins_filtered</span> <span class='o'>&lt;-</span> <span class='nv'>penguins</span> <span class='o'>%&gt;%</span> 
  <span class='nf'><a href='https://rdrr.io/r/stats/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>species</span> <span class='o'>==</span> <span class='s'>"Adelie"</span>, <span class='nv'>island</span> <span class='o'>==</span> <span class='s'>"Biscoe"</span><span class='o'>)</span>

<span class='c'># Count the occurence of the factors levels of sex, species and island</span>
<span class='nv'>penguins_filtered</span> <span class='o'>%&gt;%</span> <span class='nf'>count</span><span class='o'>(</span><span class='nv'>sex</span>, <span class='nv'>species</span>, <span class='nv'>island</span><span class='o'>)</span>
<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 2 × 4</span></span>
<span class='c'>#&gt;   sex    species island     n</span>
<span class='c'>#&gt;   <span style='color: #555555; font-style: italic;'>&lt;fct&gt;</span>  <span style='color: #555555; font-style: italic;'>&lt;fct&gt;</span>   <span style='color: #555555; font-style: italic;'>&lt;fct&gt;</span>  <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span> female Adelie  Biscoe    22</span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span> male   Adelie  Biscoe    22</span></code></pre>

</div>

### Creating the plot with ggplot

One of the main differences between *ggplot* and *ggpubr* is the syntax to create the base plot. In the case of *ggplot*, it is a layer based syntax, while in *ggpubr*, the syntax is embedded in a single function.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>ggplot</span><span class='o'>(</span><span class='nv'>penguins_filtered</span>,
       <span class='nf'>aes</span><span class='o'>(</span>x <span class='o'>=</span> <span class='nv'>sex</span>, y <span class='o'>=</span> <span class='nv'>bill_depth_mm</span>, fill <span class='o'>=</span> <span class='nv'>sex</span><span class='o'>)</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'>geom_boxplot</span><span class='o'>(</span><span class='o'>)</span>
</code></pre>
<img src="figs/unnamed-chunk-7-1.png" width="700px" style="display: block; margin: auto;" />

</div>

Now, since *ggpubr* has its own built-in geoms, we can use the [`ggboxplot()`](https://rpkgs.datanovia.com/ggpubr/reference/ggboxplot.html) function:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>base_plot</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/ggboxplot.html'>ggboxplot</a></span><span class='o'>(</span>data <span class='o'>=</span> <span class='nv'>penguins_filtered</span>,
                       x <span class='o'>=</span> <span class='s'>"sex"</span>,
                       y <span class='o'>=</span> <span class='s'>"bill_depth_mm"</span>,
                       fill <span class='o'>=</span> <span class='s'>"sex"</span><span class='o'>)</span>

<span class='nv'>base_plot</span>
</code></pre>
<img src="figs/unnamed-chunk-8-1.png" width="700px" style="display: block; margin: auto;" />

</div>

<div class="alert alert-note">

<div>

Since *ggpubr* creates plots based on *ggplot* syntax, you can treat these plots as another *ggplot* figure and use the same functions that you would use to format base *ggplot* plots.

</div>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>base_plot</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/ggboxplot.html'>ggboxplot</a></span><span class='o'>(</span>data <span class='o'>=</span> <span class='nv'>penguins_filtered</span>,
                       x <span class='o'>=</span> <span class='s'>"sex"</span>,
                       y <span class='o'>=</span> <span class='s'>"bill_depth_mm"</span>,
                       fill <span class='o'>=</span> <span class='s'>"sex"</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'>labs</span><span class='o'>(</span>title <span class='o'>=</span> <span class='s'>"Comparison between Adelie penguins by sex"</span>,
       fill <span class='o'>=</span> <span class='s'>"Sex:"</span>,
       x <span class='o'>=</span> <span class='s'>"Sex"</span>,
       y <span class='o'>=</span> <span class='s'>"Bill depth (mm)"</span><span class='o'>)</span>

<span class='nv'>base_plot</span>
</code></pre>
<img src="figs/unnamed-chunk-9-1.png" width="700px" style="display: block; margin: auto;" />

</div>

<br>

------------------------------------------------------------------------

## Add statistical results to the density plot

When hypotheses testing is brought to the table, we need to consider which type of stats we can and cannot apply to our data. Briefly, if our data fits the assumptions of being normally distributed and having variance homogeneity, we can apply parametric tests. On the other hand, if our data does not fit the assumptions, we need to apply a nonparametric test to the data.

| Comparison     | Parametric    | Nonparametric       |
|----------------|---------------|---------------------|
| **2 groups**   | t-test        | Wilcoxon test       |
| **\>2 groups** | one-way anova | Krustal-Wallis test |

### Checking assumptions

If we would like to conduct a hypotheses test, we need first to check assumptions (homogeneity of variance and and normality):

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'><a href='https://rdrr.io/r/stats/bartlett.test.html'>bartlett.test</a></span><span class='o'>(</span><span class='nv'>bill_depth_mm</span> <span class='o'>~</span> <span class='nv'>sex</span>, data <span class='o'>=</span> <span class='nv'>penguins_filtered</span><span class='o'>)</span>
<span class='c'>#&gt; </span>
<span class='c'>#&gt;   Bartlett test of homogeneity of variances</span>
<span class='c'>#&gt; </span>
<span class='c'>#&gt; data:  bill_depth_mm by sex</span>
<span class='c'>#&gt; Bartlett's K-squared = 0.94576, df = 1, p-value = 0.3308</span></code></pre>

</div>

### Exploring the `stat_compare_means()` function

We can use the function [`stat_compare_means()`](https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html) to annotate the plot with the results of a statistical test comparing group means:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>base_plot</span> <span class='o'>+</span>
  <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html'>stat_compare_means</a></span><span class='o'>(</span><span class='o'>)</span>
</code></pre>
<img src="figs/unnamed-chunk-11-1.png" width="700px" style="display: block; margin: auto;" />

</div>

In order to be 100% sure about the computed p-value, we can compute the Wilcoxon test in the console:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'><a href='https://rdrr.io/r/stats/wilcox.test.html'>wilcox.test</a></span><span class='o'>(</span><span class='nv'>bill_depth_mm</span> <span class='o'>~</span> <span class='nv'>sex</span>, data <span class='o'>=</span> <span class='nv'>penguins_filtered</span><span class='o'>)</span>
<span class='c'>#&gt; </span>
<span class='c'>#&gt;   Wilcoxon rank sum test with continuity correction</span>
<span class='c'>#&gt; </span>
<span class='c'>#&gt; data:  bill_depth_mm by sex</span>
<span class='c'>#&gt; W = 72, p-value = 6.79e-05</span>
<span class='c'>#&gt; alternative hypothesis: true location shift is not equal to 0</span></code></pre>

</div>

### Using *ggplot* to recreate the plot

Above, we created the base plot using *ggpubr* syntax, but we don't need to do this. The following code would create a very similar plot using *ggplot* syntax and then only adding the [`stat_compare_means()`](https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html) at the end:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>ggplot</span><span class='o'>(</span><span class='nv'>penguins_filtered</span>,
       <span class='nf'>aes</span><span class='o'>(</span><span class='nv'>sex</span>, <span class='nv'>bill_depth_mm</span>, fill <span class='o'>=</span> <span class='nv'>sex</span><span class='o'>)</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'>geom_boxplot</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'>theme_bw</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html'>stat_compare_means</a></span><span class='o'>(</span><span class='o'>)</span>
</code></pre>
<img src="figs/unnamed-chunk-13-1.png" width="700px" style="display: block; margin: auto;" />

</div>

### Breakout Rooms I (10 min)

<div class="puzzle">
<div>

### Exercise 1

-   Filter the penguins data in order to have only the observations (rows) from the Chinstrap species from Dream island.

-   Create a boxplot using the *ggpubr* package or using base *ggplot*.

-   Use *stat_compare_means()* function to add a p-value.

<details>
<summary>
Hints (click here)
</summary>

<br>

-   Use the [`filter()`](https://rdrr.io/r/stats/filter.html) function to filter rows
-   Filter using `species == Chinstrap` and `island == Dream`
-   If you want to use the *ggpubr* package to create the boxplot, use the [`ggboxplot()`](https://rpkgs.datanovia.com/ggpubr/reference/ggboxplot.html) function.

</details>
<details>
<summary>
Solution (click here)
</summary>

<br>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># Using ggpubr</span>

<span class='c'># Filter by species and island</span>
<span class='nv'>penguins_exc1</span> <span class='o'>&lt;-</span> <span class='nv'>penguins</span> <span class='o'>%&gt;%</span> 
  <span class='nf'><a href='https://rdrr.io/r/stats/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>species</span> <span class='o'>==</span> <span class='s'>"Chinstrap"</span>, <span class='nv'>island</span> <span class='o'>==</span> <span class='s'>"Dream"</span><span class='o'>)</span>

<span class='c'># Create the plot</span>
<span class='nv'>exc1_plot</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/ggboxplot.html'>ggboxplot</a></span><span class='o'>(</span>data <span class='o'>=</span> <span class='nv'>penguins_exc1</span>,
                       x <span class='o'>=</span> <span class='s'>"sex"</span>,
                       y <span class='o'>=</span> <span class='s'>"bill_depth_mm"</span>,
                       fill <span class='o'>=</span> <span class='s'>"sex"</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html'>stat_compare_means</a></span><span class='o'>(</span><span class='o'>)</span>

<span class='c'># Show the plot</span>
<span class='nv'>exc1_plot</span>
</code></pre>
<img src="figs/unnamed-chunk-14-1.png" width="700px" style="display: block; margin: auto;" />

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># Using ggplot only</span>

<span class='c'># Filter by species and island</span>
<span class='nv'>penguins_exc1</span> <span class='o'>&lt;-</span> <span class='nv'>penguins</span> <span class='o'>%&gt;%</span> 
  <span class='nf'><a href='https://rdrr.io/r/stats/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>species</span> <span class='o'>==</span> <span class='s'>"Chinstrap"</span>, <span class='nv'>island</span> <span class='o'>==</span> <span class='s'>"Dream"</span><span class='o'>)</span>

<span class='c'># Create the plot</span>
<span class='nv'>exc1_plot_ggplot</span> <span class='o'>&lt;-</span> <span class='nf'>ggplot</span><span class='o'>(</span><span class='nv'>penguins_exc1</span>,
                           <span class='nf'>aes</span><span class='o'>(</span><span class='nv'>sex</span>, <span class='nv'>bill_depth_mm</span>, fill <span class='o'>=</span> <span class='nv'>sex</span><span class='o'>)</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'>geom_boxplot</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html'>stat_compare_means</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'>theme_bw</span><span class='o'>(</span><span class='o'>)</span>

<span class='c'># Show the plot</span>
<span class='nv'>exc1_plot_ggplot</span>
</code></pre>
<img src="figs/unnamed-chunk-15-1.png" width="700px" style="display: block; margin: auto;" />

</div>

</div>
</div>

<br>

### Multiple group comparison within a variable

In many experiments we can have multiple groups in a single variable. For example, within a variable *nutrient concentration* we can have multiple nutrient concentration levels such as 10%, 20%, 30% and so on.

In the case of the penguins data we can find this layout if we need to compare the males bill depth between species. Only for teaching purposes, we are not going to consider any difference by island.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>penguins_male</span> <span class='o'>&lt;-</span> <span class='nv'>penguins</span> <span class='o'>%&gt;%</span>
  <span class='nf'><a href='https://rdrr.io/r/stats/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>sex</span> <span class='o'>==</span> <span class='s'>"male"</span><span class='o'>)</span>

<span class='nv'>penguins_male</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>count</span><span class='o'>(</span><span class='nv'>species</span>, <span class='nv'>sex</span><span class='o'>)</span>
<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 3 × 3</span></span>
<span class='c'>#&gt;   species   sex       n</span>
<span class='c'>#&gt;   <span style='color: #555555; font-style: italic;'>&lt;fct&gt;</span>     <span style='color: #555555; font-style: italic;'>&lt;fct&gt;</span> <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span> Adelie    male     73</span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span> Chinstrap male     34</span>
<span class='c'>#&gt; <span style='color: #555555;'>3</span> Gentoo    male     61</span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>penguins_male_plot</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/ggboxplot.html'>ggboxplot</a></span><span class='o'>(</span><span class='nv'>penguins_male</span>,
                                x <span class='o'>=</span> <span class='s'>"species"</span>,
                                y <span class='o'>=</span> <span class='s'>"bill_depth_mm"</span>,
                                color <span class='o'>=</span> <span class='s'>"species"</span><span class='o'>)</span>
<span class='nv'>penguins_male_plot</span>
</code></pre>
<img src="figs/unnamed-chunk-17-1.png" width="700px" style="display: block; margin: auto;" />

</div>

Like before, we can use the function `stat_compare_means` to add a p-value for an overall comparison between groups:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>penguins_male_plot</span> <span class='o'>+</span>
  <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html'>stat_compare_means</a></span><span class='o'>(</span><span class='o'>)</span>
</code></pre>
<img src="figs/unnamed-chunk-18-1.png" width="700px" style="display: block; margin: auto;" />

</div>

However, we may also be interested in getting a p-value for the different pairwise comparisons between groups. For instance, does the bill depth of Chinstrap penguins differ significantly from that in Gentoo penguins?

To do this, we can pass a *list* to that the `stat_compare_means` function. A list is a flexible, hierarchical R data structure. Here, we will use a list to store multiple vectors, each of which contains a pairwise comparison of interest:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>comparison_list</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Adelie"</span>, <span class='s'>"Chinstrap"</span><span class='o'>)</span>,
                        <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Chinstrap"</span>, <span class='s'>"Gentoo"</span><span class='o'>)</span>,
                        <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Adelie"</span>, <span class='s'>"Gentoo"</span><span class='o'>)</span><span class='o'>)</span>

<span class='nv'>penguins_male_plot</span> <span class='o'>+</span>
  <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html'>stat_compare_means</a></span><span class='o'>(</span>comparisons <span class='o'>=</span> <span class='nv'>comparison_list</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html'>stat_compare_means</a></span><span class='o'>(</span>label.y <span class='o'>=</span> <span class='m'>25</span><span class='o'>)</span>
</code></pre>
<img src="figs/unnamed-chunk-19-1.png" width="700px" style="display: block; margin: auto;" />

</div>

### Breakout Rooms II (10 min)

<div class="puzzle">
<div>

### Exercise 2

-   Filter the penguins data in order to have only the observations (rows) from female penguins.

-   Create a boxplot using the *ggpubr* package.

-   Add the multiple group comparison

-   Add pairwise comparisons between all groups combinations

<details>
<summary>
Hints (click here)
</summary>

<br>

-   Use the [`filter()`](https://rdrr.io/r/stats/filter.html) function to select desired rows

-   Filter by `sex == "female"`

-   Use [`ggboxplot()`](https://rpkgs.datanovia.com/ggpubr/reference/ggboxplot.html) function for the base plot

-   Use the [`stat_compare_means()`](https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html) function for multiple group comparison

-   Use the `comparison` argument to add pairwise comparison

</details>
<details>
<summary>
Solution (click here)
</summary>

<br>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># Filtering by sex</span>
<span class='nv'>penguins_exc2</span> <span class='o'>&lt;-</span> <span class='nv'>penguins</span> <span class='o'>%&gt;%</span> 
  <span class='c'># Filter by species and island</span>
  <span class='nf'><a href='https://rdrr.io/r/stats/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>sex</span> <span class='o'>==</span> <span class='s'>"female"</span><span class='o'>)</span>

<span class='c'># Creating the base plot</span>
<span class='nv'>exc2_plot</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/ggboxplot.html'>ggboxplot</a></span><span class='o'>(</span>data <span class='o'>=</span> <span class='nv'>penguins_exc2</span>,
                       x <span class='o'>=</span> <span class='s'>"species"</span>,
                       y <span class='o'>=</span> <span class='s'>"bill_depth_mm"</span>,
                       fill <span class='o'>=</span> <span class='s'>"species"</span><span class='o'>)</span>

<span class='c'># Adding the multiple group comparison</span>
<span class='nv'>exc2_plot</span> <span class='o'>&lt;-</span> <span class='nv'>exc2_plot</span> 

<span class='c'># Creating the pairwise comparison</span>
<span class='nv'>exc2_comparison</span> <span class='o'>&lt;-</span>  <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Adelie"</span>, <span class='s'>"Chinstrap"</span><span class='o'>)</span>,
                         <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Chinstrap"</span>, <span class='s'>"Gentoo"</span><span class='o'>)</span>,
                         <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Adelie"</span>, <span class='s'>"Gentoo"</span><span class='o'>)</span><span class='o'>)</span>

<span class='nv'>exc2_plot</span> <span class='o'>&lt;-</span> <span class='nv'>exc2_plot</span> <span class='o'>+</span>
  <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html'>stat_compare_means</a></span><span class='o'>(</span>comparisons <span class='o'>=</span> <span class='nv'>comparison_list</span><span class='o'>)</span> <span class='o'>+</span>
  <span class='nf'><a href='https://rpkgs.datanovia.com/ggpubr/reference/stat_compare_means.html'>stat_compare_means</a></span><span class='o'>(</span>label.y <span class='o'>=</span> <span class='m'>25</span><span class='o'>)</span>

<span class='nv'>exc2_plot</span>
</code></pre>
<img src="figs/unnamed-chunk-20-1.png" width="700px" style="display: block; margin: auto;" />

</div>

</div>
</div>

<br>

