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
