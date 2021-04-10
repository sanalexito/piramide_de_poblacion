# visualizacion_piramide_poblacion
Hace poco tuve la inquietud acerca de cómo generar una pirámide de población. Buscando en Google encontré varios ejemplos muy parecidos pero que de alguna manera eran ejemplos a modo. Es decir, con tablas que ya tenían la información procesada y, que muchas veces no estaban disponibles para su descarga por razones variadas.

Para mi grata sorpresa encontre una página (https://community.rstudio.com/t/ggplot2-alter-scale-on-pyramid-plot/14934) en la que se muestra el siguiente ejemplo:

df <- tibble(
 Population = c(5, 8.7, 16.7, 24.8, 38, -4.6, -6.4, -16.1, -39.6, -55.3),
 Gender = c("Male", "Male", "Male", "Male", "Male", "Female", "Female", "Female", "Female", "Female"),
 Age = c("65-69", "70-74", "75-79", "80-84", "85+", "65-69", "70-74", "75-79", "80-84", "85+"))
