library(shiny)
library(rCharts)
library(rMaps)
shinyServer(function(input, output,session) {
    dinput <- reactive({switch(input$var1,,"stage1"= s1,"stage2"= s2,"stage3"= s3,"stage4"= s4,
    "stage5"= s5,"stage6"= s6,"stage7"=s7,"stage8"= s8,"stage9"= s9,"stage10"= s10,"stage11"= s11,
    "stage12"= s12,"stage13"= s13,"stage14"= s14,"stage15"= s15,"stage16"= s16,"stage17"= s17,
    "stage18a"= s18a,"stage18b"= s18b,"stage19"= s19,"stage20"=s20,"stage21"= s21,"stage22a"= s22a,
    "stage22b"= s22b,"stage23a"= s23a,"stage23b"= s23b,"stage24"= s24,"stage25"= s25,"stage26"= s26,
    "stage27a"= s27a,"stage27b"= s27b,"stage28a"= s28a,"stage28b"= s28b,"stage29"= s29,"stage30"= s30,
    "stage31"= s31,"stage32"= s32,"stage33"= s33)})
    output$text1 <- renderText({s$name[s$id == input$var1]})
    output$text2 <- renderText({input$var2})
    output$plot1 <- renderChart({
        di<-dinput()
        m2<-mPlot(x='index',y='alt', type = "Line", data = di)
        m2$set(pointSize = 0, lineWidth = 1)
        m2$set(hoverCallback = "#! function(index, options, content){
        var row = options.data[index]
        return '<b>' + 'Altitude' + '</b>' + '<br/>' +
        'alt: ' + row.alt + '<br/>' 
        } !#")  
        m2$set(dom='plot1')
        return(m2)
    })        
    output$mapPlot <- renderUI({
        map1 = Leaflet$new()
        map1$tileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png")
        map1$addKML('leaflet/paths.kml')
        for (i in (1:dim(ps)[1])) {
        map1$marker(c(ps[i,3], ps[i,2]), bindPopup = ps[i,1])
        }
        HTML(map1$html(chartId = "mapPlot"))
    })
     output$tab1 <- renderTable({
        df1=subset(cam, index >= cam$index[cam$Site == input$var2])[,1:2]
        df1[1,2]<-0
        colnames(df1)<-c('Name','Distance (Km)')
        return(df1)
    })     
     output$tab2 <- renderTable({
        g=cam$Total[cam$Site == input$var2]
        df2<-data.frame('from'= g, 'to'= (sum(cam$Partial)-g))
        colnames(df2)<-c('Distance from Saint Jean (Km)','Distance to Santiago (Km)')
    return(df2)
    })        
  })
