<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>레이아웃</title>
    <script src="https://kit.fontawesome.com/63ed9e5411.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <!-- jquery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- openlayers -->
    <link rel="stylesheet" href="https://openlayers.org/en/v4.6.5/css/ol.css" type="text/css">
    <script src="https://openlayers.org/en/v4.6.5/build/ol.js"></script>
    <style>
        main{            
            margin: 0 auto;
            width: 1500px;
        }
        .map {
            width: 100%;
            height: 850px;
        }
        #left{
            background-color: rgb(230, 229, 229);
            width: 350px;
            height: 850px;
            float: left;
            text-align: center;
        }
        #right{
            width: 1100px;
            height: 850px;
            float: left;
        }
        .roundbox{
            margin: 0 auto;
            width: 300px;
            background-color: white;
            border-radius: 20px;
            
        }
        #box1{
            height: 100px;
            display : flex;
            justify-content: center;
            align-items : center;
        }
        #carlist{
            padding-top: 20px;
            padding-bottom: 20px;
        }
        .textbox{
            border: none;
        }
        #close{
            border:none;
            background-color: transparent;
            margin-left: 200px;            
        }
        #selectcar{
            padding-top: 20px;
            padding-bottom: 20px;
        }
        #toptext{
            padding-top: 20px;            
        }
        #resbox{
            margin-right: 100px;     
        }
        #currentDate{
            width: 190px;
            height: 35px;
        }
        #datetext{
            margin-right: 190px;   
        }
        #selectcarlist{
            margin-right: 100px;
        }        
        .carbtn{
            border: none;
            background-color: transparent;
        }
        .carbtn:hover{
            background-color: rgb(240, 240, 240);
        }
    </style>    
