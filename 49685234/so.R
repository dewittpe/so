vTable <- structure(list(Item = c("Item 4", "Item C", "Item_A", "Item_B", 
"Item_B_raw"), Vendors = structure(list(`1` = c("Vendor 3", "Vendor_1", 
"Vendor_2", "Vendor4"), `2` = c("Vendor4", "Vendor 3", "Vendor_2", 
"Vendor_1", "Vendor 5."), `3` = c("Vendor 5.", "Vendor4", "Vendor_2"
), `4` = c("Vendor_1", "Vendor4", "Vendor 5."), `5` = c("Vendor_2", 
"Vendor 5.", "Vendor4", "Vendor 3")), .Names = c("1", "2", "3", 
"4", "5"))), .Names = c("Item", "Vendors"), row.names = c(NA, 
-5L), class = "data.frame")

vTable

packageVersion("knitr")

# per @alistaire's comment
vTable2 <- vTable
vTable2$Vendors <- sapply(vTable2$Vendors, toString)
knitr::kable(vTable2)

packageDescription("knitr")
