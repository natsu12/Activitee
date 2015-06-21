$ !->
  $ '#inputTime' .datetimepicker!
  input = $ '.bootstrap-tagsinput > input'
  input .attr "readonly", "readonly"
  $ '.btn-addTag' .each !->
    ($ @).click !->
      /* will be wrong if there are more than one input */
      input.val input.val! + ($ @).text!
      press = jQuery.Event("keypress");
      press.ctrlKey = false;
      press.which = 13;
      input.trigger press

  $ '#inputPlace' .keyup (e)!->
    console.log e.which
    auto-search!  

  
  amap = new AMap.Map 'mapContainer', {
    resizeEnable: true
    # clickable: true
    view: new AMap.View2D {
      # center: new AMap.LngLat 116.397428, 39.90923
      zoom: 12
    }
    keyboardEnable: false
  }

  
  geolocation = null
  toolBar = null
  amap.plugin ['AMap.Geolocation', 'AMap.ToolBar'], !->
    geolocation := new AMap.Geolocation {
      enableHighAccuracy: true  
      timeout: 10000  
      maximumAge: 0 
      convert: true 
      showButton: true  
      buttonPosition: 'LB'  
      buttonOffset: new AMap.Pixel(10, 20)  
      showMarker: true  
      showCircle: true  
      panToLocation: true 
      zoomToAccuracy: true  
    }
    amap.addControl geolocation

    
    toolBar := new AMap.ToolBar! 
    amap.addControl toolBar
  
  
  auto-search = !->
    keywords = ($ '#inputPlace' .val!)
    
    var auto
    AMap.service ['AMap.Autocomplete'],!->
      autoOptions = {
        city: "" 
      }
      auto := new AMap.Autocomplete autoOptions
      
      if keywords.length > 0
        auto .search keywords,(status,result)!->
          autocomplete_CallBack result
      else
        $ '#mapResult' .add-class 'disappear'

  selectResult = (index)->
    return if index < 0
    if navigator.user-agent.index-of 'MSIE' > 0
      $ '#inputPlace' .on 'propertychange',null
      $ '#inputPlace' .focus focus_callback
    text = $ ('#divid'+(index)) .html!.replace /<[^>].*?>.*<\/[^>].*?>/g,""
    divid = '#divid' + (index)
    cityCode = $(divid) .attr 'data'
    $ '#inputPlace' .val text
    $ '#mapResult' .remove-class 'appearBlock' .add-class 'disappear'
    
    amap.plugin ["AMap.PlaceSearch"],!->
      msearch = new AMap.PlaceSearch! 
      AMap.event.addListener msearch, "complete", placeSearch_CallBack 
      msearch.setCity cityCode
      msearch.search text 

  
  autocomplete_CallBack = (data)!->
    resultStr = ""
    tipArr = data.tips
    if tipArr && tipArr.length > 0
      for tip,index in tipArr
         # onmouseover='openMarkerTipById("+(index+1)+",this)'  onmouseout='onmouseout_MarkerStyle(" + (index + 1) + ",this)'  
        resultStr += "<div id='divid" + (index+1) + "' class='divid' index=" +(index)+" style=\"font-size:13px;cursor:pointer;padding:5px 5px 5px 5px;\"" + "data=" + tip.adcode + ">" + tip.name + "<span style='color:\#C1C1C1;'>"+tip.district + "</span></div>"
    else
      resultStr = "π_π亲,人家找不到结果!<br />要不试试:<br />1.请确保所有字词拼写正确<br />2.尝试不同的关键字<br />3.尝试更多宽泛的关键字"
    $ '#mapResult' .curSelect = -1
    $ '#mapResult' .tipArr = tipArr
    $ '#mapResult' .html resultStr

    $ '.divid' .mouseover (e)!->
      $(e.target) .remove-class 'noselected' .add-class 'selected'
    $ '.divid' .mouseout (e)!->
      $(e.target) .remove-class 'selected' .add-class 'noselected'
    $ '.divid' .click (e)!->
      selectResult parseInt $(e.target)[0].id.replace 'divid',''

    $ '#mapResult' .remove-class 'disappear' .add-class 'appearBlock'

  
  focus_callback = !->
    $ '#inputPlace' .on 'propertychange',auto-search if navigator.user-agent.index-of 'MISE' > 0

  windowsArr = []
  marker = []
  
  placeSearch_CallBack = (data)->
   
    windowsArr := []
    marker := []
    amap.clearMap!
    resultStr1 = ""
    poiArr = data.poiList.pois
    for poi,index in poiArr
      resultStr1 += "<div id = 'divid" + (index+1) + "' onmouseover='openMarkerTipById1(" + index+ ",this)' onmouseout='onmouseout_MarkerStyle(" + (index+1) + ",this' style=\"font-size: 12px;cursor:pointer;padding:0px 0 4px 2px;border-bottom:1px solid \#C1FFC1;\"><table><tr><td><img src=\"http://webapi.amap.com/images/>" + (index+1) + ".png\"></td>" + "<td><h3><font color=\"#00a6ac\">Ãû³Æ: " + poi.name + "</font></h3>" + TipContents(poi.type, poi.address, poi.tel) + "</td></tr></table></div>"
      addmarker index,poi
    amap.setFitView!

 
  TipContents = (type,address,tel)->
    type = "暂无" if type == "" || type == "undefined" || type == null || type == " undefined" || typeof type == "undefined"
    address = "暂无" if address == "" || address == "undefined" || address == null || address == " undefined" || typeof address == "undefined"
    tel = "暂无" if tel == "" || tel == "undefined" || tel == null || tel == " undefined" || typeof address == "tel"
    str = "地址: " + address + "<br />  电话: " + tel + " <br />  类型: " + type;
    return str

  
  addmarker = (i,d)->
    lngX = d.location.getLng!
    latY = d.location.getLat!
    markerOption = {
      map:amap
      icon: "http://webapi.amap/com/images/" + (i + 1) + ".png"
      position: new AMap.LngLat lngX,latY
    }
    mar = new AMap.Marker markerOption
    marker.push (new AMap.LngLat lngX,latY)

    infoWindow = new AMap.InfoWindow {
      content: "<h3><font color=\"#00a6ac\">  " + (i + 1) + ". " + d.name + "</font></h3>" + TipContents(d.type, d.address, d.tel)
      size: new AMap.Size 300,0
      autoMove: true
      offset: new AMap.Pixel 0,-30
    }
    windowsArr.push infoWindow
    showInfoWindow = (e)->
      infoWindow.open amap, mar.getPosition!
    AMap.event.addListener mar,'mouseover',showInfoWindow
    locateActivity = (e)->
      # lnglatXY = new AMap.LngLat e.lnglat.lng,e.lnglat.lat
      # AMap.service ["AMap.Geocoder"],!->
      #   MGeocoder = new AMap.Geocoder {
      #     radius: 100
      #     extensions: "all"
      #   }

      #   MGeocoder.getAddress lnglatXY,(status,result)!->
      #     if status === 'complete' and result.info === 'OK'
      #       $ '#inputPlace' .val result.regeocode.formattedAddress
      content = infoWindow.getContent!
      content = content.replace /<h3><font color="#00a6ac">\s*\d.\s*/g, ''
      content = content.replace /<\/font>.*/g,''
      console.log content
      $ '#inputPlace' .val content
      # content.replace 
      $ '#lng' .val e.lnglat.lng
      $ '#lat' .val e.lnglat.lat
    
    AMap.event.addListener mar,'click',locateActivity

