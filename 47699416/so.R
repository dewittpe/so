Without access to the files noted in your question I'll present examples using 

    mtcars_1 <- mtcars[-1, ][, -1]
    mtcars_2 <- mtcars[-2, ][, -2]

    # common column names
    intersect(names(mtcars_1), names(mtcars_2))

    # columns names only in mtcars_0 and not in mtcars_2
    setdiff(names(mtcars_1), names(mtcars_2))

    # columns only in mtcars_2 and not in mtcars_1 
    setdiff(names(mtcars_2), names(mtcars_1))

To get the varaibles absent in `data.x` with respect to `data.y` you would use
`setdiff(data.y, data.x)`
# 
If you are looking for the *rows* of `data.x` that are not in `data.y` consider using the 
`anti_join` and/or `semi_join` functions form the [dplyr](https://cran.r-project.org/package=dplyr) package

>
>     ‘semi_join()’ return all rows from ‘x’ where there are matching
>          values in ‘y’, keeping just columns from ‘x’.
>
>          A semi join differs from an inner join because an inner join
>          will return one row of ‘x’ for each matching row of ‘y’, where a
>          semi join will never duplicate rows of ‘x’.
>
>     ‘anti_join()’ return all rows from ‘x’ where there are not matching
>          values in ‘y’, keeping just columns from ‘x’.

    dplyr::semi_join(mtcars_1, mtcars_2)
    dplyr::semi_join(mtcars_2, mtcars_1)

    dplyr::anti_join(mtcars_1, mtcars_2)
    #   cyl disp  hp drat    wt  qsec vs am gear carb
    # 1   6  160 110  3.9 2.875 17.02  0  1    4    4

    dplyr::anti_join(mtcars_2, mtcars_1)
    #   mpg disp  hp drat   wt  qsec vs am gear carb
    # 1  21  160 110  3.9 2.62 16.46  0  1    4    4

