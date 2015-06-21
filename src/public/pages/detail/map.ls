$ !->
  lng = parse-float ($ '#lng' .val!)
  lat = parse-float ($ '#lat' .val!)
  lnglatXY = new AMap.LngLat lng,lat
  amap = new AMap.Map 'mapContainerSmall', {
    view: new AMap.View2D {
      center: lnglatXY
      zoom: 20
    }
  }
  marker = new AMap.Marker {
    map: amap
    position: lnglatXY
    icon: "/images/0.png"
    # offset: new AMap.Pixel -43,-17
  }
  amap.setFitView!

  showBMap = !->
    bmap = new AMap.Map 'mapContainerBig',{
      view: new AMap.View2D {
        center: lnglatXY
        zoom: 20
      }
    }
    bmarker = new AMap.Marker {
      map: bmap
      position: lnglatXY
      icon: "/images/0.png"
      # offset: new AMap.Pixel -43,-17
    }
    bmap.setFitView!
    geolocation = null
    toolBar = null
    scale = null
    overView = null
    bmap.plugin ['AMap.Geolocation', 'AMap.ToolBar', 'AMap.Scale', 'AMap.OverView'], !->
      geolocation := new AMap.Geolocation {
        enableHighAccuracy: true  
        timeout: 10000  
        maximumAge: 0 
        convert: true 
        showButton: true  
        buttonPosition: 'LB'  
        buttonOffset: new AMap.Pixel(23, 75)  
        showMarker: true  
        showCircle: true  
        panToLocation: true 
        zoomToAccuracy: true  
      }
      bmap.addControl geolocation
      
      toolBar := new AMap.ToolBar! 
      bmap.addControl toolBar
    
      scale := new AMap.Scale!
      bmap.addControl scale
      
      overView := new AMap.OverView!
      bmap.addControl overView
    # 根据经纬度搜索并且显示信息窗体
    

  # 将大地图定位到中央
  do locate-map-wrap = !->
    map-wrap = $ '#map_wrap'
    $ '#map_layout' .css {  # 定灰底层大小
      height: $ document .height!
      width:  $ document .width!
    }
    $ '#map_wrap' .css {   # 定大地图位置
      left: ($ window .width! - map-wrap.outer-width!)/2
      top:  ($ window .height! - map-wrap.outer-height!)/2 + $ document .scroll-top!
    }

  $ window .resize !->
    locate-map-wrap!

  $ '.big_map' .click (e)!->
    e.preventDefault!
    showBMap!
    $ '#map_layout' .fade-in!
    $ '#map_wrap' .fade-in!
  $ '.close' .click !->
    $ '#map_layout' .fade-out!
    $ '#map_wrap' .fade-out!