</head>
<body>
    <main>
        <div id='left'>
            <div id='toptext'>
                <p><img src="/images/egovframework/example/yongin.svg" alt="yonginsi logo" style='height: 50px; width: 50px;'> <b>용인시 청소차 관제 시스템</b></p>
            </div>            
            <hr>
            <br>
            <div class='roundbox' id='box1'>
                <i class="fa-solid fa-map-location-dot fa-xl" style='padding-right: 10px;'></i>
                <div class="btn-group" role="group" aria-label="Basic outlined example">
                    <button type="button" class="btn btn-outline-primary" id='base_button'>기본</button>
                    <button type="button" class="btn btn-outline-primary" id='sate_button'>위성</button>
                    <button type="button" class="btn btn-outline-primary" id='hybrid_button'>하이브리드</button>
                </div>
            </div>
            <br>
            <div class='roundbox' id='box2'>
                <div id='carlist'>
                    <h5><b>차량 목록</b></h5> 
                    <hr>
                    <div id='selectcarlist'>
                        <p><i class="fa-solid fa-truck"></i> <button value='12가 1234' class='carbtn' onclick='selectcar()'>12가 1234</button></p>
                        <p><i class="fa-solid fa-truck"></i> <button value='12가 1234' class='carbtn'>12가 1234</button></p>
                    </div>
                </div>                       
            </div>
            <br>
            <div class='roundbox' id='box3'>
                <div id='selectcar'>
                    <h5><b>12가 1234(변수)</b></h5> 
                    <hr>
                    <p>
                        <span id='datetext'>날짜선택 :</span>
                        <br>
                        <form>
                            <input type="date" id='currentDate'>
                            <input type="submit" value="확인" class='btn btn-outline-primary'>
                        </form>
                    </p>
                    <hr>
                    <div id='resbox'>
                        <p>운행 시간 : <b>변수줄거야</b></p>
                        <p>청소 비율 : <b>변수줄거야</b></p>
                    </div>
                    <hr>
                    <button id='close'>접기</button>
                </div>
            </div>
        </div>
        <div id='right'>
            <div id='map' class="map"></div>
        </div>
    </main>
    
    <script>
        /*
           http://openlayers.org/en/latest/examples/wmts-layer-from-capabilities.html?q=WMTSCapabilities
        */
        
        var VworldBase,VworldSatellite,VworldGray,VworldMidnight,VworldHybrid;
        var attr = '&copy; <a href="http://dev.vworld.kr">vworld</a>';
        var VworldHybrid = new ol.source.XYZ({
           url: 'https://api.vworld.kr/req/wmts/1.0.0/1BED7823-51FA-30E5-8664-4B59FDCC983E/Hybrid/{z}/{y}/{x}.png'
        }); //문자 타일 레이어
        
        var VworldSatellite = new ol.source.XYZ({
           url: 'https://api.vworld.kr/req/wmts/1.0.0/1BED7823-51FA-30E5-8664-4B59FDCC983E/Satellite/{z}/{y}/{x}.jpeg'
           ,attributions : attr
        }); //항공사진 레이어 타일
     
        var VworldBase = new ol.source.XYZ({
           url: 'https://api.vworld.kr/req/wmts/1.0.0/1BED7823-51FA-30E5-8664-4B59FDCC983E/Base/{z}/{y}/{x}.png'
           ,attributions : attr
        }); // 기본지도 타일      
        /*
           control 설정
        */
        
         var element = document.createElement('div');
         element.className = 'rotate-north ol-unselectable ol-control ol-mycontrol';
         
         base_button.onclick=function(){
             map.getLayers().forEach(function(layer){
              if(layer.get("name")=="vworld"){              
                
                 layer.setSource(VworldBase)
              }
            })
         }
         sate_button.onclick=function(){
             map.getLayers().forEach(function(layer){
              if(layer.get("name")=="vworld"){
                 layer.setSource(VworldSatellite)
              }
            })
         }
         hybrid_button.onclick=function(){
            var _this = this;
              map.getLayers().forEach(function(layer){
                 if(layer.get("name")=="hybrid"){
                    if(_this.className == "on"){
                     layer.setSource(null)
                     _this.className ="";
                    }else{
                       _this.className ="on";
                       
                       layer.setSource(VworldHybrid)
                    }
                 }
               })
         }
         
         var layerControl = new ol.control.Control({element: element});
            
        map = new ol.Map({
           controls: ol.control.defaults().extend([
              layerControl,new ol.control.OverviewMap(),new ol.control.ZoomSlider()
           ]),
           layers: [
              
              new ol.layer.Tile({
                 source: VworldSatellite,
                 name:"vworld"
              }),new ol.layer.Tile({
                 source: VworldHybrid,
                 name:"hybrid"
              })
           ],
           target: 'map',
           view: new ol.View({
              center: ol.proj.transform([127.1775537, 37.2410864], 'EPSG:4326', 'EPSG:900913'),
              zoom: 10,
              minZoom : 0,
              maxZoom : 21
           })
        });
     
        // 추가한 레이어
        var boundary = new ol.layer.Tile({
             source: new ol.source.TileWMS({
                 //Vworld Tile 변경
                 url: 'http://localhost:8080/geoserver/yongin/wms',
                 params: {
                 'layers' : 'yongin:경기도한번더',
                 'tiled' : 'true'
                 },
                 serverType: 'geoserver'
             })
          })
     
          var link = new ol.layer.Tile({
             source: new ol.source.TileWMS({
                 //Vworld Tile 변경
                 url: 'http://localhost:8080/geoserver/yongin/wms',
                 params: {
                 'layers' : 'yongin:Line',
                 'tiled' : 'true'
                 },
                 serverType: 'geoserver'
             })
          })
     
          var node = new ol.layer.Tile({
             source: new ol.source.TileWMS({
                 //Vworld Tile 변경
                 url: 'http://localhost:8080/geoserver/yongin/wms',
                 params: {
                 'layers' : 'yongin:Point',
                 'tiled' : 'true'
                 },
                 serverType: 'geoserver'
             })
          })
         
          map.addLayer(boundary);
          map.addLayer(link);
          map.addLayer(node);
         </script>

    <script>document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>
</html>
