
# visualizacion_piramide_poblacion
Hace poco tuve la inquietud sobre de cómo generar una pirámide de población y claro que buscando en Google encontré varios ejemplos; todos muy parecidos pero que de alguna manera eran ejemplos a modo. Es decir, con tablas que ya tenían la información procesada y que muchas veces ya no estaban disponibles para su descarga por razones variadas.

Para mi grata sorpresa encontre una página (https://community.rstudio.com/t/ggplot2-alter-scale-on-pyramid-plot/14934) en la que se muestra el siguiente ejemplo:

 ```{r setup,echo=T}
df <- tibble(
 Population = c(5, 8.7, 16.7, 24.8, 38, -4.6, -6.4, -16.1, -39.6, -55.3),
 Gender = c("Male", "Male", "Male", "Male", "Male", "Female", "Female", "Female", "Female", "Female"),
 Age = c("65-69", "70-74", "75-79", "80-84", "85+", "65-69", "70-74", "75-79", "80-84", "85+"))
  
```

Esta tabla tiene un arreglo especial, que es el que se usa para generar la gráfica de pirámide, y cuyo código es el siguiente:  ```$\alpha$```

**Population** | **Gender** | **AgeBand**|
---------------|------------|------------|
 5    |Male   |65-69  
 8.7  |Male   |70-74  
16.7  |Male   |75-79  
  24.8  |Male   |80-84  
  38   |Male   |85+    
  -4.6  |Female |65-69  
  -6.4  |Female |70-74  
  -16.1 |Female |75-79  
  -39.6 |Female |80-84  
  -55.3 |Female |85+    


 ```{r setup,echo=T}
library(ggplot2)  
grafica <- ggplot(df, aes(x = Age, y = Population, fill = Gender)) +
            geom_bar(stat = "identity") +
            coord_flip() +
            theme_minimal() +
            labs(y = "Count", x = "Age Band", title = " ") +
            scale_fill_manual(values = c("pink", "blue"))

grafica
```
 
![piramide01](https://user-images.githubusercontent.com/65984679/114253465-f2459c80-996f-11eb-85b8-abca629029b2.jpeg)

 
Eureka!!! Solo me hacía falta procesar la tabla que yo tenía para llegar al formato de arriba y es lo que pueden desacargar en los scripts.
