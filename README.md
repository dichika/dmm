# dmm
For using DMM.com API from R.

See the [reference](https://affiliate.dmm.com/api/reference/r18/digital/all/) for detail.

## example

- search and count

```r
getCount("検索ワード")
```

- search and get information about items
Now, we implemented for just title, date and price.
```r
getItemInfo("検索ワード")
```
