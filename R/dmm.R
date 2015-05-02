#' @export
getCount <- function(keyword, api_id=options()$DMM_API_ID,affiliate_id=options()$DMM_AFF_ID,
                             site="DMM.co.jp", service="digital"){
  u <- sprintf("http://affiliate-api.dmm.com/?api_id=%s&affiliate_id=%s&operation=ItemList&version=2.00&timestamp=%s&site=%s&service=%s&hits=1&keyword=%s",
               api_id,
               affiliate_id,
               RCurl::curlEscape(format(Sys.time(), "%Y-%m-%d %H:%M:%S")),
               site,
               service,
               RCurl::curlEscape(iconv(keyword, to="EUC-JP"))
  )
  res <- httr::GET(u)
  res_text <- httr::content(res, "text")
  res_xml <- xml2::read_xml(res_text)
  data.frame(
    count = xml2::xml_text(xml2::xml_find_all(res_xml, "./result/total_count")),
    stringsAsFactors=FALSE
  )
  
}

#' @export
getItemInfo <- function(keyword, api_id=options()$DMM_API_ID,affiliate_id=options()$DMM_AFF_ID,
                    site="DMM.co.jp", service="digital", hits=100, offset=1){
  u <- sprintf("http://affiliate-api.dmm.com/?api_id=%s&affiliate_id=%s&operation=ItemList&version=2.00&timestamp=%s&site=%s&service=%s&hits=%s&offset=%s&keyword=%s",
               api_id,
               affiliate_id,
               RCurl::curlEscape(format(Sys.time(), "%Y-%m-%d %H:%M:%S")),
               site,
               service,
               hits,
               offset,
               RCurl::curlEscape(iconv(keyword, to="EUC-JP"))
  )
  res <- httr::GET(u)
  res_text <- httr::content(res, "text")
  res_xml <- xml2::read_xml(res_text)
  data.frame(
    title = xml2::xml_text(xml2::xml_find_all(res_xml, "./result/items/item/title")),
    date = xml2::xml_text(xml2::xml_find_all(res_xml, "./result/items/item/date")),
    price = xml2::xml_text(xml2::xml_find_all(res_xml, "./result/items/item/prices/price")),
    maker = xml2::xml_text(xml2::xml_find_all(res_xml, "./result/items/item/iteminfo/maker/name")),
    actress = xml2::xml_text(xml2::xml_find_all(res_xml, "./result/items/item/iteminfo/actress[1]/name")),
    actress_id = xml2::xml_text(xml2::xml_find_all(res_xml, "./result/items/item/iteminfo/actress[1]/id")),
    stringsAsFactors=FALSE
  )  
}
