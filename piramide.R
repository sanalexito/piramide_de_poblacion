#Descargar las bases de la ENAID y hace una pirámide de población. 
#liga INEGI
url<-"https://www.inegi.org.mx/contenidos/programas/enaid/2016/microdatos/enaid2016_bd_dbf.zip"

#Descarga el ZIP en dir
download.file(url,destfile = "dir/dataset.zip",mode = "wb")

#Descomprime
unzip(zipfile = "dir/dataset.zip", 
      exdir = "dir/bases_ENAID") #Esta carpeta llamada "bases_ENAID" debes crearla 

#Se cargan las bases que vienen en formato dbf
#install.package("foreign")
library(foreign)

#Renombro la base como t7
t7<-read.dbf("D:/Varios/medioambiente/demografia/bases_ENAID/ENAID_CS.dbf")
#Se hace la variable GENDER usando como referencia SEXO
t7$GENDER<-ifelse(t7$SEXO%in%1,"Male","Female")

#Nos quedamos con la variable de edad quitando los códigos 98, 99 y NA. 
class(t7$EDAD)
t7<-t7[!t7$EDA%in%c("98","99",NA),]

#Se hace la reclasificación de la variable edad definiendo "D_edad"
t7[t7$EDA%in%paste0("0",0:4),'D_edad'] <- paste0("00",'-',"04 años")
t7[t7$EDA%in%paste0("0",5:9),'D_edad'] <- paste0("05",'-',"09 años")
for(i in 2:20){
  k <- 5*i -5
  eval(parse(text = paste0("
  t7[t7$EDA%in%c(",k,":(",k,"+4)),'D_edad'] <- paste0(",k,",'-',",k+4,",'años')
  ")))}

#Separo en dos dataframe
df1<-t7[t7$GENDER%in%"Male",c("GENDER","D_edad")]
df1<-as.data.frame(tapply(df1$GENDER%in%"Male",df1$D_edad,length))
df1<-cbind(rownames(df1),df1)
colnames(df1)<-c("Age","Population")
df1$GENDER<-"Male"

df2<-t7[t7$GENDER%in%"Female",c("GENDER","D_edad")]
df2<-as.data.frame(tapply(df2$GENDER%in%"Female",df2$D_edad,length))
df2<-cbind(rownames(df2),df2)
colnames(df2)<-c("Age","Population")
df2$GENDER<-"Female"

#se combinan los dataframes
df<-as.data.frame(rbind(df1,df2))

#para que a gráfica de pirámide tenga su forma se multiplica por -1
df$Population<-ifelse(df$GENDER%in%"Female",-1*df$Population,df$Population)

 
#Código para hacer la gráfica de pirámide
ggplot(df, aes(x = Age, y = Population, fill = GENDER)) +
  geom_bar(stat = "identity",) +
  scale_y_continuous(breaks = seq(-3000, 3000, 500), 
                     labels = paste0(as.character(c(seq(30, 0, -5), seq(5, 30, 5))), "m"))+
  coord_flip() +
  theme_minimal() +
  labs(y = "Población", x = "Edad", title = "Pirámide de población", caption="Fuente: ENAID 2016, INEGI. \nAgrupado por edades.") +
  scale_fill_manual(values = c("red", "blue"))

