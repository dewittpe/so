You need to be careful that the generated indexes do not include negative
values.  For example, if a 'h' is in row 3, then only rows 1, 2, and 3 need to
be set to NA.  `df[3 -0:4, ] <- NA` will no generate the needed result.

For this example, we will generate a data.frame `df1` and a second copy,
`df2`, to make it easy to compare the results.  Notice that in column 'a'
there is an 'h' in row 2.

    set.seed(2)
    df1 <- df2 <-
      data.frame(a = letters[sample(10,26,replace = T)],
                 b = c(letters[1:25],NA),
                 c = c(letters[25:1],NA))
    df1
    #    a    b    c
    # 1  b    a    y
    # 2  h    b    x
    # 3  f    c    w
    # 4  b    d    v
    # 5  j    e    u
    # 6  j    f    t
    # 7  b    g    s
    # 8  i    h    r
    # 9  e    i    q
    # 10 f    j    p
    # 11 f    k    o
    # 12 c    l    n
    # 13 h    m    m
    # 14 b    n    l
    # 15 e    o    k
    # 16 i    p    j
    # 17 j    q    i
    # 18 c    r    h
    # 19 e    s    g
    # 20 a    t    f
    # 21 g    u    e
    # 22 d    v    d
    # 23 i    w    c
    # 24 b    x    b
    # 25 d    y    a
    # 26 e <NA> <NA>

use `lapply` to find the row indexes within each column where an 'h' occurs

    h_idx <- lapply(df1, function(x) which(x == "h"))
    # $a
    # [1]  2 13
    # 
    # $b
    # [1] 8
    # 
    # $c
    # [1] 18


using `lapply` again, we build the row indexes to set to `NA` in each of the
columns.  Notice that the `seq` call starts from a max of the index minus four
and 1, this will prevent negative or zero indexes being called.

    na_idx <- lapply(h_idx,
                     function(x) {
                       lapply(x, function(xx) {seq(max(c(xx - 4, 1)), xx, by = 1) })
                     })
    na_idx
    # $a
    # $a[[1]]
    # [1] 1 2
    # 
    # $a[[2]]
    # [1]  9 10 11 12 13
    # 
    # 
    # $b
    # $b[[1]]
    # [1] 4 5 6 7 8
    # 
    # 
    # $c
    # $c[[1]]
    # [1] 14 15 16 17 18

for each column, set the needed rows to NA

    for(cl in seq_along(df2)) {
      for (rws in na_idx[[cl]]) {
        df2[rws, cl] <- NA
      }
    }


The result

    cbind(df1, df2)
    #    a    b    c    a    b    c
    # 1  b    a    y <NA>    a    y
    # 2  h    b    x <NA>    b    x
    # 3  f    c    w    f    c    w
    # 4  b    d    v    b <NA>    v
    # 5  j    e    u    j <NA>    u
    # 6  j    f    t    j <NA>    t
    # 7  b    g    s    b <NA>    s
    # 8  i    h    r    i <NA>    r
    # 9  e    i    q <NA>    i    q
    # 10 f    j    p <NA>    j    p
    # 11 f    k    o <NA>    k    o
    # 12 c    l    n <NA>    l    n
    # 13 h    m    m <NA>    m    m
    # 14 b    n    l    b    n <NA>
    # 15 e    o    k    e    o <NA>
    # 16 i    p    j    i    p <NA>
    # 17 j    q    i    j    q <NA>
    # 18 c    r    h    c    r <NA>
    # 19 e    s    g    e    s    g
    # 20 a    t    f    a    t    f
    # 21 g    u    e    g    u    e
    # 22 d    v    d    d    v    d
    # 23 i    w    c    i    w    c
    # 24 b    x    b    b    x    b
    # 25 d    y    a    d    y    a
    # 26 e <NA> <NA>    e <NA> <NA>
